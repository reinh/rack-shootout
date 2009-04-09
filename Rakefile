require 'rubygems'
require 'date'
require 'spec/rake/spectask'
require 'lib/shootout/graph'

task :default => :spec

desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = %w(-fs --color)
end

namespace :shootout do
  desc "Run the framework shootout"
  task :frameworks do
    command = 'curl -s -d "post[title]=This Post Is From %s" -d "post[body]=This Post Also Has A Body" localhost:3000/%s/posts > /dev/null'

    %w(rack rails sinatra).each do |framework|
      puts
      puts "== #{framework.upcase} =="
      AsciiGraph.time(command % [framework, framework])
    end
  end
end

task :environment do
  require "activerecord"
  ActiveRecord::Base.establish_connection(
    :adapter  => 'mysql',
    :database => 'rack_shootout',
    :username => 'root',
    :host     => 'localhost'
  )
end

namespace :server do
  desc "Start the Thin server"
  task :start do
    system "thin -R config.ru -e production start"
  end
end

desc "Migrate the database"
task :migrate => :environment do
  ActiveRecord::Schema.define do
    create_table :posts, :force => true do |t|
      t.column :title, :string
      t.column :body,  :string
    end
  end
end
