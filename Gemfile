source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'carrierwave', '~> 2.0'
gem 'devise'
gem 'devise-i18n'
gem 'fog-aws'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'rails-i18n'
gem 'puma', '~> 4.1'
gem 'uglifier'
gem 'webpacker', '~> 4.0'
gem 'font_awesome5_rails'
gem 'omniauth-github'
gem 'omniauth-yandex'
gem 'pundit', '~> 2.2'
gem 'rmagick'
gem 'resque', '~> 2.4'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'sqlite3', '~> 1.4'
  gem 'pundit-matchers', '~> 1.7.0'
end

group :production do
  gem 'pg'
end

group :development do
  # Preview email in the default browser instead of sending it in development
  gem 'bcrypt_pbkdf', '~> 1.0'
  gem 'ed25519', '~> 1.2'
  gem 'capistrano', '~> 3.11'
  gem 'capistrano-rails', '~> 1.4'
  gem 'capistrano-passenger', '~> 0.2'
  gem 'capistrano-rbenv', '~> 2.1'
  gem "capistrano-resque", "~> 0.2.2", require: false
  gem 'capistrano-bundler', '~> 1.2'
  gem "letter_opener"
  gem 'web-console', '>= 3.3.0'
end
