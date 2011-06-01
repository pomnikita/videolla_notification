require 'liquid'
class MailTemplate < ActiveRecord::Base
  RECIPIENTS_GROUPS = ['admin', 'all_users']
  # validates_uniqueness_of :name, :message => "must be unique"
  # validates_presence_of :subject, :message => "can't be blank"
  # validates_presence_of :body, :message => "can't be blank"   
  
  def parse_with(model_object)
    template = Liquid::Template.parse self.body
    attrs_hash = MailTemplate.get_model_attributes(template, model_object)
    template.render(attrs_hash)
  end
  
  def get_recipients
    case self.recipients_group
    when 'admin'
      ['pomnikita@gmail.com']
    when 'all_user'
      ['pomnikita@gmail.com', 'pomnikita@mail.ru']
    end
  end
  
  def self.get_model_attributes(template, model_object)
    names = template.root.nodelist.select{|n| n.is_a?(Liquid::Variable)}.map(&:name) rescue []
    Hash.new.tap do |hash|
      for name in names
        hash[name.to_s] = model_object.send(name.to_sym) if model_object.respond_to?(name.to_sym)
      end
    end
  end
end