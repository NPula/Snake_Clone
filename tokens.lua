

Tokens = class{}


function Tokens:init(x, y, size, isPickedUp)
   self.x = x
   self.y = y
   self.size = size
end


function Tokens:draw(r, g, b)
   love.graphics.setColor(r, b, g)
   love.graphics.rectangle("fill", self.x, self.y, self.size, self.size )
end

function Tokens:collision(snake)

   if self.x > snake.snakeContainer[1].x + snake.size or snake.snakeContainer[1].x > self.x + self.size then
      return false
   end

   if self.y > snake.snakeContainer[1].y + snake.size or snake.snakeContainer[1].y > self.y + self.size then
        return false
    end 

   return true
   
end
