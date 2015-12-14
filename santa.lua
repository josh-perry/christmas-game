local class = require("libs/middleclass/middleclass")

Santa = class("Santa")

function Santa:initialize()
  self.world_space_x = 32

  self.screen_space_x = 32
  self.screen_space_y = 32

  self.base_world_speed = 256
  self.world_speed = self.base_world_speed -- Pixels/sec
  self.world_deceleration = 32

  self.screen_speed = 600

  self.sprite = love.graphics.newImage("data/graphics/santa.png")
  self.elf = {
      sprite = love.graphics.newImage("data/graphics/elf.png"),
      throwing = true,
      throw_timeout = 0.1,
      throw_timeout_cur = 0
  }

  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()

  self.reindeer = {}

  for i = 1, 4 do
    table.insert(self.reindeer, Reindeer:new())
  end
end

function Santa:draw()
  love.graphics.setColor(255, 255, 255)

  local sx = 1
  local ox = 0
  if self.elf.throwing then
     sx = -1
     ox = self.elf.sprite:getWidth() + 5
  end

  love.graphics.draw(self.elf.sprite, self.screen_space_x + 9, self.screen_space_y + 4, 0, sx, 1, ox)

  love.graphics.draw(self.sprite, self.screen_space_x, self.screen_space_y)

  local leash_x = self.screen_space_x + self.width
  local leash_y = self.screen_space_y + (self.height / 2) - 5

  for i, reindeer in ipairs(self.reindeer) do
    reindeer:draw()

    local to_x = reindeer.x + 19 + math.random(-1, 1)
    local to_y = reindeer.y + 14 + math.random(-1, 1)

    love.graphics.setColor(77, 77, 77)
    love.graphics.line(leash_x, leash_y, to_x, to_y)

    leash_x = to_x
    leash_y = to_y
  end
end

function Santa:update(dt)
  if self.world_speed >= self.base_world_speed then
    self.world_speed = self.world_speed - (self.world_deceleration * dt)

    if self.world_speed <= self.base_world_speed then
      self.world_speed = self.base_world_speed
    end
  end

  self.world_space_x = self.world_space_x + (self.world_speed * dt)

  if self.elf.throwing then
      self.elf.throw_timeout_cur = self.elf.throw_timeout_cur + dt

      if self.elf.throw_timeout_cur >= self.elf.throw_timeout then
          self.elf.throwing = false
          self.elf.throw_timeout_cur = 0
      end
  else
      self.elf.throw_timeout_cur = 0
  end

  movement = {"up", "down", "left", "right"}
  for i, key in ipairs(movement) do
    if love.keyboard.isDown(key) then
      self:move(key, dt)
    end
  end

  for i, reindeer in ipairs(self.reindeer) do
    reindeer.y = self.screen_space_y + 8
    reindeer.x = self.screen_space_x + self.width + (24 * i) - 16

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

function Santa:boost_speed()
  self.world_speed = self.world_speed + 256
end
