# OmniAuth.config.logger = Rails.logger

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
#   provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']
#   provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
#     {
#       :name => "google",
#       :scope => "userinfo.email, userinfo.profile, plus.me, plus.login",
#       :prompt => "select_account"
#     }
# end