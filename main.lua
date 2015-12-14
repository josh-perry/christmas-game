-- TODO: Spec

-- Classes
require("santa")
require("house")
require("present")
require("reindeer")
require("snow")
require("speed_boost")
require("beam")
require("ui")

-- Main loop functions
require("render")
require("update")
require("spawn")

-- etc.
require("BoundingBox")

zoom = 2
screen_height = love.window.getHeight()
screen_width = love.window.getWidth()

function love.load()
  -- Initialize lists
  presents = {}
  snow = {}
  houses = {}
  speed_boosts = {}

  ui = UI:new()

  -- Snow stuff
  snow_timeout = 1
  snow_timeout_cur = 0
  snow_dir_change_timeout = 0

  -- Boost stuff
  speed_boost_spawn_delay = 5 -- seconds
  speed_boost_spawn = speed_boost_spawn_delay

  -- Game time
  game_time = 0

  -- Initial houses
  spawn_houses()

  player_santa = Santa:new()

  love.window.setMode(400 * zoom, 300 * zoom)
end

function love.update(dt)
  game_time = game_time + dt

  -- Entity updates
  player_santa:update(dt)
  update_presents(dt)
  update_snow(dt)
  update_houses(dt)
  update_speed_boosts(dt)

  -- Check collisions
  house_collisions()
  boost_collisions()

  ui:update()
end

function love.draw()
  love.graphics.push()
  love.graphics.scale(zoom)

  -- Background
  draw_sky()

  -- Entities
  draw_presents()
  draw_santas()

  -- Draw Foreground
  draw_floor()
  draw_houses()
  draw_snow()

  draw_speed_boosts()

  ui:draw()

  love.graphics.pop()

  --draw_debug()
end
