-- TODO: Spec

-- Classes
require("santa")
require("house")
require("present")
require("reindeer")
require("snow")
require("speed_boost")

-- Main loop functions
require("render")
require("update")
require("spawn")

-- etc.
require("BoundingBox")

screen_height = love.window.getHeight()
screen_width = love.window.getWidth()

function love.load()
  -- Initialize lists
  presents = {}
  snow = {}
  houses = {}
  speed_boosts = {}

  -- Snow stuff
  snow_timeout = 1
  snow_timeout_cur = 0
  snow_dir_change_timeout = 0

  -- Game time
  game_time = 0
  speed_boost_spawn = 5

  -- Initial houses
  spawn_houses()

  player_santa = Santa:new()
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

  draw_speed_boosts()
end
