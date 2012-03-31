Readme
======


Configuration
-------------

This gem is used for interfacing with the Korboard API

initializers/korboard.rb
    
    require "korboard"
    KORBOARD_CLIENT= Korboard::Client.new(:api_secret =>ENV['KORBOARD_SECRET'], :iteration => 1)

Example Usage
-------------

call

    Korboard::Client.new.record_visit(session[:session_id])

when you record an initial visit from a user

and

    Korboard::Client.new.record_signup(user.id,session[:session_id])
        
to record a signup


    
