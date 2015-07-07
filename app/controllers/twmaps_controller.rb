class TwmapsController < ApplicationController
  def show
    if params[:id] != 'millifes2'
      redirect_to root_path
      return
    end
    @millifes_list = []
    return unless current_user
    require 'nkf'

    begin
      list = friend_list
    rescue Twitter::Error::Unauthorized => error
      redirect_to logout_path
      return
    end

    list.each do |friend|
      next unless (NKF.nkf('-wXZ', friend.name) =~ /ミリフェス/)
      m = /P(?<spnum>\d+)(?<spalp>[abAB]+)?/.match(friend.name)
      next if m.nil?

      # for security reason, remote url cannot convert canvas to dataurl...
      require 'open-uri'

      open("public/images/tmp/#{friend.id}", 'wb') do |file|
        file << open(friend.profile_image_url).read
      end

      @millifes_list << { friend: friend, local_icon_url: "tmp/#{friend.id}", space: m['spnum'], alphabet: (m['spalp'].presence || 'ab') }
    end
    @millifes_list.sort! { |a, b| a[:space].to_i <=> b[:space].to_i }
  end

  private
  def friend_list
    access_key = session[:access_token]
    access_secret = session[:access_secret]

    cli = Twitter::REST::Client.new(
      consumer_key:        Settings.twitter.consumer_key,
      consumer_secret:     Settings.twitter.consumer_secret,
      access_token:        access_key,
      access_token_secret: access_secret
    )

    begin
      list = []
      cli.friend_ids.each_slice(100).each do |slice|
        cli.users(slice).each do |friend|
          list << friend
        end
      end
      list
    rescue Twitter::Error::TooManyRequests => error
      []
    end
  end
end
