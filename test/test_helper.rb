ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'database_cleaner'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]
DatabaseCleaner.strategy = :transaction

module AroundEachTest
  def before_setup
    super
    DatabaseCleaner.clean 
    DatabaseCleaner.start    
  end
end
class ActiveSupport::TestCase
  include AroundEachTest
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  session[:user_id] = users(user).id
  def logout 
    session.delete :user_id
  end
  def setup 
    login_as :one if defined? session
    
  end

  # Add more helper methods to be used by all tests here...
end
