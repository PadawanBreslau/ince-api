Gem::Specification.new do |s|
  s.name        = 'ince-api'
  s.version     = '0.0.1'
  s.summary     = "1nce API wrapper"
  s.description = "A simple wrapper for 1nce API"
  s.authors     = ["Stanislaw Zawadzki"]
  s.email       = 'st.zawadzki@gmail.com'
  s.homepage    = 'https://rubygems.org/gems/ince-api'
  s.license       = 'MIT'

  s.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
  s.license       = 'MIT'
  s.add_dependency 'uri', '~> 0.11'
  s.add_dependency 'net-http', '~> 0.2'
  s.add_dependency 'openssl', '~> 2.2'
  s.add_dependency 'base64', '~> 0.1'
end

