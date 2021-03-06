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
    from = User.find_or_create_by(name: params[:user_name])
    to = User.find_or_create_by(name: text[1])

    Ddabong.create(from: from.id, to: to.id)
    return {
      text: "#{to.name}님은 #{from.name}님으로부터 따봉 하나를 받았습니다.",
      response_type: "in_channel",
    }.to_json

  elsif text[0] == "check"
    user = User.find_or_create_by(name: text[1])
    if text[1].nil?
      text="---------따봉수-------\n"
      users = User.all
      users.each do |u|
        count = Ddabong.where(to: u.id).count
        text << "#{u.name}: #{count.to_s}\n"
      end

      return {
        text: text,
        response_type: "in_channel",
      }.to_json
    end
    count = Ddabong.where(to: user.id).count

    return {
      text: "총 따봉 #{count.to_s}",
      response_type: "in_channel",
    }.to_json
  end
end


class User < ActiveRecord::Base
  validates_presence_of :name
end

class Ddabong < ActiveRecord::Base
  validate :block_self, on: :create

  def block_self
    errors.add(:customer_id, "is not active") if from == to
  end
end
