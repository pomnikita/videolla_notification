module VideollaNotification
  module ActsAsVideollaNotification
    extend ActiveSupport::Concern
    included do
    end
    
    module ClassMethods
      def acts_as_videolla_notification(options = {})
        cattr_accessor :template
        # cattr_accessor :template_table
        cattr_accessor :if_condition
        self.template = (options[:template] || :default_template).to_s
        # self.template_table = (options[:template_model] || :mail_templates).to_s
        self.if_condition = (options[:if] || false)
        self.after_create :send_videolla_notification
      end
    end
    
    
    def load_template
      templates = MailTemplate.find_all_by_name(self.class.template)
      puts "You have several templates with same name" if templates.size > 1
      return templates.last
    end
    
    def send_videolla_notification
      VideollaNotificationNotifier.new_notification(self).deliver if self.condition_return
    end
    
    def condition_return
      self.class.if_condition ? self.send(self.class.if_condition) : true
    end
  end
end                                   

ActiveRecord::Base.send :include, VideollaNotification::ActsAsVideollaNotification
 
