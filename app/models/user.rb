class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github, :facebook, :twitter, :google_oauth2]

  enum role: {admin: "admin", member: "member"}

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || "#{auth.uid}@example.com" # twitter の場合、Emailがとれないのでなんとかしないといけない
      user.password = Devise.friendly_token[0,20]
      user.role = roles[:admin] # いろいろ面倒なのでとりあえずadminにしておく
      user.name = auth.info.name
    end
  end

end
