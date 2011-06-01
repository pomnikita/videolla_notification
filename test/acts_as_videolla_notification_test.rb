require 'test_helper'
class User < ActiveRecord::Base
  acts_as_videolla_notification :template => :new_user_with_conditions
end

class ActsAsVideollaNotificationTest < Test::Unit::TestCase

  load_schema
  prepare_template(:name => 'new_user', :title => "new user has been signed in")
    
  def assert_template_name 
    assert_equal "new_user", User.template
  end
  
  def assert_mail_template_title
    user = User.new
    assert_equal "new user has been signed in", user.load_template.title
  end
    
end