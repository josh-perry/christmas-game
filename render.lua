function draw_santas()
  player_santa:draw()
end

function draw_houses()
  for i, house in ipairs(houses) do
    house:draw()
  end
end

function draw_snow()
    love.graphics.setColor(255, 255, 255)

    for i, s in ipairs(snow) do
        s:draw()
    end
end

function draw_sky()
  love.graphics.setColor(8, 8, 32)
  love.graphics.rectangle("fill", 0, 0, screen_width, screen_height - 64)

  love.graphics.setColor(200, 200, 200, 200)
  love.graphics.circle("fill", 100, 100, 50)
end

function draw_floor()
  love.graphics.setColor(20, 40, 20)
  love.graphics.rectangle("fill", 0, screen_height - 64, screen_width, 64)
end

function draw_presents()
  for i, present in ipairs(presents) do
    present:draw()
  end
end

function draw_speed_boosts()
  for i, boost in ipairs(speed_boosts) do
    print("ok")
    boost:draw()
  end
end

function draw_debug()
  love.graphics.print("Speed:"..player_santa.world_speed, 10, 10)
  love.graphics.print("Snow: "..table.getn(snow), 10, 20)
  love.graphics.print("Houses:"..table.getn(houses), 10, 30)
  love.graphics.print("Speed boosts:"..table.getn(speed_boosts), 10, 40)
  love.graphics.print("Presents:"..table.getn(presents), 10, 50)
end
