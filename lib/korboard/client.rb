require 'net/http'
require 'net/https'
require 'json'
require 'active_support/inflector'

class Korboard::Client

  def initialize params


    @token = params[:api_secret]
    @iteration_number = params[:iteration]
    @http = Net::HTTP.new('api.korboard.com')
    @headers = {
      'Content-Type' => 'application/json'
    }
  end

  # can do this for the rest too
  # parent_user_id => user_id_of_invitor can be passed in the options
  def record_signup identifier,session_id,options={ }
    options.merge! :user_profile => { :session_id => session_id , :user_id => identifier}
    record :signup,@iteration_number,identifier,options
  end

  def record_visit identifier,options={ }
    options.merge! :user_profile => { :session_id => identifier }
    record :visit,@iteration_number,identifier,options
  end

  def record_invite identifier,options={ }
    options.merge! :user_profile => { :session_id => identifier }
    record :invite,@iteration_number,identifier,options
  end

  def record_value identifier,options={ }
    options.merge! :user_profile => { :session_id => identifier }
    record :value,@iteration_number,identifier,options
  end
  
  def record_paid identifier,options={ }
    options.merge! :user_profile => { :session_id => identifier }
    record :paid,@iteration_number,identifier,options
  end
    
  def record metric ,iteration_number, identifier, options ={ }
    data = { :signup  => { :identifier => identifier }, :iteration => { :number => iteration_number }  }
    data.merge!(options) 
    
    path = "/v1.1/#{metric.to_s.pluralize}?token=#{@token}"

    #wrap in a timeout so we don't slow shit down
    Timeout::timeout(1){
      resp, data = @http.post(path, data.to_json, @headers)
      print_response(resp,data) unless resp.code.to_i == 201
      return resp.code.to_i == 201
    }
    return false
  rescue => e
    puts e.message
  end

  

  def print_response(resp,data)
    puts 'Code = ' + resp.code
    puts 'Message = ' + resp.message
    resp.each {|key, val| puts key + ' = ' + val}
    puts data
  end

end
