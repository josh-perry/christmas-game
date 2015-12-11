local class = require("libs/middleclass/middleclass")

House = class("House")

local screen_height = love.window.getHeight()
local screen_width = love.window.getWidth()

function House:initialize()
  self.width = 128
  self.height = 128

  self.x = 0
  self.y = 0

  self.house_spacing = 0

  self.delivered = false
end

function House:draw()
  love.graphics.setColor(125, 100, 75)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function House:update(dt, move_speed)
  self.x = self.x - (move_speed * dt)

  if self.x < 0 - (self.width) then
    self.delete = true
  end
end
