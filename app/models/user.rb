class User < ActiveRecord::Base

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider   = auth[:provider]
      user.uid        = auth[:uid]
      user.name       = auth[:info][:name]
      user.avatar_url = auth[:extra][:raw_info][:avatar_url]
    end
  end

end
