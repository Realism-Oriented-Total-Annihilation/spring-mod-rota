--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "Engine Taskbar Stuff",
    desc      = 'Icon, name',
    author    = "KingRaptor",
    date      = "13 July 2011",
    license   = "Public Domain",
    layer     = -math.huge,
    enabled   = true,
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then
  return false  --  silent removal
end

local function noFunc() end

local SetWMIcon = Spring.SetWMIcon or noFunc
local SetWMCaption = Spring.SetWMCaption or noFunc

function gadget:Initialize()
	local name = Game.modName
	SetWMIcon("bitmaps/notaicon.png")
	SetWMCaption(name .. " (Spring " .. Engine.version .. ")", name)
	gadgetHandler:RemoveGadget()
end