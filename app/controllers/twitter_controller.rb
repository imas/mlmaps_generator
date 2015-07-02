class TwitterController < ApplicationController
  before_action :login_required

  def friends
    @friend_list = friend_list
  end

  def millimas_friends
    require 'nkf'

    list = friend_list
    @millifes_list = []

    list.each do |friend|
      next unless (NKF.nkf('-wXZ', friend.name) =~ /ミリフェス/)
      m = /P(?<spnum>\d+)(?<spalp>[abAB]+)?/.match(friend.name)
      next if m.nil?
      @millifes_list << { friend: friend, space: m['spnum'], alphabet: (m['spalp'].presence || 'ab') }
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
