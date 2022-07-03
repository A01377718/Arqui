# Final Project: Quiz Application with Microservices
# Date: 10-Jun-2022
# Author:
#          A01377718 Javier Alexandro Vargas Sanchez

require 'json'


#This class models an HttpStatus
class HttpStatus
  #This constant represents an OK 200 HttpStatus
  OK = 200
  #This constant represents a CREATED 201 HttpStatus
  CREATED = 201
  #This constant represents a BAD REQUEST 400 HttpStatus
  BAD_REQUEST = 400
  #This constant represents a METHOD NOT ALLOWED 405 HttpStatus
  METHOD_NOT_ALLOWED = 405
end


#This +Quiz+ class models a test comprised of "n" questions
class Quiz
  -
  #This method creates a response based on the HttpStatus code received
  # Parameters::
  # code:: The http status code
  # body:: JSON body of the response
  def make_response(code, body)
    {
      statusCode: code,
      headers: {
        "Content-Type" => "application/json; charset=utf-8"
      },
      body: JSON.generate(body)
    }
  end
  
  -
  #This method gets a sample of "n" entries or questions from the questions.json file 
  # Parameters::
  # question_qty:: number of questions that will comprise the quiz
  # 
  # Returns:: Quiz comprised of "n" random questions pulled from question.json
  def get_questions(question_qty)
      begin
          file_json = File.read('models/questions.json')
      rescue
          puts "error reading file"
      end
      begin
          quiz_json = JSON.parse(file_json)
      rescue
          puts "error parsing json"
      end
      begin
          quiz_array = quiz_json["Quiz"] 
          quiz_array.sample(question_qty)
      rescue
          puts "error sampling quiz"
      end
  end
  
  -
  #This method handles get requests by calling the make_response method
  # Returns:: Get response given a Http status code, and quiz
  def handle_get
    make_response(HttpStatus::OK, get_questions(question_qty))
  end
  
  -
  #This method handles post requests by calling the make_response method
  # Returns:: Post response given a Http status code
  def handle_post
    make_response(HttpStatus::CREATED,
      {message: 'Resource created or updated'})
  end
  
  -
  #This method handles bad requests by calling the make_response method
  # Returns:: Bad request response given a Http status code
  def handle_bad_request
    make_response(HttpStatus::BAD_REQUEST,
      {message: 'Bad request (invalid input)'})
  end
  
  -
  #This method handles method not allowed requests by calling the make_response method
  # Returns:: Bad method response given a Http status code
  def handle_bad_method(method)
    make_response(HttpStatus::METHOD_NOT_ALLOWED,
      {message: "Method not supported: #{method}"})
  end
  
  -
  #This method handles lambda requests by calling each event handler depending on the event and context received
  # Parameters::
  # event:: Http event 
  # 
  # Returns:: Handles event depending on the event and context received
  def lambda_handler(event:, context:)
    method = event['httpMethod']
    case method
    when 'GET'
      handle_get
    else
      handle_bad_method(method)
    end
  end
end