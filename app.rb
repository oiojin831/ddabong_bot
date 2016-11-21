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
    return { :text => "#{text[1]}님은 #{params[:user_name]}님으로부터 따봉 하나를 받았습니다.", response_type: "in_channel", }.to_json
  elsif text[0] == "check"
    # save data to db
    # return message
    # return { :text => "검은머리 바보" }.to_json
  end
end


class User < ActiveRecord::Base
  validates_presence_of :name
end
