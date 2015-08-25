source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Add for AngularJS
gem 'angular-rails-templates'
gem 'bower-rails'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Gems for easier debugging
  # commenting out for CircleCI
  # gem "binding_of_caller"
  # gem "better_errors"

  # Use Bullet to plan better ActiveRecord queries
  gem 'bullet'

  # Use Rspec for testing
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers'

  # Use Capybara, SimpleCov, JSON-Spec for testing
  gem 'capybara'
  gem 'simplecov', :require => false
  gem 'json_spec'

  # Add awesome print for human friendly object reading
  gem 'awesome_print'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # commenting out for CircleCI
  # gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.3.4'
end

# deploying to Heroku
group :production do
  gem 'rails_12factor'
  gem 'puma'
end