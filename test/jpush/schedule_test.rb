require 'test_helper'

module JPush
  class PushTest < JPush::Test

    def setup
      @push_payload = Push::PushPayload.new(platform: 'all', audience: 'all', notification: 'hello from schedule api')
      @schedule_payload = Schedule::SchedulePayload.new('jpush', Time.new(2020), @push_payload)
    end

    def test_create
      response = @@jpush.schedules.create(@schedule_payload)
      assert_equal 200, response.http_code
      body = response.body
      assert_equal 2, body.size
      assert_equal 'jpush', body['name']
    end

    def test_tasks
      response = @@jpush.schedules.tasks
      assert_equal 200, response.http_code
      assert_instance_of Hash, response.body
      assert_equal 4, response.body.size
    end

    def test_show
      assert_raises Utils::Exceptions::JPushResponseError do
        @@jpush.schedules.show('INVALID_SCHEDULE_ID')
      end

      schedule_id = @@jpush.schedules.tasks.body['schedules'].first['schedule_id']
      response = @@jpush.schedules.show(schedule_id)
      assert_equal 200, response.http_code
      body = response.body
      assert_equal 5, body.size
    end

    def test_update
      assert_raises  JPush::Utils::Exceptions::JPushResponseError do
        @@jpush.schedules.update('INVALID_SCHEDULE_ID', name: 'jpush_ruby')
      end
      schedule_id = @@jpush.schedules.tasks.body['schedules'].first['schedule_id']
      response = @@jpush.schedules.update(schedule_id, name: 'jpush_ruby')
      assert_equal 200, response.http_code
    end

    def test_delete
      schedule_id = @@jpush.schedules.tasks.body['schedules'].first['schedule_id']
      response = @@jpush.schedules.delete(schedule_id)
      assert_equal 200, response.http_code
    end

  end
end
