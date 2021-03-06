source 'https://rubygems.org'

ruby '2.0.0'

# monkey patching to support dual booting
module Bundler::SharedHelpers
  def default_lockfile=(path)
    @default_lockfile = path
  end
  def default_lockfile
    @default_lockfile ||= Pathname.new("#{default_gemfile}.lock")
  end
end

module ::Kernel
  def rails4?
    !!ENV["RAILS4"]
  end
end

if rails4?
  Bundler::SharedHelpers.default_lockfile = Pathname.new("#{Bundler::SharedHelpers.default_gemfile}_rails4.lock")

  # Bundler::Dsl.evaluate already called with an incorrect lockfile ... fix it
  class Bundler::Dsl
    # A bit messy, this can be called multiple times by bundler, avoid blowing the stack
    unless self.method_defined? :to_definition_unpatched
      alias_method :to_definition_unpatched, :to_definition
      puts "Booting in Rails 4 mode"
    end
    def to_definition(bad_lockfile, unlock)
      to_definition_unpatched(Bundler::SharedHelpers.default_lockfile, unlock)
    end
  end
end

if rails4?
  gem 'rails', '4.0.0'
  gem 'redis-rails', :git => 'git://github.com/SamSaffron/redis-store.git'
  gem 'rails-observers'
  gem 'actionpack-action_caching'
  gem 'seed-fu' , github: 'mbleigh/seed-fu'
  gem 'spork-rails', :github => 'sporkrb/spork-rails'
else
  # we had pain with the 3.2.13 upgrade so monkey patch the security fix
  # next time around we hope to upgrade
  gem 'rails', '3.2.12'
  gem 'strong_parameters' # remove when we upgrade to Rails 4
  # we are using a custom sprockets repo to work around: https://github.com/rails/rails/issues/8099#issuecomment-16137638
  # REVIEW EVERY RELEASE
  gem 'sprockets', git: 'https://github.com/SamSaffron/sprockets.git', branch: 'rails-compat'
  gem 'redis-rails'
  gem 'seed-fu'
  gem 'activerecord-postgres-hstore'
  gem 'active_attr'

  # not compatible, but we don't really use guard much anymore anyway
  # instead we use bundle exec rake autospec
  gem 'guard-spork', require: false
end

gem 'redis'
gem 'hiredis'
gem 'em-redis'

gem 'active_model_serializers'

# we had issues with latest, stick to the rev till we figure this out
# PR that makes it all hang together welcome
gem 'ember-rails'
gem 'ember-source', '1.0.0.rc6.2'
gem 'handlebars-source', '1.0.12'
gem 'barber'

gem 'vestal_versions', git: 'https://github.com/zhangyuan/vestal_versions'

gem 'message_bus', git: 'https://github.com/SamSaffron/message_bus'
gem 'rails_multisite', path: 'vendor/gems/rails_multisite'
gem 'simple_handlebars_rails', path: 'vendor/gems/simple_handlebars_rails'

gem 'redcarpet', require: false
gem 'airbrake', '3.1.2', require: false # errbit is broken with 3.1.3 for now
gem 'clockwork', require: false
gem 'eventmachine'
gem 'fast_xs'
gem 'fast_xor', git: 'https://github.com/CodeMonkeySteve/fast_xor.git'
gem 'fastimage'
gem 'fog', require: false

gem 'email_reply_parser', git: 'https://github.com/lawrencepit/email_reply_parser.git'

# note: for image_optim to correctly work you need
# sudo apt-get install -y advancecomp gifsicle jpegoptim libjpeg-progs optipng pngcrush
gem 'image_optim'
# note: for image_sorcery to correctly work you need
# sudo apt-get install -y imagemagick
gem 'image_sorcery'
gem 'multi_json'
gem 'mustache'
gem 'nokogiri'
gem 'omniauth'
gem 'omniauth-openid'
gem 'openid-redis-store'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-github'
gem 'omniauth-browserid', git: 'https://github.com/callahad/omniauth-browserid.git', branch: 'observer_api'
gem 'omniauth-cas'
gem 'oj'
gem 'pg'
gem 'rake'


gem 'rest-client'
gem 'rinku'
gem 'sanitize'
gem 'sass'
gem 'sidekiq'
gem 'sidekiq-failures'
gem 'sinatra', require: nil
gem 'slim'  # required for sidekiq-web
gem 'therubyracer', require: 'v8'
gem 'diffy', '>= 3.0', require: false
gem 'highline', require: false

gem 'puma'

# Heroku stuff
gem 'memcachier'
gem 'dalli'
gem 'mandrill-api'

# Gem that enables support for plugins. It is required.
gem 'discourse_plugin', path: 'vendor/gems/discourse_plugin'

# Discourse Plugins (optional)
# Polls and Tasks have been disabled for launch, we need think all sorts of stuff through before adding them back in
#   biggest concern is core support for custom sort orders, but there is also styling that just gets mishmashed into our core theme.
# gem 'discourse_poll', path: 'vendor/gems/discourse_poll'
gem 'discourse_emoji', path: 'vendor/gems/discourse_emoji'
# gem 'discourse_task', path: 'vendor/gems/discourse_task'

# Gems used only for assets and not required
# in production environments by default.
# allow everywhere for now cause we are allowing asset debugging in prd
group :assets do
  gem 'sass'
  gem 'sass-rails'
  gem 'turbo-sprockets-rails3'
  gem 'uglifier'
end

group :test do
  gem 'fakeweb', '~> 1.3.0', require: false
  gem 'minitest', require: false
end

group :test, :development do
  gem 'mock_redis'
  gem 'listen', require: false
  gem 'certified', require: false
  if rails4?
    gem 'fabrication', github: 'paulelliott/fabrication', require: false
  else
    gem 'fabrication', require: false
  end
  gem 'qunit-rails'
  gem 'guard-rspec', require: false
  gem 'mocha', require: false
  gem 'rb-fsevent', require: RUBY_PLATFORM =~ /darwin/i ? 'rb-fsevent' : false
  gem 'rb-inotify', '~> 0.9', require: RUBY_PLATFORM =~ /linux/i ? 'rb-inotify' : false
  gem 'rspec-rails', require: false
  gem 'shoulda', require: false
  gem 'simplecov', require: false
  gem 'terminal-notifier-guard', require: false
  gem 'timecop'
  gem 'rspec-given'
  gem 'pry-rails'
  gem 'pry-nav'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'librarian', '>= 0.0.25', require: false
  gem 'foreman'
  # https://github.com/ctran/annotate_models/pull/106
  gem 'annotate', :git => 'https://github.com/SamSaffron/annotate_models.git'
end



# this is an optional gem, it provides a high performance replacement
# to String#blank? a method that is called quite frequently in current
# ActiveRecord, this may change in the future
gem 'fast_blank' #, github: "SamSaffron/fast_blank"

# this provides a very efficient lru cache
gem 'lru_redux'

# IMPORTANT: mini profiler monkey patches, so it better be required last
#  If you want to amend mini profiler to do the monkey patches in the railstie
#  we are open to it. by deferring require to the initializer we can configure disourse installs without it
gem 'rack-mini-profiler', '0.1.28', require: false  # require: false #, git: 'git://github.com/SamSaffron/MiniProfiler'

# used for caching, optional
# redis-rack-cache is missing a sane expiry policy, it hogs redis
# https://github.com/jodosha/redis-store/pull/183
gem 'redis-rack-cache', git: 'https://github.com/SamSaffron/redis-rack-cache.git', require: false
gem 'rack-cache', require: false
gem 'rack-cors', require: false
gem 'unicorn', require: false

# perftools only works on 1.9 atm
group :profile do
  # travis refuses to install this, instead of fuffing, just avoid it for now
  #
  # if you need to profile, uncomment out this line
  # gem 'rack-perftools_profiler', require: 'rack/perftools_profiler', platform: :mri_19
end

