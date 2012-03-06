require 'rails'
class Korboard::Railtie <  Rails::Railtie
  config.korboard = ActiveSupport::OrderedOptions.new
  
  initializer "korboard.configure" do |app|
    # Korboard.configure do |config|
    #   config.key = app.config.korboard[:key]
    # end
  end
end
