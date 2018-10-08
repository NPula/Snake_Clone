

push = require "push"
class = require "class"

require "grid"
require "snake"
require "tokens"

SCREEN_WIDTH    = 800
SCREEN_HEIGHT   = 600

VIRTUAL_WIDTH   = 400 
VIRTUAL_HEIGHT  = 300

SNAKE_SIZE      = 8
SNAKE_POS_X     = (VIRTUAL_WIDTH  / 2) + 1
SNAKE_POS_Y     = (VIRTUAL_HEIGHT / 2) + 1
SNAKE_SPEED     = 10

GRID_BLOCK_SIZE = 10
GRID_SPACING    = 0
GRID = {}

TIMER = .2

GAME_STATE = "Play"
SCORE      = 0

function love.load()

   math.randomseed(os.time())
   love.graphics.setDefaultFilter('nearest', 'nearest')

   smallFont = love.graphics.newFont('font.ttf', 8)
   largeFont = love.graphics.newFont('font.ttf', 32)

   love.graphics.setFont(largeFont)
   
   push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT,{
                    fullscreen = false,
                    resizable  = true,
                    vsync      = true
   })

   Grid  = Grid(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, GRID_BLOCK_SIZE, GRID_BLOCK_SIZE, GRID_SPACING, GRID_SPACING)
   
   Snake = Snake(SNAKE_POS_X , SNAKE_POS_Y, SNAKE_SIZE, TIMER)
   Snake:add(SNAKE_POS_X-10, SNAKE_POS_Y)
   Snake:add(SNAKE_POS_X-20, SNAKE_POS_Y)
   Token = Tokens((math.random(1,VIRTUAL_WIDTH / GRID_BLOCK_SIZE) * 10) + 1,
      ((math.random(1, VIRTUAL_HEIGHT / GRID_BLOCK_SIZE) * 10) - SNAKE_SIZE) - 1, SNAKE_SIZE, false)
end

function love.resize(w, h)

   push:resize(w, h)
   
end

function love.update(dt)
   
   if GAME_STATE == "Play" then

      Snake:update(dt)
      SCORE = (SCORE + 1)
      if Token:collision(Snake) == true then
         Token.x = (math.random(1, VIRTUAL_WIDTH / GRID_BLOCK_SIZE) * 10) + 1
         Token.y = ((math.random(1, VIRTUAL_HEIGHT / GRID_BLOCK_SIZE) * 10) - SNAKE_SIZE) - 1

         -- Make sure token always spawns in the map
         if Token.x >= VIRTUAL_WIDTH or Token.x < 0 then
            Token.x = (math.random(1, VIRTUAL_WIDTH / GRID_BLOCK_SIZE) * 10) + 1
         elseif Token.y >= VIRTUAL_HEIGHT or Token.y < 0 then
            Token.y = ((math.random(1, VIRTUAL_HEIGHT / GRID_BLOCK_SIZE) * 10) - SNAKE_SIZE) - 1
         end
         
         Snake:add(Snake.snakeContainer[Snake.currentSnakeSize].x, Snake.snakeContainer[Snake.currentSnakeSize].y)
         Snake:add(Snake.snakeContainer[Snake.currentSnakeSize].x, Snake.snakeContainer[Snake.currentSnakeSize].y)
         Snake:add(Snake.snakeContainer[Snake.currentSnakeSize].x, Snake.snakeContainer[Snake.currentSnakeSize].y)
         Snake:add(Snake.snakeContainer[Snake.currentSnakeSize].x, Snake.snakeContainer[Snake.currentSnakeSize].y)
         Snake.delay = Snake.delay * .99
         SCORE = (SCORE + 100)
      end
      
      if Snake:collision(Snake, VIRTUAL_WIDTH, VIRTUAL_HEIGHT) == true then
         GAME_STATE = "GameOver"
      end
   end
end

function love.draw()

   push:start()
   
   if GAME_STATE == "GameOver" then
      GameOver()
   end

   if GAME_STATE == "Play" then   
      Grid:draw(.1, .1, .1)
      Snake:draw(1, 1, 1)
      Token:draw(1, 0, 0)
      love.graphics.setFont(smallFont)
      love.graphics.print("Score: " ..tostring(SCORE), 0, 1 )
      love.graphics.setFont(smallFont)
   end

   push:finish()
   
end

function love.keypressed(key, scancode, isrepeat)

   if key == "w" and Snake.state ~= "down" then
      Snake:setState("up")
   elseif key == "s" and Snake.state ~= "up" then
      Snake:setState("down")
   elseif key == "d" and Snake.state ~= "left" then
      Snake:setState("right")
   elseif key == "a" and Snake.state ~= "right" then
      Snake:setState("left")
   end

   if key == "escape" then
      love.event.quit()
   end
end

function GameOver()
   
   love.graphics.setFont(largeFont)
   love.graphics.print("Game Over", (VIRTUAL_WIDTH / 2) - 80 , VIRTUAL_HEIGHT / 3)

   love.graphics.setFont(smallFont)
   love.graphics.print("Score: " ..tostring(SCORE), (VIRTUAL_WIDTH / 2) - 80 , VIRTUAL_HEIGHT / 2)
   
end
