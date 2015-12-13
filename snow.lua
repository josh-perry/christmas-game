local class = require("libs/middleclass/middleclass")

Snow = class("Snow")

function Snow:initialize(x, y, house_id)
  self.width = 4
  self.height = 4

  self.x = x
  self.y = y

  self.start_y = y
  self.start_x = x

  self.speed = 600
  self.fall_speed = 100

  self.house_id = house_id

  self.target_house = houses[self.house_id]

  self.alive_time = 0
end

function Snow:draw()
  love.graphics.rectangle("fill", self.x - (self.width / 2), self.y - (self.width / 2), self.width, self.height)
end

function Snow:update(dt, move_speed)
  -- local angle = math.atan2((toY - self.y), (toX - self.x))
  --
  -- self.d_x = self.speed * math.cos(angle)
  -- self.d_y = self.speed * math.sin(angle)
  --
  -- self.x = self.x + (self.d_x * dt)
  -- self.y = self.y + (self.d_y * dt)

  self.y = self.y + (self.fall_speed * dt)
  self.x = self.x - (move_speed * dt)

  if self.x <= 0 - self.width then
      self.delete = true
  end
end
