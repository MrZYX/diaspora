module Workers
  class Sentry < Base
    sidekiq_options queue: :low

    def perform(event)
      Raven.send_event(event)
    end
  end
end
