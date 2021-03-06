module Spring
  module Commands
    class RSpec
      def env(*)
        return ENV['RAILS_ENV'] || 'test'

        if ENV['RAILS_ENV'] && ENV['RAILS_ENV'] != 'development'
          ENV['RAILS_ENV']
        else
          'test'
        end
      end

      def exec_name
        "rspec"
      end

      def gem_name
        "rspec-core"
      end

      def call
        ::RSpec.configuration.start_time = Time.now if defined?(::RSpec.configuration.start_time)
        load Gem.bin_path(gem_name, exec_name)
      end
    end

    Spring.register_command "rspec", RSpec.new
    Spring::Commands::Rake.environment_matchers[/^spec($|:)/] = ENV['RAILS_ENV'] || 'test'
  end
end
