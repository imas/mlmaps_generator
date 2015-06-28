class TwitterController < ApplicationController
  before_action :login_required

  def friends
    access_key = session[:access_token]
    access_secret = session[:access_secret]

    cli = Twitter::REST::Client.new(
      consumer_key:        Settings.twitter.consumer_key,
      consumer_secret:     Settings.twitter.consumer_secret,
      access_token:        access_key,
      access_token_secret: access_secret
    )

    @friend_list = []
    begin
      cli.friend_ids.each_slice(100).each do |slice|
        cli.users(slice).each do |friend|
          @friend_list << friend
        end
      end
    rescue Twitter::Error::TooManyRequests => error
      @friend_list = []
    end
  end
end
