local class = require("libs/middleclass/middleclass")

SpeedBoost = class("SpeedBoost")

function SpeedBoost:initialize(x, y)
  self.x = x
  self.y = y

  self.speed = 0

  self.sprite = love.graphics.newImage("data/graphics/cane.png")

  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()
end

function SpeedBoost:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.sprite, self.x, self.y)
end

function SpeedBoost:update(dt)
  self.x = self.x - (self.speed * dt)
end
