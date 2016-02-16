class User < ActiveRecord::Base
  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(provider: auth['provider'], uid: auth['uid'])
    user.username = auth['info']['nickname']
    user.name = auth['info']['name']
    user.email = auth['info']['email']
    user.image_url = auth['info']['image']
    user.token = auth['info']['token']
    # user.image_url = auth['info']['image_url']
    user.save
    user
  end
end
