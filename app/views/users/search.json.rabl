collection @users

attributes :id, :screen_name, :name

node :profile_image_url do |user|
  user.profile_image_url.to_s.gsub('_normal', '_bigger')
end

node :url do |user|
  user_path(user.screen_name)
end
