source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'nokogiri'
gem 'jquery-rails'

gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'bootstrap_form', :git => "git@github.com:bootstrap-ruby/rails-bootstrap-forms.git", :branch => "bootstrap-v4"
gem 'annotate', require: false
gem 'open_uri_redirections'
gem 'whenever', :require => false

group :development, :test do
  gem 'pry-byebug'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0.0'
end