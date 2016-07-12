require '../test_helper'

module JPush
  class DeviceTest < JPush::Test

    def test_show
      response = @@jpush.devices.show($test_common_registration_id)
      assert_equal 200, response.http_code

      body = response.body
      assert_true body.has_key?('tags')
      assert_true body.has_key?('alias')
      assert_true body.has_key?('mobile')
      assert_instance_of(Array, body['tags'])
    end

    def test_show_with_invalid_registration_id
      assert_raises Utils::Exceptions::JPushResponseError do
        response = @@jpush.devices.show('INVALID_REGISTRATION_ID')
      end
    end

    def test_update
      assert_raises Utils::Exceptions::JPushError do
        @@jpush.devices.update($test_common_registration_id)
      end
    end

    def test_add_and_remove_tags
      body = device_body($test_common2_registration_id)
      assert_false body['tags'].include?($test_common_tag)

      response = @@jpush.devices.add_tags($test_common2_registration_id, $test_common_tag)
      assert_equal 200, response.http_code

      body = device_body($test_common2_registration_id)
      assert_true body['tags'].include?($test_common_tag)

      response = @@jpush.devices.remove_tags($test_common2_registration_id, $test_common_tag)
      assert_equal 200, response.http_code

      body = device_body($test_common2_registration_id)
      assert_false body['tags'].include?($test_common_tag)
    end

    def test_add_invalid_tag_value
      invalid_tag = 'INVALID_TAG'

      body = tags_list_body
      assert_false body['tags'].include?(invalid_tag)
      before_tag_len = body['tags'].length

      body = device_body($test_common_registration_id)
      assert_false body['tags'].include?(invalid_tag)

      response = @@jpush.devices.add_tags($test_common_registration_id, invalid_tag)
      assert_equal 200, response.http_code

      body = device_body($test_common_registration_id)
      assert_true body['tags'].include?(invalid_tag)

      body = tags_list_body
      assert_true body['tags'].include?(invalid_tag)
      after_tag_len = body['tags'].length
      assert_equal 1, after_tag_len - before_tag_len

      @@jpush.tags.delete(invalid_tag)

      body = device_body($test_common_registration_id)
      assert_false body['tags'].include?(invalid_tag)

      body = tags_list_body
      assert_false body['tags'].include?(invalid_tag)
      final_tag_len = body['tags'].length

      assert_equal final_tag_len, before_tag_len
    end

    def test_remove_invalid_tag_value
      invalid_tag = 'INVALID_TAG'
      assert_false tags_list_body['tags'].include?(invalid_tag)

      body = device_body($test_common_registration_id)
      assert_false body['tags'].include?(invalid_tag)
      before_tag_len = body['tags'].length

      response = @@jpush.devices.remove_tags($test_common_registration_id, invalid_tag)
      assert_equal 200, response.http_code

      body = device_body($test_common_registration_id)
      assert_false body['tags'].include?(invalid_tag)
      after_tag_len = body['tags'].length

      assert_equal before_tag_len, after_tag_len
    end

    def test_add_and_remove_tags_with_invalid_registration_id
      assert_raises Utils::Exceptions::JPushResponseError do
        @@jpush.devices.add_tags('INVALID_REGISTRATION_ID', $test_common_tag)
      end
      assert_raises Utils::Exceptions::JPushResponseError do
        @@jpush.devices.remove_tags('INVALID_REGISTRATION_ID', $test_common_tag)
      end
    end

    def test_clear_tags
      body = device_body($test_common2_registration_id)
      assert_false body['tags'].include?($test_common_tag)

      @@jpush.devices.add_tags($test_common2_registration_id, $test_common_tag)

      body = device_body($test_common2_registration_id)
      assert_true body['tags'].include?($test_common_tag)

      response = @@jpush.devices.clear_tags($test_common2_registration_id)
      assert_equal 200, response.http_code

      body = device_body($test_common2_registration_id)
      assert_false body['tags'].include?($test_common_tag)
      assert_true body['tags'].empty?
    end

    def test_update_alias
      body = device_body($test_common_registration_id)
      origin_alias = body['alias']

      response = @@jpush.devices.update_alias($test_common_registration_id, 'JPUSH')
      assert_equal 200, response.http_code

      body = device_body($test_common_registration_id)
      assert_equal 'JPUSH', body['alias']

      response = @@jpush.devices.delete_alias($test_common_registration_id)
      assert_equal 200, response.http_code

      body = device_body($test_common_registration_id)
      assert_nil body['alias']

      unless origin_alias.nil?
        response = @@jpush.devices.update_alias($test_common_registration_id, origin_alias)
        assert_equal 200, response.http_code

        body = device_body($test_common_registration_id)
        assert_equal origin_alias, body['alias']
      end
    end

    def test_update_mobile
      body = device_body($test_common_registration_id)
      origin_mobile = body['mobile'] || 13888888888

      response = @@jpush.devices.update_mobile($test_common_registration_id, '13800138000')
      assert_equal 200, response.http_code

      body = device_body($test_common_registration_id)
      assert_equal 13800138000, body['mobile']

      response = @@jpush.devices.update_mobile($test_common_registration_id, origin_mobile.to_s)
      assert_equal 200, response.http_code

      body = device_body($test_common_registration_id)
      assert_equal origin_mobile, body['mobile']
    end

    def test_device_status
      response = @@jpush.devices.status($test_common_registration_id)
      assert_equal 200, response.http_code
      assert_instance_of Hash, response.body
      assert_instance_of Array, response.body.first
    end

    private

      def device_body(registration_id)
        @@jpush.devices.show(registration_id).body
      end

      def tags_list_body
        @@jpush.tags.list.body
      end

  end
end
