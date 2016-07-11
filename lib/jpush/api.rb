require 'jpush/device'
require 'jpush/push'
require 'jpush/report'
require 'jpush/schedule'

module JPush
  module API
    def devices
      Device.base_url(@settings)
      Device
    end

    def tags
      Tag.base_url(@settings)
      Tag
    end

    def aliases
      Alias.base_url(@settings)
      Alias
    end

    def pusher
      Push.base_url(@settings)
      Push
    end

    def reporter
      Report.base_url(@settings)
      Report
    end

    def schedules
      Schedule.base_url(@settings)
      Schedule
    end
  end

  class Client
    include JPush::API

    def initialize(app_key, master_secret)
      @settings = JPush::Config.init(app_key, master_secret)
    end

  end

end
