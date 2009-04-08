require 'activerecord'
require 'app/sinatra_app'
require 'app/rack_app'
require 'app/rails_app'

app =  Rack::Builder.new do
  ActiveRecord::Base.establish_connection(
    :adapter  => 'mysql',
    :database => 'rack_shootout',
    :username => 'root',
    :host     => 'localhost'
  )


  map "/rack" do
    run RackApp
  end

  map "/rails" do
    run ActionController::Dispatcher.new
  end

  map "/sinatra" do
    run SinatraApp
  end
end

run app
