require 'sinatra'
require_relative 'models/line'

enable :sessions

#route back to main page after a line has been added
get '/story' do
  session["currentpage"] = getCurrentLines(session["startline"])
  erb :index
end


get '/back' do
  #get current centre line and find its parent
  pid = session["startline"].parent_id
  #as long as its not the original line
  if pid > 0
    #reset centre to be that id
    session["startline"] = session["story"].detect {|l| l.id == pid}
  end    
    session["currentpage"] = getCurrentLines(session["startline"])
    erb :index
end  

get '/trail' do
 getStoryTrail
 erb :index
end  

#when one of the user added links/back to the start are clicked
#sometimes the app tries to start here and that seems to be what causes the server error
get '/:line' do 
 matchingLines = session["story"].select { |l| l.storyline == params[:line]}
 #get most recent matching line
 session["startline"] = matchingLines.last 
 session["currentpage"] = getCurrentLines(session["startline"])
 erb :index
end

#root route
get '/' do
  session["story"] ||= [Line.new(0, "centre", generateStarter)]
  session["startline"] = session["story"].first
  session["currentpage"] = getCurrentLines(session["startline"])
  erb :index
end

post '/newline' do
  session["story"] <<  Line.new(session["startline"].id, params["pos"], params["line"])
  redirect '/story'
end 


#def getCurrentLines
#  session["currentpage"] = session["story"].select do |line|
#    line.parent_id == session["startline"].id
#  end  
#  session["currentpage"]
#end  

#get array of lines with parent id equal to current centre line
#note - thought about doing this in the erb but decided to keep functionality away from view
#rewrite to take a variable and return a variable
def getCurrentLines(startline)
  children = session["story"].select do |line|
    line.parent_id == startline.id
  end  
  children
end  



def generateStarter
  startlines = ["Last night I dreamt I went to Manderley again.","There was no possibility of taking a walk that day.", "I write this sitting in the kitchen sink.", 
                "It was the best of times, it was the worst of times.", "It was a dark and stormy night.", "Once upon a time, there was a big bad wolf.", 
                "A great while ago, when the world was full of wonders...", "At a time when the rivers were made of chocolate and wishes could come true..."]
  startlines.sample
end  

def getStoryTrail
  max = session["story"].max_by { |l| l.parent_id }
  max_pid = max.parent_id
  @storytrail = session["story"].first.storyline
  
end  

def pickChild(pid)
end  