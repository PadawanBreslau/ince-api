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

`InceApi::CreateAccessToken.new(username: '<<YOUR USERNAME>>', password: '<<YOUR PASSWORD>>').create_token`

which will return data of following structure

`{"status_code"=>200, "access_token"=>"eyJpZHRvoiZXl[..]hTXp0dWHpBIn0=", "token_type"=>"bearer", "expires_in"=>3600, "userId"=>"user", "scope"=>"all"}`

or 

`{"statusCode"=>400, "errorCode"=>"CognitoAuthenticationError", "message"=>"Incorrect username or password."}`

if authentication failed
