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
gem 'rmagick'

group :development, :test do
  gem 'sqlite3', '~> 1.4'
  gem 'byebug'
end

group :production do
  gem 'pg'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  # Preview email in the default browser instead of sending it in development
  gem "letter_opener"

  gem 'capistrano', '~> 3.11'
  gem 'capistrano-rails', '~> 1.4'
  gem 'capistrano-passenger', '~> 0.2'
  gem 'capistrano-rbenv', '~> 2.1'
  gem 'capistrano-bundler', '~> 1.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
