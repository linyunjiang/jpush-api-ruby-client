module JPush
  module Config
    extend self

    attr_reader :valid_platform

    def init(app_key, master_secret)
      options = {
        api_version: 'v3',
        push_api_host: 'https://api.jpush.cn/',
        device_api_host: 'https://device.jpush.cn/',
        report_api_host: 'https://report.jpush.cn/',
        valid_platform: ['android', 'ios']
      }
      @valid_platform = options[:valid_platform]
      @settings = options.merge!(app_key: app_key, master_secret: master_secret)
    end

  end
end
