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
    love.graphics.newQuad(0, 0, 64, 64, w, h),
    love.graphics.newQuad(64, 0, 64, 64, w, h)
  }

  self.cur_frame = 1

  self.tar_frametime = 1
  self.cur_frametime = 0
end

function Reindeer:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.sprite, self.animations[self.cur_frame], self.x, self.y)
end

function Reindeer:update(dt)
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
