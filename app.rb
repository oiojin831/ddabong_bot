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
    from = User.find_by(name: params[:user_name])
    to = User.find_by(name: text[1])

    Ddabong.create(from: from.id, to: to.id)
    return { :text => "#{text[1]}님은 #{params[:user_name]}님으로부터 따봉 하나를 받았습니다.", response_type: "in_channel", }.to_json
  elsif text[0] == "check"
    if user = User.find_by(name: text[1])
      count = Ddabong.where(to: user.id).count
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
