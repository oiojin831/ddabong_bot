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
    from = User.find_or_create_by(name: params[:user_name])
    to = User.find_or_create_by(name: text[1])

    Ddabong.create(from: from.id, to: to.id)
    return { :text => "#{text[1]}님은 #{params[:user_name]}님으로부터 따봉 하나를 받았습니다.", response_type: "in_channel", }.to_json
  elsif text[0] == "check"
    user = User.find_or_create_by(name: text[1])
    p user
    dda = Ddabong.where(to: user.id)
    count = dda.count
    p dda
    p count.to_s
    return { :text => "총 따봉 count.to_s}" }.to_json
  end
end


class User < ActiveRecord::Base
  validates_presence_of :name
end

class Ddabong < ActiveRecord::Base
end
