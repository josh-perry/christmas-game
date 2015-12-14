local class = require("libs/middleclass/middleclass")

Beam = class("Beam")

function Beam:initialize(charge_time)
    if charge_time >= 3 then
        charge_time = 10
    end

    self.charge = charge_time * 10
    self.alive_time = 0
    self.max_alive_time = charge_time / 2
end

function Beam:draw()
    local rc = table.getn(player_santa.reindeer)
    local reindeer = player_santa.reindeer[rc]
    local xx = reindeer.x + reindeer.width - 8
    local yy = reindeer.y + 14

    local x, y = player_santa.screen_space_x, player_santa.screen_space_y
    local x1, y1 = xx + self.charge, yy - self.charge
    local x2, y2 = xx + self.charge, yy + self.charge

    love.graphics.setColor(255, 100, 100, 255 * (self.alive_time / self.max_alive_time))
    love.graphics.polygon("fill", xx, yy, x1, y1, x2, y2)
    love.graphics.rectangle("fill", x1, y1, screen_width, self.charge * 2)
end

function Beam:update(dt)
    self.alive_time = self.alive_time + dt

    if self.alive_time >= self.max_alive_time then
        self.charge = 0
        self.delete = true
    end

    -- print(self.alive_time / self.max_alive_time)
    --
    -- self.charge = self.charge * (self.alive_time / self.max_alive_time)
end
