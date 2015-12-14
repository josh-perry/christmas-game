local class = require("libs/middleclass/middleclass")

Reindeer = class("Reindeer")

function Reindeer:initialize(x, y)
  self.width = 32
  self.height = 32

  self.x = x
  self.y = y

  self.sprite = love.graphics.newImage("data/graphics/reindeer.png")

  local w = self.sprite:getWidth()
  local h = self.sprite:getHeight()

  self.animations = {
    love.graphics.newQuad(0, 0, 32, 32, w, h),
    love.graphics.newQuad(32, 0, 32, 32, w, h)
  }

  self.cur_frame = 1

  self.tar_frametime = 1
  self.cur_frametime = 0

  self.particle_system = love.graphics.newParticleSystem(love.graphics.newImage("data/graphics/charge_particle.png"), 2000)

  local p = self.particle_system
  p:setLinearAcceleration(-200, -200, 200, 200)
  p:setColors(255, 100, 100, 255, 255, 50, 50, 255, 255, 0, 0, 255)
  p:setSizeVariation(1)
  p:setParticleLifetime(0.05, 0.5)
  p:setRelativeRotation(false)


  self.last_beam_time = 0
end

function Reindeer:draw(charge_time)
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.sprite, self.animations[self.cur_frame], self.x, self.y)

  love.graphics.draw(self.particle_system, self.x + self.width - 6, self.y + 14)
end

function Reindeer:update(dt, charge_time, beam_override)
    --self.particle_system:setOffset(self.x, self.y)
    self.particle_system:update(dt)

    if beam_override or charge_time and charge_time > 0 then
        if charge_time then
            self.last_beam_time = charge_time
        end

        if not self.last_beam_time then
            self.last_beam_time = 0
        end

        if charge_time >= 3 or self.last_beam_time >= 3 then
            self.particle_system:setColors(255, 255, 255)
        else
            self.particle_system:setColors(255, 100, 100, 255, 255, 50, 50, 255, 255, 0, 0, 255)
        end

        self.particle_system:setSizeVariation(0.05, 0.5 * charge_time)

        local e = math.ceil(charge_time or self.last_beam_time) * 50
        print(e)
        self.particle_system:setEmissionRate(e)
    end

  self.tar_frametime = (player_santa.base_world_speed / player_santa.world_speed)

  self.cur_frametime = self.cur_frametime + dt

  if self.cur_frametime >= self.tar_frametime then
    self.cur_frametime = 0
    self.cur_frame = self.cur_frame + 1

    if self.cur_frame > table.getn(self.animations) then
      self.cur_frame = 1
    end
  end
end
