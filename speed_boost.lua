local class = require("libs/middleclass/middleclass")

SpeedBoost = class("SpeedBoost")

function SpeedBoost:initialize(x, y)
  self.width = 32
  self.height = 32

  self.x = x
  self.y = y

  self.speed = 0
end

function SpeedBoost:draw()
  love.graphics.setColor(150, 255, 150)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function SpeedBoost:update(dt)
  self.x = self.x - (self.speed * dt)
end
