source 'https://rubygems.org'

ruby '2.1.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0.beta1'
# i18n
gem 'rails-i18n'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0.beta1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# versioning registries
gem 'paper_trail', '~> 3.0.5'

# auth
gem 'devise', github: 'plataformatec/devise', branch: 'lm-rails-4-2'
gem 'devise-i18n'
gem 'devise_invitable'

# Twitter Bootstrap
gem 'bootstrap-sass'

# Autoprefixer is a tool to parse CSS and add vendor prefixes to CSS rules
gem 'autoprefixer-rails'

# font-awesome-rails provides the Font-Awesome web fonts and stylesheets
# as a Rails engine for use with the asset pipeline
gem 'font-awesome-rails'

# The select2-rails gem integrates the Select2 jQuery plugin
# with the Rails asset pipeline.
gem 'select2-rails'

# Forms made easy for Rails! It's tied to a simple DSL
# with no opinion on markup
gem 'simple_form', '~> 3.1.0.rc2'

gem 'responders', '~> 2.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Rails Html Sanitizer for HTML sanitization
gem 'rails-html-sanitizer', '~> 1.0'

# Serviço de envio de email com templates e API REST
# gem 'mandrill-api', require: 'mandrill'

# Use Unicorn as the app server
group :production do
  gem 'unicorn'
  gem 'rails_12factor'
end

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'debugger' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # debugging
  gem 'better_errors'
  gem 'binding_of_caller'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Show queries need improvement
  gem 'bullet'

  # Specs
  gem 'rspec-rails', '~> 3.0.0'
  gem 'capybara'
  gem 'shoulda'
end