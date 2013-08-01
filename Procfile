web: bundle exec puma -w 3 --threads 5:5 -p $PORT -e $RACK_ENV
sidekiq: bundle exec sidekiq -e $RAILS_ENV 
clockwork: bundle exec clockwork config/clock.rb
