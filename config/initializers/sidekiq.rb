sidekiq_redis = { url: $redis.url, namespace: 'sidekiq', :size => 1 }

Sidekiq.configure_server { |config| config.redis = sidekiq_redis }
Sidekiq.configure_client { |config| config.redis = sidekiq_redis }
