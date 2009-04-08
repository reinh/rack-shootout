require "rubygems"
require "activerecord"

ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql',
  :database => 'rack_shootout',
  :username => 'root',
  :host     => 'localhost'
)

ActiveRecord::Schema.define do
  create_table :posts, :force => true do |t|
    t.column :title, :string
    t.column :body,  :string
  end
end

