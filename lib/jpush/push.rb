require 'jpush/helper/argument_helper'
require 'jpush/push/push_payload'
require 'jpush/http/client'

module JPush
  module Push
    extend self
    extend Helper::ArgumentHelper

    # POST https://api.jpush.cn/v3/push/validate
    # 验证推送调用是否能够成功，与推送 API 的区别在于：不向用户发送任何消息
    def validate(push_payload)
      url =  "#{@base_url}validate"
      send_push(@config_settings, url, push_payload)
    end

    # POST https://api.jpush.cn/v3/push
    # 向某单个设备或者某设备列表推送一条通知、或者消息
    def push(push_payload)
      send_push(@config_settings, @base_url, push_payload)
    end

    def base_url(settings)
      @config_settings = settings
      @base_url = settings[:push_api_host] + settings[:api_version] + '/push/'
    end

    private

    def send_push(settings, url, push_payload)
      push_payload = push_payload.is_a?(PushPayload) ? push_payload : nil
      body = push_payload.to_hash
      Http::Client.post(settings, url, body: body)
    end

  end
end
