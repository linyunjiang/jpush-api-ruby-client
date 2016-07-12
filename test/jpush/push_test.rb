require '../test_helper'

module JPush
  class PushTest < JPush::Test

    def test_validate
      push_payload = Push::PushPayload.new(platform: 'all', audience: 'all', notification: 'hello from push api')
      response = @@jpush.pusher.validate(push_payload)
      assert_equal 200, response.http_code
      body = response.body

      assert_true body.has_key?('sendno')
      assert_true body.has_key?('msg_id')
    end

    def test_simple_push_all
      push_payload = Push::PushPayload.new(platform: 'all', audience: 'all', notification: 'hello from push api')
      response = @@jpush.pusher.push(push_payload)
      assert_equal 200, response.http_code
      body = response.body

      assert_true body.has_key?('sendno')
      assert_true body.has_key?('msg_id')
    end

    def test_push_full
      extras = {key0: 'value0', key1: 'value1'}
      notification = Push::Notification.new.set_android(alert: 'hello', title: 'hello android', extras: extras)
      push_payload = Push::PushPayload.new(platform: 'android', audience: 'all', notification: notification)
      response = @@jpush.pusher.push(push_payload)
      assert_equal 200, response.http_code
      assert_true response.body.has_key?('msg_id')
    end

    def test_simple_push_all_by_two_pusher
      push_payload_1 = Push::PushPayload.new(platform: 'all', audience: 'all', notification: 'hello from push api for pusher_1')
      push_payload_2 = Push::PushPayload.new(platform: 'all', audience: 'all', notification: 'hello from push api for pusher_2')
      response1 = @@jpush.pusher.push(push_payload_1)
      assert_equal 200, response1.http_code
      body1 = response1.body

      response2 = @@jpush_2.pusher.push(push_payload_2)
      assert_equal 200, response2.http_code
      body2 = response2.body

      assert_true body1.has_key?('sendno')
      assert_true body1.has_key?('msg_id')

      assert_true body2.has_key?('sendno')
      assert_true body2.has_key?('msg_id')
    end
  end
end
