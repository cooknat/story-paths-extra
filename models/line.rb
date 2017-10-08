class Line
  attr_accessor :id, :parent_id, :storyline    
  
  @@id_counter = 1;
    
 def initialize(parent_id, storyline)
   @id = @@id_counter+=1
   @parent_id = parent_id
   @storyline = storyline
 end
    
end    