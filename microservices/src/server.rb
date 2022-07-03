# Final Project: Quiz Application with Microservices
# Date: 10-Jun-2022
# Author:
#          A01377718 Javier Alexandro Vargas Sánchez
require 'json'
require 'faraday'
require 'sinatra'

set :bind, '0.0.0.0'
set :port, ENV['PORT']
enable :sessions
#This constant holds the API endpoint for the quiz.rb lambda
QUIZ_URL = "https://4yzbykpb3k.execute-api.us-east-1.amazonaws.com/default/lambdaQuiz"
#This constant holds the API endpoint for the leaderboard.rb lambda
LEADERBOARD_URL = "https://984pk2rt4g.execute-api.us-east-1.amazonaws.com/default/lambdaLeaderboard"

quiz_link = Faraday.get(QUIZ_URL)
leaderboard_link = Faraday.get(LEADERBOARD_URL)

get '/' do
  erb :index
end

post '/' do
  session[:username] = params['username']
  session[:question_qty] = params['question_qty']
  session[:quiz] = quiz_link.read(session[:question_qty])
  redirect '/quiz'
end

get '/quiz' do
  erb :quiz
end

post '/quiz' do
  redirect '/feedback'
end

get '/feedback' do
  erb :feedback
end

post '/feedback' do
  redirect '/quiz'
end

get '/leaderboard' do
  erb :leaderboard
end

post '/leaderboard' do
  redirect '/'
end