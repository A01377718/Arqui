# Final Project: Quiz Application with Microservices
# Date: 10-Jun-2022
# Author:
#          A01377718 Javier Alexandro Vargas Sanchez

require 'json'
require 'aws-sdk-dynamodb'

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
  

#This class models a Leaderboard that can be read or written using DynamoDB
class Leaderboard
  
  #This constant represents a DynamoDB Client
  DYNAMODB = Aws::DynamoDB::Client.new
  #This constant represents a table stored in our DynamoDB database
  TABLE_NAME = 'Leaderboard'
  
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
  
  #This method sorts the items from a DynamoDB database via a column
  # Parameters::
  # items:: List of unsorted items 
  # Returns:.
  # items. List of sorted items by a column
  def sort_items(items)
    items.sort! {|a, b| a['Score'] <=> b['Score']}
  end
  
  #This method gets 5 entries from the leaderbord table created at DynamoDB
  #Returns::
  #items: first 5 entries on the DynamoDB table called Leaderboard
  def get_leaderboard
    items = DYNAMODB.scan(table_name: TABLE_NAME).items
    sort_items(items)
    items.first(5)
  end
  
  #This method parses a JSON body received
  # Parameters::
  # body:: JSON body of the DynamoDB database
  # Return::
  # body: Parsed body
  def parse_body(body)
    if body
      begin
        data = JSON.parse(body)
        data.key?('Score') and data.key?('username') ? data : nil
      rescue JSON::ParserError
        nil
      end
    else
      nil
    end
  end
  
  #This method receives a JSON body uses the parse_body method and creates an item or row at our DynamoDB table
  # Parameters::
  # body:: JSON body of the DynamoDB database
  def record_score(body)
    data = parse_body(body)
    if data
      DYNAMODB.put_item(table_name: TABLE_NAME, item: data)
      true
    else
      false
    end
  end
  
  #This method handles get requests by calling the make_response method
  # Returns:: Get response given a Http status code, and quiz
  def handle_get
    make_response(HttpStatus::OK, get_leaderboard)
  end
  
  #This method handles post requests by calling the make_response method
  # Returns:: Post response given a Http status code
  def handle_post
    make_response(HttpStatus::CREATED,
      {message: 'Resource created or updated'})
  end
  
  #This method handles bad requests by calling the make_response method
  # Returns:: Bad request response given a Http status code
  def handle_bad_request
    make_response(HttpStatus::BAD_REQUEST,
      {message: 'Bad request (invalid input)'})
  end
  
  #This method handles method not allowed requests by calling the make_response method
  # Returns:: Bad method response given a Http status code
  def handle_bad_method(method)
    make_response(HttpStatus::METHOD_NOT_ALLOWED,
      {message: "Method not supported: #{method}"})
  end
  
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
  
    when 'POST'
      if record_score(event['body'])
        handle_post
      else
        handle_bad_request
      end
  
    else
      handle_bad_method(method)
    end
  end
end