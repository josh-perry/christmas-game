local class = require("libs/middleclass/middleclass")

UI = class("UI")

function UI:initialize()
    self.font = love.graphics.newFont(72)
    self:update_presents_ui()

    self.r = 0

    self.ui_canvas = love.graphics.newCanvas(screen_width, screen_height)
end

function UI:draw()
    -- Rotate around the center of the screen
    love.graphics.setColor(255, 255, 255, 10)
    love.graphics.translate(screen_width/2, screen_height/2)
    love.graphics.rotate(self.r)
    love.graphics.translate(-screen_width/2, -screen_height/2)

    love.graphics.setFont(self.font)
    love.graphics.printf(self.present_text.text, 0, 10, screen_width, "center")

    love.graphics.rotate(0)
    love.graphics.translate(0, 0)
end

function UI:update(dt)
end

function UI:update_presents_ui(delivered)
    if not delivered then delivered = 0 end

    self.present_text = {
        text = delivered
    }

    self.sx = math.random(2, 2)
    self.sy = math.random(2, 2)

    self.r = math.random(-.7, .7)
end
