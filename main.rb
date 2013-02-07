require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'

get '/' do
  redirect "/view"
end

post '/add' do
  @name = params[:name]
  @description = params[:description]

  sql = "insert into todo (name, description) values ('#{@name}', '#{@description}');"

  conn = PG.connect(:dbname =>'todo', :host => 'localhost')
  conn.exec(sql)
  conn.close

  redirect "/view"


end

get '/view' do
  sql = "select name, description from todo;"

  conn = PG.connect(:dbname =>'todo', :host => 'localhost')
  @rows = conn.exec(sql)
  #binding.pry
  conn.close


  erb :home

end

