require 'graph'

command = 'curl -s -d "post[title]=This Post Has A Title" -d "post[body]=This Post Also Has A Body" localhost:4567/%s/posts > /dev/null'

%w(rack rails sinatra).each do |framework|
  puts
  puts framework.upcase
  VertiBar.time_command(command % framework)
end
