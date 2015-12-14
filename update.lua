local snow_left = true

function update_snow(dt)
  snow_timeout_cur = snow_timeout_cur + dt

  if game_time >= snow_dir_change_timeout then
    snow_dir_change_timeout = snow_dir_change_timeout + 3
  end

  if snow_timeout_cur >= snow_timeout then
      spawn_snow()
      snow_timeout_cur = 0

      snow_timeout = snow_timeout - (snow_timeout / 3)

      if snow_timeout_cur < 0.5 then
        snow_timeout_cur = 0.5
      end
  end

  local x_speed = player_santa.world_speed

  if snow_left then
    x_speed = x_speed - 20
  else
    x_speed = x_speed + 20
  end

  for i, s in ipairs(snow) do
      s:update(dt, x_speed)

      if s.delete then
          table.remove(snow, i)
      end
  end
end

function update_houses(dt)
  local ws = player_santa.world_speed

  for i, house in ipairs(houses) do
    house:update(dt, ws)

    if house.delete then
      table.remove(houses, i)
    end
  end

  if table.getn(houses) <= 0 then
    spawn_houses()
  end
end

function update_presents(dt)
  for i, present in ipairs(presents) do
    present:update(dt)

    if present.delete then
      table.remove(presents, i)
    end
  end
end

function update_speed_boosts(dt)
  --print(game_time)
  if game_time >= speed_boost_spawn then
    print("spawn speed boost")
    speed_boost_spawn = speed_boost_spawn + speed_boost_spawn_delay

    spawn_speed_boost()
  end

  for i, boost in ipairs(speed_boosts) do
    boost.speed = player_santa.world_speed
    boost:update(dt)
  end
end

function house_collisions()
  for i, house in ipairs(houses) do
    if not house.delivered then
      local x, y, w, h = player_santa.screen_space_x, player_santa.screen_space_y, player_santa.width, player_santa.height
      local x1, y1, w1, h1 = house.x, 0, house.width, screen_height

      if CheckCollision(x, y, w, h, x1, y1, w1, h1) then
        house.delivered = true

        player_santa.delivered_presents = player_santa.delivered_presents + 1
        ui:update_presents_ui(player_santa.delivered_presents)

        player_santa.elf.throwing = true
        table.insert(presents, Present:new(player_santa.screen_space_x + (player_santa.width / 2), player_santa.screen_space_y, i))
      end
    end
  end
end

function boost_collisions()
  for i, boost in ipairs(speed_boosts) do
    local x, y, w, h = player_santa.screen_space_x, player_santa.screen_space_y, player_santa.width, player_santa.height
    local x1, y1, w1, h1 = boost.x, boost.y, boost.width, boost.height

    if CheckCollision(x, y, w, h, x1, y1, w1, h1) then
      player_santa:boost_speed()

      table.remove(speed_boosts, i)
    end
  end
end
