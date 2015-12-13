-- TODO: Spec

-- Classes
require("santa")
require("house")
require("present")
require("reindeer")
require("snow")

-- etc.
require("BoundingBox")

local screen_height = love.window.getHeight()
local screen_width = love.window.getWidth()

function love.load()
  presents = {}

  spawn_houses()

  player_santa = Santa:new()

  snow = {}

  snow_timeout = 1
  snow_timeout_cur = 0
end

function love.update(dt)
    snow_timeout_cur = snow_timeout_cur + dt

    if snow_timeout_cur >= snow_timeout then
        spawn_snow()
    end

  player_santa:update(dt)

  for i, present in ipairs(presents) do
    present:update(dt)
  end

  for i, s in ipairs(snow) do
      s:update(dt, player_santa.world_speed)

      if s.delete then
          table.remove(snow, i)
      end
  end

  for i, house in ipairs(houses) do
    house:update(dt, player_santa.world_speed)

    if house.delete then
      table.remove(houses, i)
    end
  end

  if table.getn(houses) <= 0 then
    spawn_houses()
  end

  movement = {"up", "down", "left", "right"}
  for i, key in ipairs(movement) do
    if love.keyboard.isDown(key) then
      print(dt)
      player_santa:move(key, dt)
    end
  end

  -- Check house collisions
  house_collisions()
end

function spawn_snow()
    local s = Snow:new()
    s.x = math.random(0, screen_width * 4)
    s.y = 0 + s.height

    table.insert(snow, s)
end

function love.draw()
  -- Background
  draw_sky()

  -- Entities
  draw_presents()
  draw_santas()

  -- Draw Foreground
  draw_floor()
  draw_houses()
  draw_snow()
end

function spawn_houses()
  houses = {}
  local house_spacing = 10
  for i = 1, 30 do
    h = House:new()
    h.house_spacing = 10
    h.y = screen_height - h.height
    h.x = i * h.width + (i * h.house_spacing) + screen_width

    table.insert(houses, h)
  end
end

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

function house_collisions()
  for i, house in ipairs(houses) do
    if not house.delivered then
      local x, y, w, h = player_santa.screen_space_x, player_santa.screen_space_y, player_santa.width, player_santa.height
      local x1, y1, w1, h1 = house.x, 0, house.width, screen_height

      if CheckCollision(x, y, w, h, x1, y1, w1, h1) then
        house.delivered = true

        player_santa.elf.throwing = true
        table.insert(presents, Present:new(player_santa.screen_space_x + (player_santa.width / 2), player_santa.screen_space_y, i))
      end
    end
  end
end
