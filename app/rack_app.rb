require 'vendor/rack-1.0.0/lib/rack'
require 'vendor/rack-contrib-0.9.1/lib/rack/contrib'

require 'rack/builder'
require 'activerecord'
require 'lib/post'

class RackApp
  def self.app
    Rack::Builder.new do
      not_found = [404, {"Content-Type" => "text/plain"}, "Not Found"]

      map '/posts' do
        run lambda { |env|
          return not_found unless env["REQUEST_METHOD"] == "POST"
          request = Rack::Request.new(env)
          post = Post.new(request.params["post"])
          body = "Rack Created!"

          if post.save
            [200, {"Content-Type" => "text/plain", "Content-Length" => body.size.to_s}, body]
          else
            [400, {"Content-Type" => "text/plain"}, "Errors:\n" + post.errors.full_messages.to_yaml]
          end
        }
      end
    end.to_app
  end

  def self.call(env)
    app.call(env)
  end
end
