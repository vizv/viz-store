source 'https://rubygems.org'
ruby '2.2.0'

# rail framework, yeah!
gem 'rails', '4.2.1'

# template engine
gem 'haml-rails', '~> 0.9'
gem 'jbuilder', '~> 2.0'

# asset pipeline
gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'uglifier', '>= 1.3.0'

# TODO: do we really need it?
gem 'therubyracer', platforms: :ruby

# for persistent storage
gem 'mongoid', '~> 4.0.0'
gem 'mongoid-grid_fs'

# FIXME: remove us after migrate to AngularJS
gem 'jquery-rails'
gem 'turbolinks'

# production server app
gem 'unicorn'

# development deps
group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'pry-rails'
end

# development & test deps
group :development, :test do
  gem 'spring'
  gem 'thin'
end

