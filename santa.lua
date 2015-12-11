local class = require("libs/middleclass/middleclass")

Santa = class("Santa")

function Santa:initialize()
  self.world_space_x = 32

  self.screen_space_x = 32
  self.screen_space_y = 32

  self.width = 128
  self.height = 84

  self.world_speed = 256 -- Pixels/sec
  self.screen_speed = 600

  self.sprite = love.graphics.newImage("data/graphics/santa.png")
end

function Santa:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.sprite, self.screen_space_x, self.screen_space_y)
  --love.graphics.setColor(255, 100, 100)
  --love.graphics.rectangle("fill", self.screen_space_x, self.screen_space_y, self.width, self.height)
end

function Santa:update(dt)
  self.world_space_x = self.world_space_x + (self.world_speed * dt)
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
