class Line
  attr_accessor :id, :position, :parent_id, :storyline    
  
  @@id_counter = 1;
    
 def initialize(parent_id, pos, storyline)
   @id = @@id_counter+=1
   @position = pos
   @parent_id = parent_id
   @storyline = storyline
 end
    
end    