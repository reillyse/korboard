require 'net/http'
require 'net/https'
require 'json'
require 'active_support/inflector'

class Korboard::Client

  def initialize


    @token = ::Rails.application.config.korboard.api_token
    @iteration_number = ::Rails.application.config.korboard.iteration_number
    @http = Net::HTTP.new('api.korboard.com')
    @headers = {
      'Content-Type' => 'application/json'
    }
  end

  # can do this for the rest too
  def record_signup identifier,options=nil
    record :signup,@iteration_number,identifier,options
  end

  def record_visit identifier,options=nil
    record :signup,@iteration_number,identifier,options
  end

  
  
  def record metric ,iteration_number, identifier, options =nil
    data = { :signup  => { :identifier => identifier }, :iteration => { :number => iteration_number }  }
    data.merge(options) if options
    
    path = "/v1.1/#{metric.to_s.pluralize}?token=#{@token}"

    resp, data = @http.post(path, data.to_json, @headers)
    
    print_response(resp,data) unless resp.code.to_i == 201
    return resp.code.to_i == 201
    
  end

  

  def print_response(resp,data)
    puts 'Code = ' + resp.code
    puts 'Message = ' + resp.message
    resp.each {|key, val| puts key + ' = ' + val}
    puts data
  end

end
