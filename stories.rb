require 'sinatra'
require 'sinatra/contrib'
require_relative 'models/line'

enable :sessions

get '/story/start' do
 
end

get '/story' do
  @saved_line = session["line"]
  @saved_pos = session["pos"]
  p @saved_line
  session["line"] = ""
  session["pos"] = ""
  erb :index
end

get '/' do
  session["story"] = [] 
 # @initial_line = Line.new(0, "once there was a bad wolf")
  erb :index
end

post '/newline' do
    p params.inspect
    @newline = params["line"]
    p @newline
    addToStory(@newline)
    p session["story"]
    p session["story"].length
    session["pos"] = params["pos"]
    session["line"] = params["line"]
    
  redirect '/story'
  
end 

#create a line and add it to the story array
def addToStory(storytext)
  newln = Line.new(0, storytext)
  session["story"] << newln
  #session["line"] = newln.storyline
end  

def getParentID#needed to properly create the Line object
end  

def reset(line)#move the chosen link to the centre
end  