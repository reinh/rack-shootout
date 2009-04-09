require 'rubygems'
require "action_controller"
require 'dispatcher'

# Rails pwned
ActionController::Base.session = { :session_key => "_myapp_session", :secret => "some secret phrase of at least 30 characters" }
ActionController::Routing.use_controllers! ['home']

class ActionController::Dispatcher
  def prepare_application
  end
end

# And your routes
ActionController::Routing::Routes.draw do |map|
  map.namespace :rails do |rails|
    rails.resources :posts
  end
end

module Rails
end

# Application code
class Rails::PostsController < ActionController::Base
  def create
    post = Post.new(params["post"])
    if post.save
      render :text => "Rails Created!"
    else
      render :text => ("Errors:\n" + post.errors.full_messages.to_yaml), :status => 400
    end
  end
  
  def index; create; end
end
