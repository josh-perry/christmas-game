local class = require("libs/middleclass/middleclass")

Present = class("Present")

local screen_height = love.window.getHeight()
local screen_width = love.window.getWidth()

function Present:initialize(x, y, house_id)
  self.width = 32
  self.height = 32

  self.x = x
  self.y = y

  self.start_y = y
  self.start_x = x

  self.speed = 600

  self.house_id = house_id

  self.target_house = houses[self.house_id]

  self.alive_time = 0
end

function Present:draw()
  love.graphics.setColor(150, 255, 150)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Present:update(dt, move_speed)
  self.alive_time = self.alive_time + dt

  local toX = self.x
  local toY = self.y - 32

  if self.alive_time > 0.2 then
    -- Move toward house
    self.speed = 800
    toX = self.target_house.x + (self.target_house.width / 2)
    toY = self.target_house.y + (self.target_house.height / 2)
  end

  local angle = math.atan2((toY - self.y), (toX - self.x))

  self.d_x = self.speed * math.cos(angle)
  self.d_y = self.speed * math.sin(angle)

  self.x = self.x + (self.d_x * dt)
  self.y = self.y + (self.d_y * dt)
end
