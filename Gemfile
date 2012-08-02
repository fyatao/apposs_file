source "http://ruby.taobao.org"

# Declare your gem's dependencies in apposs_file.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"
gem "faraday"
# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
group 'development' do
  gem 'seed-fu'
  gem 'pry'
  gem 'pry-nav'
end

group 'test' do
  gem 'rspec'
  gem 'rspec-rails'
end

group 'assets' do
  gem 'twitter-bootstrap-rails'
  gem 'uglifier'
  gem 'coffee-rails'
  gem 'sass-rails'
end
