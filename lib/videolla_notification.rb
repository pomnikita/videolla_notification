require 'videolla_notification/core_ext'
require 'videolla_notification/acts_as_videolla_notification'
%w{ models mailers}.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.autoload_paths << path
end