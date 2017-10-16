require 'sinatra'
require_relative 'models/line'

enable :sessions

#route back to main page after a line has been added
get '/story' do
  session["currentpage"] = getCurrentLines(session["startline"].id)
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
    session["currentpage"] = getCurrentLines(session["startline"].id)
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
 session["currentpage"] = getCurrentLines(session["startline"].id)
 erb :index
end

#root route
get '/' do
  session["story"] ||= [Line.new(0, "centre", generateStarter)]
  session["startline"] = session["story"].first
  seed
  session["currentpage"] = getCurrentLines(session["startline"].id)
  erb :index
end

post '/newline' do
  session["story"] <<  Line.new(session["startline"].id, params["pos"], params["line"])
  redirect '/story'
end 

#get array of lines with parent id equal to current centre line
#note - thought about doing this in the erb but decided to keep functionality away from view
#rewrite to take a variable and return a variable
def getCurrentLines(id_of_parent)
  children = session["story"].select do |line|
    line.parent_id == id_of_parent
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
  @storytrail = session["story"].first.storyline
  @pid = session["story"].first.id
  
  until pickChild(@pid) == nil #as long as pickchild is returning something, the story can go on
    next_child = pickChild(@pid)
    next_line = next_child.storyline
    @storytrail = "#{@storytrail} #{next_line}"
    @pid = next_child.id
  end
end  

def pickChild(pid)
  to_pick_from = getCurrentLines(pid)
  to_pick_from.sample
end  

def seed
  session["story"] << Line.new(2, "a", "It was dark.")
  session["story"] << Line.new(2, "b", "The sky was yellow.")
  session["story"] << Line.new(2, "c", "The moon was full.")
  session["story"] << Line.new(2, "d", "The sun was out.")
  session["story"] << Line.new(3, "b", "It was a rainy Monday.")
  session["story"] << Line.new(3, "a", "It was a snowy Tuesday.")
  session["story"] << Line.new(3, "c", "It was a sunny Wednesday.")
  session["story"] << Line.new(3, "d", "It was a windy Thursday.")
  session["story"] << Line.new(6, "b", "And all the cake was free.")
  session["story"] << Line.new(6, "a", "And chocolate grew on trees.")
  session["story"] << Line.new(8, "a", "There was a man.")
  session["story"] << Line.new(8, "c", "There was a woman.")
  session["story"] << Line.new(8, "d", "There was a small horse.")
  session["story"] << Line.new(14, "a", "The cherry trees were in bloom.")
  session["story"] << Line.new(14, "c", "He ate mangoes.")
  session["story"] << Line.new(14, "d", "She liked oranges.")
  session["story"] << Line.new(4, "a", "There were always hash browns for breakfast.")
  session["story"] << Line.new(4, "b", "There were always beans for breakfast.")
  session["story"] << Line.new(4, "c", "There were always mushrooms for breakfast.")
  session["story"] << Line.new(4, "d", "There were always waffles for breakfast.")
  session["story"] << Line.new(5, "a", "Kittens frolicked.")
  session["story"] << Line.new(5, "b", "Puppies wrestled.")
  session["story"] << Line.new(5, "c", "Foals leapt.")
  session["story"] << Line.new(5, "d", "Lambs gambolled.")
  session["story"] << Line.new(9, "a", "She ate all the green beans.")
  session["story"] << Line.new(9, "b", "He ate all the carrots.")
  session["story"] << Line.new(9, "c", "She hated broccoli.")
  session["story"] << Line.new(9, "d", "He loved butternut squash.")
  session["story"] << Line.new(25, "a", "The ketchup was gone.")
  session["story"] << Line.new(25, "b", "The mayo was lumpy.")
  session["story"] << Line.new(25, "c", "There was lots of chilli sauce.")
  session["story"] << Line.new(25, "d", "There was salt and pepper.")
  session["story"] << Line.new(28, "a", "They lived in London.")
  session["story"] << Line.new(28, "b", "They lived in Manchester.")
  session["story"] << Line.new(28, "c", "They lived in Helsinki.")
  session["story"] << Line.new(28, "d", "They lived in the Outer Hebrides.")
end  