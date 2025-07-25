# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `actionmailbox` gem.
# Please instead update this file by running `bin/tapioca gem actionmailbox`.


# :markup: markdown
# :include: ../README.md
#
# source://actionmailbox//lib/action_mailbox/gem_version.rb#3
module ActionMailbox
  extend ::ActiveSupport::Autoload

  # source://actionmailbox//lib/action_mailbox.rb#22
  def incinerate; end

  # source://actionmailbox//lib/action_mailbox.rb#22
  def incinerate=(val); end

  # source://actionmailbox//lib/action_mailbox.rb#23
  def incinerate_after; end

  # source://actionmailbox//lib/action_mailbox.rb#23
  def incinerate_after=(val); end

  # source://actionmailbox//lib/action_mailbox.rb#20
  def ingress; end

  # source://actionmailbox//lib/action_mailbox.rb#20
  def ingress=(val); end

  # source://actionmailbox//lib/action_mailbox.rb#21
  def logger; end

  # source://actionmailbox//lib/action_mailbox.rb#21
  def logger=(val); end

  # source://actionmailbox//lib/action_mailbox.rb#24
  def queues; end

  # source://actionmailbox//lib/action_mailbox.rb#24
  def queues=(val); end

  # source://actionmailbox//lib/action_mailbox.rb#25
  def storage_service; end

  # source://actionmailbox//lib/action_mailbox.rb#25
  def storage_service=(val); end

  class << self
    # source://actionmailbox//lib/action_mailbox/deprecator.rb#4
    def deprecator; end

    # Returns the currently loaded version of Action Mailbox as a +Gem::Version+.
    #
    # source://actionmailbox//lib/action_mailbox/gem_version.rb#5
    def gem_version; end

    # source://actionmailbox//lib/action_mailbox.rb#22
    def incinerate; end

    # source://actionmailbox//lib/action_mailbox.rb#22
    def incinerate=(val); end

    # source://actionmailbox//lib/action_mailbox.rb#23
    def incinerate_after; end

    # source://actionmailbox//lib/action_mailbox.rb#23
    def incinerate_after=(val); end

    # source://actionmailbox//lib/action_mailbox.rb#20
    def ingress; end

    # source://actionmailbox//lib/action_mailbox.rb#20
    def ingress=(val); end

    # source://actionmailbox//lib/action_mailbox.rb#21
    def logger; end

    # source://actionmailbox//lib/action_mailbox.rb#21
    def logger=(val); end

    # source://actionmailbox//lib/action_mailbox.rb#24
    def queues; end

    # source://actionmailbox//lib/action_mailbox.rb#24
    def queues=(val); end

    # source://actionmailbox//lib/action_mailbox/engine.rb#13
    def railtie_helpers_paths; end

    # source://actionmailbox//lib/action_mailbox/engine.rb#13
    def railtie_namespace; end

    # source://actionmailbox//lib/action_mailbox/engine.rb#13
    def railtie_routes_url_helpers(include_path_helpers = T.unsafe(nil)); end

    # source://actionmailbox//lib/action_mailbox.rb#25
    def storage_service; end

    # source://actionmailbox//lib/action_mailbox.rb#25
    def storage_service=(val); end

    # source://actionmailbox//lib/action_mailbox/engine.rb#13
    def table_name_prefix; end

    # source://actionmailbox//lib/action_mailbox/engine.rb#13
    def use_relative_model_naming?; end

    # Returns the currently loaded version of Action Mailbox as a +Gem::Version+.
    #
    # source://actionmailbox//lib/action_mailbox/version.rb#7
    def version; end
  end
end

# = Action Mailbox \Base
#
# The base class for all application mailboxes. Not intended to be inherited from directly. Inherit from
# +ApplicationMailbox+ instead, as that's where the app-specific routing is configured. This routing
# is specified in the following ways:
#
#   class ApplicationMailbox < ActionMailbox::Base
#     # Any of the recipients of the mail (whether to, cc, bcc) are matched against the regexp.
#     routing /^replies@/i => :replies
#
#     # Any of the recipients of the mail (whether to, cc, bcc) needs to be an exact match for the string.
#     routing "help@example.com" => :help
#
#     # Any callable (proc, lambda, etc) object is passed the inbound_email record and is a match if true.
#     routing ->(inbound_email) { inbound_email.mail.to.size > 2 } => :multiple_recipients
#
#     # Any object responding to #match? is called with the inbound_email record as an argument. Match if true.
#     routing CustomAddress.new => :custom
#
#     # Any inbound_email that has not been already matched will be sent to the BackstopMailbox.
#     routing :all => :backstop
#   end
#
# Application mailboxes need to override the #process method, which is invoked by the framework after
# callbacks have been run. The callbacks available are: +before_processing+, +after_processing+, and
# +around_processing+. The primary use case is to ensure that certain preconditions to processing are fulfilled
# using +before_processing+ callbacks.
#
# If a precondition fails to be met, you can halt the processing using the +#bounced!+ method,
# which will silently prevent any further processing, but not actually send out any bounce notice. You
# can also pair this behavior with the invocation of an Action Mailer class responsible for sending out
# an actual bounce email. This is done using the #bounce_with method, which takes the mail object returned
# by an Action Mailer method, like so:
#
#   class ForwardsMailbox < ApplicationMailbox
#     before_processing :ensure_sender_is_a_user
#
#     private
#       def ensure_sender_is_a_user
#         unless User.exist?(email_address: mail.from)
#           bounce_with UserRequiredMailer.missing(inbound_email)
#         end
#       end
#   end
#
# During the processing of the inbound email, the status will be tracked. Before processing begins,
# the email will normally have the +pending+ status. Once processing begins, just before callbacks
# and the #process method is called, the status is changed to +processing+. If processing is allowed to
# complete, the status is changed to +delivered+. If a bounce is triggered, then +bounced+. If an unhandled
# exception is bubbled up, then +failed+.
#
# Exceptions can be handled at the class level using the familiar
# ActiveSupport::Rescuable approach:
#
#   class ForwardsMailbox < ApplicationMailbox
#     rescue_from(ApplicationSpecificVerificationError) { bounced! }
#   end
#
# source://actionmailbox//lib/action_mailbox/base.rb#66
class ActionMailbox::Base
  include ::ActiveSupport::Rescuable
  include ::ActionMailbox::Routing
  include ::ActiveSupport::Callbacks
  include ::ActionMailbox::Callbacks
  extend ::ActiveSupport::Rescuable::ClassMethods
  extend ::ActionMailbox::Routing::ClassMethods
  extend ::ActiveSupport::Callbacks::ClassMethods
  extend ::ActiveSupport::DescendantsTracker
  extend ::ActionMailbox::Callbacks::ClassMethods

  # @return [Base] a new instance of Base
  #
  # source://actionmailbox//lib/action_mailbox/base.rb#79
  def initialize(inbound_email); end

  # source://actionmailbox//lib/action_mailbox/base.rb#68
  def __callbacks; end

  # source://actionmailbox//lib/action_mailbox/base.rb#68
  def _process_callbacks; end

  # source://actionmailbox//lib/action_mailbox/base.rb#68
  def _run_process_callbacks(&block); end

  # Immediately sends the given +message+ and changes the inbound email's status to +:bounced+.
  #
  # source://actionmailbox//lib/action_mailbox/base.rb#111
  def bounce_now_with(message); end

  # Enqueues the given +message+ for delivery and changes the inbound email's status to +:bounced+.
  #
  # source://actionmailbox//lib/action_mailbox/base.rb#105
  def bounce_with(message); end

  # source://actionmailbox//lib/action_mailbox/base.rb#71
  def bounced!(*_arg0, **_arg1, &_arg2); end

  # source://actionmailbox//lib/action_mailbox/base.rb#71
  def delivered!(*_arg0, **_arg1, &_arg2); end

  # @return [Boolean]
  #
  # source://actionmailbox//lib/action_mailbox/base.rb#100
  def finished_processing?; end

  # Returns the value of attribute inbound_email.
  #
  # source://actionmailbox//lib/action_mailbox/base.rb#70
  def inbound_email; end

  # source://actionmailbox//lib/action_mailbox/base.rb#73
  def logger(&_arg0); end

  # source://actionmailbox//lib/action_mailbox/base.rb#71
  def mail(*_arg0, **_arg1, &_arg2); end

  # source://actionmailbox//lib/action_mailbox/base.rb#83
  def perform_processing; end

  # source://actionmailbox//lib/action_mailbox/base.rb#96
  def process; end

  # source://actionmailbox//lib/action_mailbox/base.rb#67
  def rescue_handlers; end

  # source://actionmailbox//lib/action_mailbox/base.rb#67
  def rescue_handlers=(_arg0); end

  # source://actionmailbox//lib/action_mailbox/base.rb#67
  def rescue_handlers?; end

  # source://actionmailbox//lib/action_mailbox/base.rb#68
  def router; end

  # source://actionmailbox//lib/action_mailbox/base.rb#68
  def router=(val); end

  private

  # source://actionmailbox//lib/action_mailbox/base.rb#117
  def instrumentation_payload; end

  # source://actionmailbox//lib/action_mailbox/base.rb#124
  def track_status_of_inbound_email; end

  class << self
    # source://actionmailbox//lib/action_mailbox/base.rb#68
    def __callbacks; end

    # source://actionmailbox//lib/action_mailbox/base.rb#68
    def __callbacks=(value); end

    # source://actionmailbox//lib/action_mailbox/base.rb#68
    def _process_callbacks; end

    # source://actionmailbox//lib/action_mailbox/base.rb#68
    def _process_callbacks=(value); end

    # source://actionmailbox//lib/action_mailbox/base.rb#75
    def receive(inbound_email); end

    # source://actionmailbox//lib/action_mailbox/base.rb#67
    def rescue_handlers; end

    # source://actionmailbox//lib/action_mailbox/base.rb#67
    def rescue_handlers=(value); end

    # source://actionmailbox//lib/action_mailbox/base.rb#67
    def rescue_handlers?; end

    # source://actionmailbox//lib/action_mailbox/base.rb#68
    def router; end

    # source://actionmailbox//lib/action_mailbox/base.rb#68
    def router=(val); end

    private

    # source://actionmailbox//lib/action_mailbox/base.rb#68
    def __class_attr___callbacks; end

    # source://actionmailbox//lib/action_mailbox/base.rb#68
    def __class_attr___callbacks=(new_value); end

    # source://actionmailbox//lib/action_mailbox/base.rb#67
    def __class_attr_rescue_handlers; end

    # source://actionmailbox//lib/action_mailbox/base.rb#67
    def __class_attr_rescue_handlers=(new_value); end
  end
end

class ActionMailbox::BaseController < ::ActionController::Base
  private

  def _layout(lookup_context, formats, keys); end
  def authenticate_by_password; end
  def ensure_configured; end
  def ingress_name; end
  def password; end

  class << self
    private

    def __class_attr___callbacks; end
    def __class_attr___callbacks=(new_value); end
    def __class_attr_middleware_stack; end
    def __class_attr_middleware_stack=(new_value); end
  end
end

# = Action Mailbox \Callbacks
#
# Defines the callbacks related to processing.
#
# source://actionmailbox//lib/action_mailbox/callbacks.rb#9
module ActionMailbox::Callbacks
  extend ::ActiveSupport::Concern
  include GeneratedInstanceMethods
  include ::ActiveSupport::Callbacks

  mixes_in_class_methods GeneratedClassMethods
  mixes_in_class_methods ::ActiveSupport::Callbacks::ClassMethods
  mixes_in_class_methods ::ActiveSupport::DescendantsTracker
  mixes_in_class_methods ::ActionMailbox::Callbacks::ClassMethods

  module GeneratedClassMethods
    def __callbacks; end
    def __callbacks=(value); end
  end

  module GeneratedInstanceMethods
    def __callbacks; end
  end
end

# source://actionmailbox//lib/action_mailbox/callbacks.rb#22
module ActionMailbox::Callbacks::ClassMethods
  # source://actionmailbox//lib/action_mailbox/callbacks.rb#27
  def after_processing(*methods, &block); end

  # source://actionmailbox//lib/action_mailbox/callbacks.rb#31
  def around_processing(*methods, &block); end

  # source://actionmailbox//lib/action_mailbox/callbacks.rb#23
  def before_processing(*methods, &block); end
end

# source://actionmailbox//lib/action_mailbox/callbacks.rb#13
ActionMailbox::Callbacks::TERMINATOR = T.let(T.unsafe(nil), Proc)

# source://actionmailbox//lib/action_mailbox/engine.rb#12
class ActionMailbox::Engine < ::Rails::Engine; end

class ActionMailbox::InboundEmail < ::ActionMailbox::Record
  include ::ActionMailbox::InboundEmail::GeneratedAttributeMethods
  include ::ActionMailbox::InboundEmail::GeneratedAssociationMethods
  include ::ActionMailbox::InboundEmail::Routable
  include ::ActionMailbox::InboundEmail::MessageId
  include ::ActionMailbox::InboundEmail::Incineratable
  extend ::ActionMailbox::InboundEmail::MessageId::ClassMethods

  def autosave_associated_records_for_raw_email_attachment(*args); end
  def autosave_associated_records_for_raw_email_blob(*args); end
  def instrumentation_payload; end
  def mail; end
  def processed?; end
  def source; end

  class << self
    def bounced(*args, **_arg1); end
    def delivered(*args, **_arg1); end
    def failed(*args, **_arg1); end
    def not_bounced(*args, **_arg1); end
    def not_delivered(*args, **_arg1); end
    def not_failed(*args, **_arg1); end
    def not_pending(*args, **_arg1); end
    def not_processing(*args, **_arg1); end
    def pending(*args, **_arg1); end
    def processing(*args, **_arg1); end
    def statuses; end
    def with_attached_raw_email(*args, **_arg1); end

    private

    def __class_attr___callbacks; end
    def __class_attr___callbacks=(new_value); end
    def __class_attr__reflections; end
    def __class_attr__reflections=(new_value); end
    def __class_attr__validators; end
    def __class_attr__validators=(new_value); end
    def __class_attr_attachment_reflections; end
    def __class_attr_attachment_reflections=(new_value); end
    def __class_attr_defined_enums; end
    def __class_attr_defined_enums=(new_value); end
  end
end

module ActionMailbox::InboundEmail::GeneratedAssociationMethods
  def build_raw_email_attachment(*args, &block); end
  def build_raw_email_blob(*args, &block); end
  def create_raw_email_attachment(*args, &block); end
  def create_raw_email_attachment!(*args, &block); end
  def create_raw_email_blob(*args, &block); end
  def create_raw_email_blob!(*args, &block); end
  def raw_email; end
  def raw_email=(attachable); end
  def raw_email_attachment; end
  def raw_email_attachment=(value); end
  def raw_email_blob; end
  def raw_email_blob=(value); end
  def reload_raw_email_attachment; end
  def reload_raw_email_blob; end
  def reset_raw_email_attachment; end
  def reset_raw_email_blob; end
end

module ActionMailbox::InboundEmail::GeneratedAttributeMethods; end

module ActionMailbox::InboundEmail::Incineratable
  extend ::ActiveSupport::Concern

  def incinerate; end
  def incinerate_later; end
end

class ActionMailbox::InboundEmail::Incineratable::Incineration
  def initialize(inbound_email); end

  def run; end

  private

  def due?; end
  def processed?; end
end

module ActionMailbox::InboundEmail::MessageId
  extend ::ActiveSupport::Concern

  mixes_in_class_methods ::ActionMailbox::InboundEmail::MessageId::ClassMethods
end

module ActionMailbox::InboundEmail::MessageId::ClassMethods
  def create_and_extract_message_id!(source, **options); end

  private

  def create_and_upload_raw_email!(source); end
  def extract_message_id(source); end
  def generate_missing_message_id(message_checksum); end
end

module ActionMailbox::InboundEmail::Routable
  extend ::ActiveSupport::Concern

  def route; end
  def route_later; end
end

class ActionMailbox::IncinerationJob < ::ActiveJob::Base
  def perform(inbound_email); end

  class << self
    def schedule(inbound_email); end

    private

    def __class_attr_queue_name; end
    def __class_attr_queue_name=(new_value); end
    def __class_attr_rescue_handlers; end
    def __class_attr_rescue_handlers=(new_value); end
  end
end

module ActionMailbox::Ingresses; end
module ActionMailbox::Ingresses::Mailgun; end

class ActionMailbox::Ingresses::Mailgun::InboundEmailsController < ::ActionMailbox::BaseController
  def create; end

  private

  def _layout(lookup_context, formats, keys); end
  def authenticate; end
  def authenticated?; end
  def key; end
  def mail; end

  class << self
    private

    def __class_attr___callbacks; end
    def __class_attr___callbacks=(new_value); end
    def __class_attr_middleware_stack; end
    def __class_attr_middleware_stack=(new_value); end
  end
end

class ActionMailbox::Ingresses::Mailgun::InboundEmailsController::Authenticator
  def initialize(key:, timestamp:, token:, signature:); end

  def authenticated?; end
  def key; end
  def signature; end
  def timestamp; end
  def token; end

  private

  def expected_signature; end
  def recent?; end
  def signed?; end
end

module ActionMailbox::Ingresses::Mandrill; end

class ActionMailbox::Ingresses::Mandrill::InboundEmailsController < ::ActionMailbox::BaseController
  def create; end
  def health_check; end

  private

  def _layout(lookup_context, formats, keys); end
  def authenticate; end
  def authenticated?; end
  def events; end
  def key; end
  def raw_emails; end

  class << self
    private

    def __class_attr___callbacks; end
    def __class_attr___callbacks=(new_value); end
    def __class_attr_middleware_stack; end
    def __class_attr_middleware_stack=(new_value); end
  end
end

class ActionMailbox::Ingresses::Mandrill::InboundEmailsController::Authenticator
  def initialize(request, key); end

  def authenticated?; end
  def key; end
  def request; end

  private

  def expected_signature; end
  def given_signature; end
  def message; end
end

module ActionMailbox::Ingresses::Postmark; end

class ActionMailbox::Ingresses::Postmark::InboundEmailsController < ::ActionMailbox::BaseController
  def create; end

  private

  def _layout(lookup_context, formats, keys); end
  def mail; end

  class << self
    private

    def __class_attr___callbacks; end
    def __class_attr___callbacks=(new_value); end
    def __class_attr_middleware_stack; end
    def __class_attr_middleware_stack=(new_value); end
  end
end

module ActionMailbox::Ingresses::Relay; end

class ActionMailbox::Ingresses::Relay::InboundEmailsController < ::ActionMailbox::BaseController
  def create; end

  private

  def _layout(lookup_context, formats, keys); end
  def require_valid_rfc822_message; end

  class << self
    private

    def __class_attr___callbacks; end
    def __class_attr___callbacks=(new_value); end
    def __class_attr_middleware_stack; end
    def __class_attr_middleware_stack=(new_value); end
  end
end

module ActionMailbox::Ingresses::Sendgrid; end

class ActionMailbox::Ingresses::Sendgrid::InboundEmailsController < ::ActionMailbox::BaseController
  def create; end

  private

  def _layout(lookup_context, formats, keys); end
  def envelope; end
  def mail; end

  class << self
    private

    def __class_attr___callbacks; end
    def __class_attr___callbacks=(new_value); end
    def __class_attr_middleware_stack; end
    def __class_attr_middleware_stack=(new_value); end
  end
end

class ActionMailbox::Record < ::ActiveRecord::Base
  include ::ActionMailbox::Record::GeneratedAttributeMethods
  include ::ActionMailbox::Record::GeneratedAssociationMethods

  class << self
    private

    def __class_attr__validators; end
    def __class_attr__validators=(new_value); end
    def __class_attr_defined_enums; end
    def __class_attr_defined_enums=(new_value); end
  end
end

module ActionMailbox::Record::GeneratedAssociationMethods; end
module ActionMailbox::Record::GeneratedAttributeMethods; end

# = Action Mailbox \Router
#
# Encapsulates the routes that live on the ApplicationMailbox and performs the actual routing when
# an inbound_email is received.
#
# source://actionmailbox//lib/action_mailbox/router.rb#8
class ActionMailbox::Router
  # @return [Router] a new instance of Router
  #
  # source://actionmailbox//lib/action_mailbox/router.rb#11
  def initialize; end

  # source://actionmailbox//lib/action_mailbox/router.rb#21
  def add_route(address, to:); end

  # source://actionmailbox//lib/action_mailbox/router.rb#15
  def add_routes(routes); end

  # source://actionmailbox//lib/action_mailbox/router.rb#35
  def mailbox_for(inbound_email); end

  # source://actionmailbox//lib/action_mailbox/router.rb#25
  def route(inbound_email); end

  private

  # Returns the value of attribute routes.
  #
  # source://actionmailbox//lib/action_mailbox/router.rb#40
  def routes; end
end

# source://actionmailbox//lib/action_mailbox/router/route.rb#7
class ActionMailbox::Router::Route
  # source://actionmailbox//lib/action_mailbox/router/route.rb#10
  def initialize(address, to:); end

  # source://actionmailbox//lib/action_mailbox/router/route.rb#8
  def address; end

  # source://actionmailbox//lib/action_mailbox/router/route.rb#31
  def mailbox_class; end

  # source://actionmailbox//lib/action_mailbox/router/route.rb#8
  def mailbox_name; end

  # source://actionmailbox//lib/action_mailbox/router/route.rb#16
  def match?(inbound_email); end

  private

  # source://actionmailbox//lib/action_mailbox/router/route.rb#36
  def ensure_valid_address; end
end

# source://actionmailbox//lib/action_mailbox/router.rb#9
class ActionMailbox::Router::RoutingError < ::StandardError; end

# See ActionMailbox::Base for how to specify routing.
#
# source://actionmailbox//lib/action_mailbox/routing.rb#5
module ActionMailbox::Routing
  extend ::ActiveSupport::Concern

  mixes_in_class_methods ::ActionMailbox::Routing::ClassMethods
end

# source://actionmailbox//lib/action_mailbox/routing.rb#12
module ActionMailbox::Routing::ClassMethods
  # source://actionmailbox//lib/action_mailbox/routing.rb#21
  def mailbox_for(inbound_email); end

  # source://actionmailbox//lib/action_mailbox/routing.rb#17
  def route(inbound_email); end

  # source://actionmailbox//lib/action_mailbox/routing.rb#13
  def routing(routes); end
end

class ActionMailbox::RoutingJob < ::ActiveJob::Base
  def perform(inbound_email); end

  class << self
    private

    def __class_attr_queue_name; end
    def __class_attr_queue_name=(new_value); end
  end
end

# source://actionmailbox//lib/action_mailbox/test_case.rb#7
class ActionMailbox::TestCase < ::ActiveSupport::TestCase
  include ::ActionMailbox::TestHelper
end

# source://actionmailbox//lib/action_mailbox/test_helper.rb#6
module ActionMailbox::TestHelper
  # Create an InboundEmail record using an eml fixture in the format of message/rfc822
  # referenced with +fixture_name+ located in +test/fixtures/files/fixture_name+.
  #
  # source://actionmailbox//lib/action_mailbox/test_helper.rb#9
  def create_inbound_email_from_fixture(fixture_name, status: T.unsafe(nil)); end

  # Creates an InboundEmail by specifying through options or a block.
  #
  # ==== Options
  #
  # * <tt>:status</tt> - The +status+ to set for the created InboundEmail.
  #   For possible statuses, see its documentation.
  #
  # ==== Creating a simple email
  #
  # When you only need to set basic fields like +from+, +to+, +subject+, and
  # +body+, you can pass them directly as options.
  #
  #   create_inbound_email_from_mail(from: "david@loudthinking.com", subject: "Hello!")
  #
  # ==== Creating a multi-part email
  #
  # When you need to create a more intricate email, like a multi-part email
  # that contains both a plaintext version and an HTML version, you can pass a
  # block.
  #
  #   create_inbound_email_from_mail do
  #     to "David Heinemeier Hansson <david@loudthinking.com>"
  #     from "Bilbo Baggins <bilbo@bagend.com>"
  #     subject "Come down to the Shire!"
  #
  #     text_part do
  #       body "Please join us for a party at Bag End"
  #     end
  #
  #     html_part do
  #       body "<h1>Please join us for a party at Bag End</h1>"
  #     end
  #   end
  #
  # As with +Mail.new+, you can also use a block parameter to define the parts
  # of the message:
  #
  #   create_inbound_email_from_mail do |mail|
  #     mail.to "David Heinemeier Hansson <david@loudthinking.com>"
  #     mail.from "Bilbo Baggins <bilbo@bagend.com>"
  #     mail.subject "Come down to the Shire!"
  #
  #     mail.text_part do |part|
  #       part.body "Please join us for a party at Bag End"
  #     end
  #
  #     mail.html_part do |part|
  #       part.body "<h1>Please join us for a party at Bag End</h1>"
  #     end
  #   end
  #
  # source://actionmailbox//lib/action_mailbox/test_helper.rb#63
  def create_inbound_email_from_mail(status: T.unsafe(nil), **mail_options, &block); end

  # Create an InboundEmail using the raw rfc822 +source+ as text.
  #
  # source://actionmailbox//lib/action_mailbox/test_helper.rb#72
  def create_inbound_email_from_source(source, status: T.unsafe(nil)); end

  # Create an InboundEmail from fixture using the same arguments as create_inbound_email_from_fixture
  # and immediately route it to processing.
  #
  # source://actionmailbox//lib/action_mailbox/test_helper.rb#79
  def receive_inbound_email_from_fixture(*args); end

  # Create an InboundEmail using the same options or block as
  # create_inbound_email_from_mail, then immediately route it for processing.
  #
  # source://actionmailbox//lib/action_mailbox/test_helper.rb#85
  def receive_inbound_email_from_mail(**kwargs, &block); end

  # Create an InboundEmail using the same arguments as create_inbound_email_from_source and immediately route it
  # to processing.
  #
  # source://actionmailbox//lib/action_mailbox/test_helper.rb#91
  def receive_inbound_email_from_source(*args); end
end

# source://actionmailbox//lib/action_mailbox/gem_version.rb#9
module ActionMailbox::VERSION; end

# source://actionmailbox//lib/action_mailbox/gem_version.rb#10
ActionMailbox::VERSION::MAJOR = T.let(T.unsafe(nil), Integer)

# source://actionmailbox//lib/action_mailbox/gem_version.rb#11
ActionMailbox::VERSION::MINOR = T.let(T.unsafe(nil), Integer)

# source://actionmailbox//lib/action_mailbox/gem_version.rb#13
ActionMailbox::VERSION::PRE = T.let(T.unsafe(nil), T.untyped)

# source://actionmailbox//lib/action_mailbox/gem_version.rb#15
ActionMailbox::VERSION::STRING = T.let(T.unsafe(nil), String)

# source://actionmailbox//lib/action_mailbox/gem_version.rb#12
ActionMailbox::VERSION::TINY = T.let(T.unsafe(nil), Integer)

# source://actionmailbox//lib/action_mailbox/mail_ext/address_equality.rb#3
module Mail
  class << self
    # source://actionmailbox//lib/action_mailbox/mail_ext/from_source.rb#4
    def from_source(source); end
  end
end

# source://actionmailbox//lib/action_mailbox/mail_ext/address_equality.rb#4
class Mail::Address
  # source://actionmailbox//lib/action_mailbox/mail_ext/address_equality.rb#5
  def ==(other_address); end

  class << self
    # source://actionmailbox//lib/action_mailbox/mail_ext/address_wrapping.rb#5
    def wrap(address); end
  end
end

# source://actionmailbox//lib/action_mailbox/mail_ext/addresses.rb#4
class Mail::Message
  # source://actionmailbox//lib/action_mailbox/mail_ext/addresses.rb#21
  def bcc_addresses; end

  # source://actionmailbox//lib/action_mailbox/mail_ext/addresses.rb#17
  def cc_addresses; end

  # source://actionmailbox//lib/action_mailbox/mail_ext/addresses.rb#5
  def from_address; end

  # source://actionmailbox//lib/action_mailbox/mail_ext/recipients.rb#5
  def recipients; end

  # source://actionmailbox//lib/action_mailbox/mail_ext/addresses.rb#9
  def recipients_addresses; end

  # source://actionmailbox//lib/action_mailbox/mail_ext/addresses.rb#13
  def to_addresses; end

  # source://actionmailbox//lib/action_mailbox/mail_ext/addresses.rb#29
  def x_forwarded_to_addresses; end

  # source://actionmailbox//lib/action_mailbox/mail_ext/addresses.rb#25
  def x_original_to_addresses; end

  private

  # source://actionmailbox//lib/action_mailbox/mail_ext/addresses.rb#34
  def address_list(obj); end
end

module Rails; end
module Rails::Conductor; end
module Rails::Conductor::ActionMailbox; end
module Rails::Conductor::ActionMailbox::InboundEmails; end

class Rails::Conductor::ActionMailbox::InboundEmails::SourcesController < ::Rails::Conductor::BaseController
  def create; end
  def new; end

  private

  def _layout(lookup_context, formats, keys); end

  class << self
    private

    def __class_attr_middleware_stack; end
    def __class_attr_middleware_stack=(new_value); end
  end
end

class Rails::Conductor::ActionMailbox::InboundEmailsController < ::Rails::Conductor::BaseController
  def create; end
  def index; end
  def new; end
  def show; end

  private

  def _layout(lookup_context, formats, keys); end
  def create_inbound_email(mail); end
  def mail_params; end
  def new_mail; end

  class << self
    private

    def __class_attr_middleware_stack; end
    def __class_attr_middleware_stack=(new_value); end
  end
end

class Rails::Conductor::ActionMailbox::IncineratesController < ::Rails::Conductor::BaseController
  def create; end

  private

  def _layout(lookup_context, formats, keys); end

  class << self
    private

    def __class_attr_middleware_stack; end
    def __class_attr_middleware_stack=(new_value); end
  end
end

class Rails::Conductor::ActionMailbox::ReroutesController < ::Rails::Conductor::BaseController
  def create; end

  private

  def _layout(lookup_context, formats, keys); end
  def reroute(inbound_email); end

  class << self
    private

    def __class_attr_middleware_stack; end
    def __class_attr_middleware_stack=(new_value); end
  end
end

class Rails::Conductor::BaseController < ::ActionController::Base
  private

  def _layout(lookup_context, formats, keys); end
  def ensure_development_env; end

  class << self
    private

    def __class_attr___callbacks; end
    def __class_attr___callbacks=(new_value); end
    def __class_attr__layout; end
    def __class_attr__layout=(new_value); end
    def __class_attr__layout_conditions; end
    def __class_attr__layout_conditions=(new_value); end
    def __class_attr_middleware_stack; end
    def __class_attr_middleware_stack=(new_value); end
  end
end
