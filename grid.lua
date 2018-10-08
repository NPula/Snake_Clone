
Grid = class{}

function Grid:init(width, height, sizeX, sizeY, spaceX, spaceY)

   self.width  = width
   self.height = height
   self.sizeX  = sizeX
   self.sizeY  = sizeY
   self.spaceX = spaceX
   self.spaceY = spaceY

end


function Grid:draw(r, g, b)

     -- Display Grid --------------
   love.graphics.setColor(r, g, b)
   for i = 1, (self.width / self.sizeX) do
      for j = 1, (self.height / self.sizeY) do
         love.graphics.rectangle("line", ((i - 1) * self.sizeX) + self.spaceX, ((j - 1) * self.sizeY) + self.spaceY, self.sizeX, self.sizeY)
      end
   end
   
end
