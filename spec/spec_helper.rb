ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
set(:root, Dir.pwd())
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

require("capybara/rspec")
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require("./app")

RSpec.configure do |config|
  config.after(:each) do
    Calendar.all().each do |calendar|
      calendar.destroy()
    end
    Opening.all().each do |opening|
      opening.destroy()
    end
  end
end
