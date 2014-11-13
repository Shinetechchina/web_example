require ::File.expand_path('../app',  __FILE__)

app = Rack::Builder.new do 
  use Reloader
  run App
end

Rack::Server.start :app => app, :Port => 2000
