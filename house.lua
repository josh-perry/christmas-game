local class = require("libs/middleclass/middleclass")

House = class("House")

function House:initialize()
  self.x = 0
  self.y = 0

  self.house_spacing = 0

  self.delivered = false

  self.sprite = love.graphics.newImage("data/graphics/house1.png")

  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()
end

function House:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.sprite, self.x, self.y)
end

function House:update(dt, move_speed)
  self.x = self.x - (move_speed * dt)

  if self.x < 0 - (self.width * 2) then
    self.delete = true
  end
end
