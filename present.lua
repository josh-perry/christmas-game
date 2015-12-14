local class = require("libs/middleclass/middleclass")

Present = class("Present")

function Present:initialize(x, y, house_id)
  self.x = x
  self.y = y

  self.start_y = y
  self.start_x = x

  self.speed = 600

  self.house_id = house_id

  self.target_house = houses[self.house_id]

  self.alive_time = 0

  self.sprite = love.graphics.newImage("data/graphics/present.png")
  self.color = {math.random(100, 255), math.random(100, 255), math.random(100, 255)}

  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()

  self.throw_target_x = math.random(-16, 16)
  self.throw_target_y = math.random(-16, -64)
end

function Present:draw()
  love.graphics.setColor(self.color)
  love.graphics.draw(self.sprite, self.x, self.y)
end

function Present:update(dt, move_speed)
  self.alive_time = self.alive_time + dt

  local toX = self.x + self.throw_target_x
  local toY = self.y + self.throw_target_y

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

  if self.x <= 0 - self.width then
    self.delete = true
  end
end
