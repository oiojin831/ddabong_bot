require 'sinatra'
require 'sinatra/activerecord'
require 'json'

set :bind, '0.0.0.0'

get '/' do
  'hello world'
end

post '/ddabong' do
  content_type :json
  text = params[:text].split(" ")
  if text[0] == "give"
    # save data to db
    # check db with name
    p params[:user_name]
    p text[1]
    from = User.find_by(name: params[:user_name])[0]
    to = User.find_by(name: text[1])[0]

    Ddabong.create(from: from.id, to: to.id)
    return { :text => "#{text[1]}님은 #{params[:user_name]}님으로부터 따봉 하나를 받았습니다.", response_type: "in_channel", }.to_json
  elsif text[0] == "create"
    if text[1] == "me"
      u = User.find_or_create_by(name: params[:user_name])[0]
      return { :text => "유저 아이디 #{u.id}, #{params[:user_name]}" }
    else
      u = User.find_or_create_by(name: text[1])[0]
      return { :text => "유저 아이디 #{u.id},#{text[1]}" }
    end
  elsif text[0] == "check"
    if user = User.find_by(name: text[1])[0]
      puts user
      count = Ddabong.where(to: user.id).count
      puts count
      return { :text => "총 따봉 #{count}" }
    end
    return { :text => "노 따봉 맨" }
  end
end


class User < ActiveRecord::Base
  validates_presence_of :name
end

class Ddabong < ActiveRecord::Base
end
