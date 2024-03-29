module SpreeSeedCredits
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_seed_credits'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'spree.register.seed_credits' do |app|
      # app.config.spree.calculators.promotion_actions_create_item_adjustments << Spree::Calculator::SeedCreditCalculator
      app.config.spree.adjusters << Spree::Adjustable::Adjuster::SeedCreditAdjuster
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
