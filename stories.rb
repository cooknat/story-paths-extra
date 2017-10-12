require 'sinatra'
require 'sinatra/contrib'
require_relative 'models/line'

enable :sessions

get '/story' do
  getCurrentLines
  erb :index
end

#when one of the user added links/back to the start are clicked
get '/:line' do 
 matchingLines = session["story"].select { |l| l.storyline == params[:line]}
 #get most recent matching line
 session["startline"] = matchingLines.last 
 getCurrentLines
 erb :index
end

get '/' do
  session["story"] ||= [Line.new(0, "centre", "Once upon a time, there was a big bad wolf.")]
  session["startline"] = session["story"].first
  getCurrentLines
  erb :index
end

post '/newline' do
  session["story"] <<  Line.new(session["startline"].id, params["pos"], params["line"])
  redirect '/story'
  p session["story"]
end 

#get array of lines with parent id equal to current centre line
def getCurrentLines
  session["currentpage"] = session["story"].select do |line|
    line.parent_id == session["startline"].id
  end  
  session["currentpage"]
end  