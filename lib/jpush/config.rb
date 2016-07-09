module JPush
  module Config
    extend self

    DEFAULT_OPTIONS = {
      api_version: 'v3',
      push_api_host: 'https://api.jpush.cn/',
      device_api_host: 'https://device.jpush.cn/',
      report_api_host: 'https://report.jpush.cn/',
      valid_platform: ['android', 'ios']
    }

    # attr_reader :settings

    def init(app_key, master_secret)
      init_settings = InitSettings.new(app_key, master_secret)
      @settings = init_settings.get_settings
    end

    class InitSettings
      def initialize(app_key, master_secret)
        @settings = DEFAULT_OPTIONS.merge!(app_key: app_key, master_secret: master_secret)
      end

      def get_settings
        @settings
      end
    end
  end
end
