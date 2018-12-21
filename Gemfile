source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'passenger', '~> 6.0'
gem 'oj', '~> 3.7.4'
gem 'jsonapi-rails', '~> 0.3.1'
gem 'validates_timeliness', '~> 5.0.0.alpha3'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # gem 'better_errors'
  # gem "binding_of_caller"
  gem 'factory_bot_rails', '~> 4.11.1'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.8'
end

group :development do
  gem 'annotate', '~> 2.7.4'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner', '~> 1.7.0'
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'rails-controller-testing'
  gem 'simplecov', '~> 0.16.1', require: false
end