require 'sinatra'
require 'sinatra/contrib'
require_relative 'models/line'

enable :sessions

get '/story/start' do #back to the start
 
end

get '/story/next' do #when one of the user added links are clicked
 
end

get '/story' do
  @saved_line = session["line"]
  @saved_pos = session["pos"]
  session["line"] = ""
  session["pos"] = ""
  erb :index
end

get '/' do
  @central_line = Line.new(0, "once there was a bad wolf")
  session["story"] = [@central_line] 
  session["startline"] = @central_line
  erb :index
end

post '/newline' do
    addToStory(params["line"])
    session["pos"] = params["pos"]
    session["line"] = params["line"]
  redirect '/story'
end 

#create a line and add it to the story array
def addToStory(storytext)
  pid = session["startline"].parent_id
  session["story"] << Line.new(pid, storytext)
end  



def reset(line)#move the chosen link to the centre
end  