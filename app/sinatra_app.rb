require 'vendor/sinatra-0.9.1.2/lib/sinatra'
require 'vendor/sinatras-hat-0.1.2/lib/sinatras-hat'
require 'activerecord'
require 'lib/post'

class SinatraApp < Sinatra::Base
  mount Post do
    only :create
    after :create do |on|
      on.success { |record| "Sinatra Created!" }
    end
  end
end
