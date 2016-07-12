require '../test_helper'

module JPush
  class AliasTest < JPush::Test

    def test_show
      test_alias = 'TEST_ALIAS'
      @@jpush.devices.update_alias($test_common_registration_id, test_alias)

      response = @@jpush.aliases.show(test_alias)
      assert_equal 200, response.http_code

      body = response.body
      assert_equal 1, body.length
      assert_true body.has_key?('registration_ids')
      assert_instance_of(Array, body['registration_ids'])
      assert_true body['registration_ids'].include?($test_common_registration_id)

      @@jpush.aliases.delete(test_alias)

      body = @@jpush.aliases.show(test_alias).body
      assert_true body['registration_ids'].empty?
    end

    def test_show_with_invalid_alias
      response = @@jpush.aliases.show('INVALID_ALIAS')
      assert_equal 200, response.http_code
      assert_true response.body['registration_ids'].empty?
    end

    def test_delete
      test_alias = 'TEST_ALIAS'

      @@jpush.devices.update_alias($test_common_registration_id, test_alias)
      body = @@jpush.aliases.show(test_alias).body
      assert_false body['registration_ids'].empty?
      assert_true body['registration_ids'].include?($test_common_registration_id)

      response = @@jpush.aliases.delete(test_alias)
      assert 200, response.http_code

      body = @@jpush.aliases.show(test_alias).body
      assert_true body['registration_ids'].empty?

      body = @@jpush.devices.show($test_common_registration_id).body
      assert_nil body['alias']
    end

    def test_delete_invalid_alias
      body = @@jpush.aliases.show('INVALID_ALIAS').body
      assert_true body['registration_ids'].empty?

      response = @@jpush.aliases.delete('INVALID_ALIAS')
      assert 200, response.http_code

      body = @@jpush.aliases.show('INVALID_ALIAS').body
      assert_true body['registration_ids'].empty?
    end

  end
end
