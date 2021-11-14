# ince-api
Wrapper for 1nce API [API documentation](https://help.1nce.com/dev-hub/reference/api-welcome)

## Instalation

The ince-api gem is available at rubygems.org. You can install with:

`gem install ince-api`

Alternatively, you can install the gem with bundler:

\# Gemfile

`gem 'ince-api'`

After doing bundle install, you should have the gem installed in your bundle.

## Generating Access Token
In order to access 1nce API you need to add new API user in 1nce Admin panel.

If you want to authenticate and obtain Access Token you need to run following code

```ruby
InceApi::CreateAccessToken.new(username: '<<YOUR USERNAME>>',
                               password: '<<YOUR PASSWORD>>').create_token
```
which will return data of following structure

`{"status_code"=>200, "access_token"=>"eyJpZHRvoiZXl[..]hTXp0dWHpBIn0=", "token_type"=>"bearer", "expires_in"=>3600, "userId"=>"user", "scope"=>"all"}`

or 

`{"statusCode"=>400, "errorCode"=>"CognitoAuthenticationError", "message"=>"Incorrect username or password."}`

if authentication failed

## Getting SIM values

If you want to retrieve list of your SIM card you need to use the Access Token generated before. You can pass params hash - according to [DOCS](https://help.1nce.com/dev-hub/reference/general-sim#getsimsusingget)

```ruby
token = InceApi::CreateAccessToken.new(username: '<<YOUR USERNAME>>', password: '<<YOUR PASSWORD>>').create_token['access_token']
sims = InceApi::GetSims.new(access_token: token, params: <<PARAM HASH>>).sims
```

which will return data of following structure

`[{"iccid"=>"XXXXXXXXXXXXXXX", "imsi"=>"XXXXXXXXXXXXXX", "msisdn"=>"XXXXXXXXXXXXXXXXX", "imei"=>"XXXXXXXXXXXXXX", "imei_lock"=>false, "status"=>"Enabled", "activation_date"=>"2021-08-26T12:13:06.000+0000", "ip_address"=>"XX.XXX.XXX.X", "current_quota"=>500, "quota_status"=>{"id"=>0, "description"=>"More than 20% available"}, "current_quota_SMS"=>250, "quota_status_SMS"=>{"id"=>0, "description"=>"More than 20% available"}},[...]`

You can also fetch single card
```ruby
token = InceApi::CreateAccessToken.new(username: '<<YOUR USERNAME>>', password: '<<YOUR PASSWORD>>').create_token['access_token']
sims = InceApi::GetSim.new(access_token: token, iccid: 'XXXXXXXXX').sim
```
