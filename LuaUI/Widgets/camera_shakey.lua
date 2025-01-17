--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    camera_shakey.lua
--  brief:   Camera shakes lots
--  author:  Dave Rodgers
--
--  Copyright (C) 2007.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "CameraShakey",
    desc      = "Camera shakes a lot",
    author    = "trepan",
    date      = "Jun 15, 2007",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local exps = 0
local shake = 0

local powerScale = 200

local decayFactor = 5

local minArea  = 32  -- weapon's area of effect
local minPower = (0.02 / powerScale)
local distAdj  = 100


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


function widget:Initialize()
  -- required for ShockFront() call-ins
  -- (threshold uses the 1/d^2 power)
  Spring.SetShockFrontFactors(minArea, minPower, distAdj)
end


function widget:Shutdown()
  Spring.SetCameraOffset()
end


function widget:ShockFront(power, dx, dy, dz)
  exps = exps + 1
  power = power * powerScale
  if (power > 8) then
    power = 8
  end
  shake = shake + power
end


local function birand(val)
  return val * (1.0 - (0.002 * math.random(1000)))
end


function widget:Update(dt)
  local t = widgetHandler:GetHourTimer()
  local masterShake = shake
  if (masterShake > 2) then
	masterShake = 2
  end
  local pShake = masterShake * 0.1
  local tShake = masterShake * 0.025
  local px, py, pz, tx, ty, tz =
    birand(pShake),
    birand(pShake),
    birand(pShake),
    birand(tShake),
    birand(tShake)
  Spring.SetCameraOffset(px, py, pz, tx, ty)

  local decay = (1 - (decayFactor * dt))
  if (decay < 0) then
    decay = 0
  end
  shake = shake * decay
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
