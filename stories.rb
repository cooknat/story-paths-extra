require 'sinatra'
require 'sinatra/contrib'
require_relative 'models/line'

enable :sessions

get '/story' do
  session["currentpage"] = session['story'].select do |line|
    line.parent_id == session["startline"].id
  end 
  erb :index
end

get '/:line' do #when one of the user added links or back to the start are clicked
 new_start = session["story"].detect { |l| l.storyline == params[:line]} 
 session["startline"] = new_start
 session["currentpage"] = session['story'].select do |line|
    line.parent_id == session["startline"].id
  end 
 erb :index
end

get '/' do
  @startLine = Line.new(0, "centre", "once there was a bad wolf")
  session["story"] = [@startLine]
  session["startline"] = @startLine
  session["currentpage"] = []
  erb :index
end

post '/newline' do
  addToStory(params["line"], params["pos"])
  redirect '/story'
end 

#create a line and add it to the story array
def addToStory(storytext, pos)
  pid = session["startline"].id
  session["story"] <<  Line.new(pid, pos, storytext)
  p session["story"]
end  

