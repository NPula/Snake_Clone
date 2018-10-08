
Snake = class{}

function Snake:init(_x, _y, size, delay)
   self.x = _x
   self.y = _y
   self.size = size
   self.delay = delay
   self.dt = self.delay
   self.snakeContainer = {
      {x = _x, y = _y}
   }
   self.snakeCoords = {}
   self.currentSnakeSize = 1
   self.state = "right"

end

function Snake:add(_x, _y)
   self.currentSnakeSize = self.currentSnakeSize + 1
   table.insert(self.snakeContainer, self.currentSnakeSize, {x = _x, y = _y})
end

function Snake:update(dt)
  
   self.dt = self.dt + dt
   
   if self.dt == self.delay or self.dt > self.delay then
      
      if self.state == "down" then         
         i = self.currentSnakeSize
         while i ~= 1 do
            self.snakeContainer[i].x = self.snakeContainer[i-1].x
            self.snakeContainer[i].y = self.snakeContainer[i-1].y
            i = i - 1
         end
         self.snakeContainer[1].y = self.snakeContainer[1].y + 10
         
      elseif self.state == "up" then
         
          i = self.currentSnakeSize
         while i ~= 1 do
            self.snakeContainer[i].x = self.snakeContainer[i-1].x
            self.snakeContainer[i].y = self.snakeContainer[i-1].y
            i = i - 1
         end
         self.snakeContainer[1].y = self.snakeContainer[1].y - 10
         
      elseif self.state == "right" then

          i = self.currentSnakeSize
         while i ~= 1 do
            self.snakeContainer[i].x = self.snakeContainer[i-1].x
            self.snakeContainer[i].y = self.snakeContainer[i-1].y
            i = i - 1
         end
         self.snakeContainer[1].x = self.snakeContainer[1].x + 10
         
      elseif self.state == "left" then

          i = self.currentSnakeSize
         while i ~= 1 do
            self.snakeContainer[i].x = self.snakeContainer[i-1].x
            self.snakeContainer[i].y = self.snakeContainer[i-1].y
            i = i - 1
         end
         self.snakeContainer[1].x = self.snakeContainer[1].x - 10
         
      end
      self.dt = 0
   end
end


function Snake:draw(r, g, b)
   
   love.graphics.setColor(r, g, b)
   love.graphics.rectangle("fill", self.snakeContainer[1].x, self.snakeContainer[1].y, self.size, self.size)
   --if self.currentSnakeSize > 1 then
   for i = 2, self.currentSnakeSize do
      love.graphics.rectangle("fill", self.snakeContainer[i].x, self.snakeContainer[i].y, self.size, self.size)
   end
end

function Snake:setState(state)

   if self.state == state then
      
   else
      self.state = state
      self.dt = self.delay
   end

end

function Snake:collision(snake, screenWidth, screenHeight)

   for i = 2, snake.currentSnakeSize do
      if snake.snakeContainer[1].x <= snake.snakeContainer[i].x + snake.size and 
         snake.snakeContainer[i].x <= snake.snakeContainer[1].x + snake.size and
         snake.snakeContainer[1].y <= snake.snakeContainer[i].y + snake.size and
         snake.snakeContainer[i].y <= snake.snakeContainer[1].y + snake.size then
         return true
      end
   end

   if snake.snakeContainer[1].x < 0 or snake.snakeContainer[1].x > screenWidth or
      snake.snakeContainer[1].y < 0 or snake.snakeContainer[1].y > screenHeight-self.size then
      return true
   end
   
   return false

end
