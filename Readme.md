Readme
======


Configuration
-------------

This gem is used for interfacing with the Korboard API from Rails (its trivial to set it up without rails, just remove the config options)

Configuration is in application.rb (or an initializer ) 

    YOUR_APPLICATION_NAME::Application.config.korboard.api_token ="api_secret_for_product"
    YOUR_APPLICATION_NAME::Application.config.korboard.iteration_number = 1 (your iteration number)

Example Usage
-------------

call

    Korboard::Client.new.record_visit(session[:session_id])

when you record an initial visit from a user

and 
    Korboard::Client.new.record_signup(user.id,session[:session_id])
        
to record a signup

    
