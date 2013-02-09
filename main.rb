require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'

get '/' do
  redirect "/view"
end

post '/add' do
  @name = params[:name].gsub("'","")
  @description = params[:description].gsub("'","")
  sql = "insert into todo (name, description) values ('#{@name}', '#{@description}');"
  run_sql(sql)
  redirect to ("/view")
end

get '/view' do
  sql = "select name, description from todo;"
  @rows = run_sql(sql)
  erb :home
end

def run_sql(sql)
  conn = PG.connect(:dbname =>'todo', :host => 'localhost')
  result = conn.exec(sql)
  conn.close
  result
end
