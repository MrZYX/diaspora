if AppConfig.environment.sentry_dsn.present?
  Raven.configure do |config|
    config.dsn = AppConfig.environment.sentry_dsn.to_s
    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
    config.async = ->(event) { Workers::Sentry.perform_async(event) }
    config.excluded_exceptions += [ActionController::UnknownFormat]
  end
end
