local class = require("libs/middleclass/middleclass")

Snow = class("Snow")

function Snow:initialize(x, y, house_id)
  self.width = 1
  self.height = 1

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
  local line_length = (player_santa.world_speed / player_santa.base_world_speed) * 2

  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("fill", self.x - (self.width / 2), self.y - (self.width / 2), self.width, self.height)

  love.graphics.setColor(255, 255, 255, 100)
  love.graphics.line(self.x, self.y, self.x + line_length, self.y - (line_length / 2))
end

function Snow:update(dt, move_speed)
  self.y = self.y + (self.fall_speed * dt)
  self.x = self.x - (move_speed * dt)

  if self.x <= 0 - self.width then
      self.delete = true
  end
end
