require File.expand_path("../application",__FILE__)

class BaseController
  attr_accessor :env, :headers
  def initialize(env)
    @env = env
    @headers = {}
  end

  def action_name
    @env[:"app.action_name"]
  end

  def controller_name
    @env[:"app.controller_name"]
  end

  def headers
    @headers
  end

  def process_action(action)
    code = 200
    begin
      result = send(action).to_s
    rescue StandardError => e
      code = 500
      result = [e.message, e.backtrace].flatten.join("\r")
    end
    [code, headers, [result]]
  end
end

class Router
  def self.dispatch(controller,action,env)
    begin
      return "#{controller}_controller".camelize.constantize.new(env.merge({:"app.action_name" => action, :"app.controller_name" => controller})).process_action(action)
    rescue StandardError => e
      msg = [e.message, e.backtrace].flatten.join("\r")
      [500, {}, [msg]]
    end
  end
end

class HelloWorld
  def self.response(env)
    [200, {}, ['Hello World']]
  end
end

#class App
  #def self.call(env)
      #HelloWorld.response(env)
  #end
#end

class App
  def self.mount path, app
    @@mounts ||= []
    @@mounts << {:path => /^#{path}/, :app => app}
  end

  def self.mounts
    @@mounts ||= []
  end

  def self.call(env)
    path = env['REQUEST_PATH']
    mounts.each do |m|
      if path =~ m[:path]
        return m[:app].call(env)
      end
    end
    t = path.split("/").select{|s| s.present?}
    if t.size == 2
      Router.dispatch(t[0], t[1], env)
    else
      HelloWorld.response(env)
    end
  end
end
class MountApp
  def self.call(env)
    [200, {}, ['hello in MountApp']]
  end
end
App.mount("/mount", MountApp)
