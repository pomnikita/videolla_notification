require 'test_helper'
class VideollaNotificationNotifierTest < ActionMailer::TestCase
  class User < ActiveRecord::Base
    acts_as_videolla_notification :template => :new_user_create, :if => :name_eql?
    
    def name_eql?
      self.name == 'name'
    end
  end
  load_schema
  prepare_template(:name => 'new_user_create', :subject => 'new user subject', :body => 'new user registered')
  
  def test_sending_notification_with_false_condition
    user = User.new(:email => 'test@test.com', :name=>'mena')
    user.save!
    assert ActionMailer::Base.deliveries.empty?
  end
  
  def test_sending_notification_with_true_condition
    user = User.new(:email => 'test@test.com', :name=>'name')
    user.save!
    email = ActionMailer::Base.deliveries.last
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal ["pomnikita@gmail.com"], email.to
    assert_equal "new user subject", email.subject
    assert_equal 'new user registered', email.body.to_s
  end
end