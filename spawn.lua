function spawn_snow()
    local s = Snow:new()
    s.x = math.random(screen_width * 2, screen_width + (player_santa.base_world_speed / player_santa.world_speed) * 2)
    s.y = math.random(-screen_height, screen_height / 2)

    table.insert(snow, s)
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

function spawn_speed_boost()
  b = SpeedBoost:new()
  b.x = screen_width + b.width + b.width
  b.y = math.random(20, screen_height - b.height - 64 - 32)
  table.insert(speed_boosts, b)
end
