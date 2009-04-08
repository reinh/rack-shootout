require 'rack/contrib'
require 'sinatra'
require 'sinatras-hat'
require 'activerecord'
require 'lib/post'

class SinatraApp < Sinatra::Base
  mount Post do
    only :create
    after :create do |on|
      on.success { |record| "Sinatra Created" }
    end
  end
end
