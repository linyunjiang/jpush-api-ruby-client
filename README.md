[![](http://community.jpush.cn/uploads/default/original/1X/a1dbd54304178079e65cdc36810fdf528fdebe24.png)](http://community.jpush.cn/)

# JPush API Ruby Client

这是根据自己需求对极光官方 JPush REST API 进行修改，修改成可以同时推送（除了推送，其他功能有改了）给多个应用。

调用方法如下：

```ruby
  @jpush_1 = JPush::Client.new(app_key_1, master_secret_1)
  @jpush_2 = JPush::Client.new(app_key_2, master_secret_2)
  push_payload = Push::PushPayload.new(platform: 'all', audience: 'all', notification: 'hello from push api')
  @jpush_1.pusher.push(push_payload)
  @jpush_2.pusher.push(push_payload)
```
其他方法的调用也是用@jpush_1/@jpush_2来调用

注：请不要将 @jpush_1.pusher 赋给某一变量， 因为每次@jpush_1都会给pusher传值，所以@jpush_1.pusher.push不要拆开

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jpush', github: 'linyunjiang/jpush-api-ruby-client'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

```bash
# 复制测试的配置文件
$ cp test/config.yml.example test/config.yml

# 编辑 test/config.yml 文件，填入必须的变量值
# OR 设置相应的环境变量

# 运行全部测试用例
$ bundle exec rake

# 运行某一具体测试用例
$ bundle exec rake test TEST=test/jpush/xx_test.rb
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jpush/jpush-api-ruby-client.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
