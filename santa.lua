local class = require("libs/middleclass/middleclass")

Santa = class("Santa")

function Santa:initialize()
  self.world_space_x = 32

  self.screen_space_x = 32
  self.screen_space_y = 32

  self.base_world_speed = 256
  self.world_speed = self.base_world_speed -- Pixels/sec
  self.world_deceleration = 32

  self.beam_charge = 0

  self.screen_speed = 300

  self.delivered_presents = 0
  
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

  self.reindeer_count = 4
  for i = 1, self.reindeer_count do
      local r = Reindeer:new()

      if i == self.reindeer_count then
          r.sprite = love.graphics.newImage("data/graphics/rudolf.png")
      end

    table.insert(self.reindeer, r)
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
  local leash_y = self.screen_space_y + 19

  for i, reindeer in ipairs(self.reindeer) do
    reindeer:draw()

    local to_x = reindeer.x + 19 + math.random(-1, 1)
    local to_y = reindeer.y + 14 + math.random(-1, 1)

    love.graphics.setColor(77, 77, 77)
    love.graphics.line(leash_x, leash_y, to_x, to_y)

    leash_x = to_x
    leash_y = to_y
  end

  if self.beam then
      self.beam:draw()
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

  -- Holding button
  if love.keyboard.isDown("z") and not self.beam then
      self:rudolf_beam_charge(dt)
  end

  -- Released button
  if not love.keyboard.isDown("z") then
      self:rudolf_beam_fire(dt)
  end

  for i, reindeer in ipairs(self.reindeer) do
    reindeer.y = self.screen_space_y + 8
    reindeer.x = self.screen_space_x + self.width + (24 * i) - 16

    if i == self.reindeer_count then
        local override = false

        if self.beam then
            override = true
        end

        reindeer:update(dt, self.beam_charge, override)
    else
        reindeer:update(dt)
    end
  end

  if self.beam then
      self.beam:update(dt)

      if self.beam.delete then
          self.beam = nil
      end
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

function Santa:rudolf_beam_charge(dt)
    self.beam_charge = self.beam_charge + dt
end

function Santa:rudolf_beam_fire()
    if self.beam_charge <= 0 then
        return
    end

    self.beam = Beam:new(self.beam_charge)
    self.beam_charge = 0
end
