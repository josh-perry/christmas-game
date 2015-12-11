local class = require("libs/middleclass/middleclass")

Santa = class("Santa")

function Santa:initialize()
  self.world_space_x = 32

  self.screen_space_x = 32
  self.screen_space_y = 32

  self.world_speed = 256 -- Pixels/sec
  self.screen_speed = 600

  self.sprite = love.graphics.newImage("data/graphics/santa.png")

  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()

  self.reindeer = {}

  for i = 1, 4 do
    table.insert(self.reindeer, Reindeer:new())
  end
end

function Santa:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.sprite, self.screen_space_x, self.screen_space_y)

  local leash_x = self.screen_space_x + self.width
  local leash_y = self.screen_space_y + (self.height / 2) - 5

  for i, reindeer in ipairs(self.reindeer) do
    reindeer:draw()

    local to_x = reindeer.x + 37 + math.random(-1, 1)
    local to_y = reindeer.y + 27 + math.random(-1, 1)

    love.graphics.setColor(77, 77, 77)
    love.graphics.line(leash_x, leash_y, to_x, to_y)

    leash_x = to_x
    leash_y = to_y
  end
end

function Santa:update(dt)
  self.world_space_x = self.world_space_x + (self.world_speed * dt)

  for i, reindeer in ipairs(self.reindeer) do
    reindeer.y = self.screen_space_y + 16
    reindeer.x = self.screen_space_x + self.width + (48 * i) - 32

    reindeer:update(dt)
  end
end

function Santa:move(direction, dt)
  if direction == "up" then
    self.screen_space_y = self.screen_space_y - (self.screen_speed * dt)
  end

  if direction == "down" then
    self.screen_space_y = self.screen_space_y + (self.screen_speed * dt)
  end

  if direction == "left" then
    self.screen_space_x = self.screen_space_x - (self.screen_speed * dt)
  end

  if direction == "right" then
    self.screen_space_x = self.screen_space_x + (self.screen_speed * dt)
  end
end
