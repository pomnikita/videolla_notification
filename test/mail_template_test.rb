require 'test_helper'

class MailTemplateTest < Test::Unit::TestCase
 
  def test_mail_template
    assert_kind_of MailTemplate, MailTemplate.new
  end
  

  def test_liquid_names_hash
    template = MailTemplate.create(:name => 'test_liquid_names_hash', :subject => 'liquid', :body => "Hi {{name}} your email is {{email}}")
    user = User.create(:name => 'liquid', :email => 'liquid_email')
    parsed_template = template.parse_with(user)
    assert_equal parsed_template, "Hi liquid your email is liquid_email"
  end
  
  def test_get_model_attributes
    template = Liquid::Template.parse "Hi {{name}} your email is {{email}}"
    user = User.create(:name => 'liquid', :email => 'liquid_email')
    attrs_hash = MailTemplate.get_model_attributes(template, user)
    assert_equal attrs_hash, {'name' => 'liquid', 'email' => 'liquid_email'}
  end
end