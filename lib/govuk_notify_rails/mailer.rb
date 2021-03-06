module GovukNotifyRails
  class Mailer < ActionMailer::Base
    default delivery_method: :govuk_notify

    attr_accessor :govuk_notify_template
    attr_accessor :govuk_notify_reference
    attr_accessor :govuk_notify_personalisation

    protected

    def mail(headers = {})
      raise ArgumentError, 'Missing template ID. Make sure to use `set_template` before calling `mail`' if govuk_notify_template.nil?

      headers[:body] ||= _default_body

      message = super(headers)
      message.govuk_notify_template = govuk_notify_template
      message.govuk_notify_reference = govuk_notify_reference
      message.govuk_notify_personalisation = govuk_notify_personalisation
    end

    def set_template(template)
      self.govuk_notify_template = template
    end

    def set_reference(reference)
      self.govuk_notify_reference = reference
    end

    def set_personalisation(personalisation)
      self.govuk_notify_personalisation = personalisation
    end

    def _default_body
      'This is a GOV.UK Notify email with template %s and personalisation: %s' % [govuk_notify_template, govuk_notify_personalisation]
    end
  end
end
