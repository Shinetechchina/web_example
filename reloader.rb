#require File.expand_path("../application",__FILE__)

class Reloader
  def self.reloader
    files = Dir["#{ROOT}/app/**/*.rb"]
    @reloader ||= ActiveSupport::FileUpdateChecker.new(files) do
      puts "reload..."
      ActiveSupport::DescendantsTracker.clear
      ActiveSupport::Dependencies.clear
    end
  end

  def initialize(app)
    @app = app
  end

  def call(env)
    Reloader.reloader.execute_if_updated
    @app.call env
  end
end

def reload!
  Reloader.reloader.execute
end
