--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  author:  jK
--
--  Copyright (C) 2007,2008.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


function gadget:GetInfo()
  return {
    name      = "LupsSyncedManager",
    desc      = "",
    author    = "jK",
    date      = "Apr, 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 10,
    enabled   = true,
  }
end

if (Engine.version=="0.76b1") then
	return false
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--  __           _  _  _
-- (_  \ / |\ | /  |_ | \
-- __)  |  | \| \_ |_ |_/
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

if (gadgetHandler:IsSyncedCode()) then

  local spGetUnitIsCloaked = Spring.GetUnitIsCloaked
  function gadget:UnitDamaged(unitID,unitDefID,teamID)
    if (spGetUnitIsCloaked(unitID)) then
      SendToUnsynced("lups_unit_cloakeddamaged", unitID, unitDefID, teamID)
    end
  end

  function gadget:UnitCreated(unitID,unitDefID)
    SendToUnsynced("lups_unit_created", unitID, unitDefID)
  end
  function gadget:UnitDestroyed(unitID,unitDefID)
    SendToUnsynced("lups_unit_destroyed", unitID, unitDefID)
  end


  function gadget:UnitCloaked(unitID,unitDefID,teamID)
    SendToUnsynced("lups_unit_cloaked", unitID,unitDefID,teamID)
  end
  function gadget:UnitDecloaked(unitID,unitDefID,teamID)
    SendToUnsynced("lups_unit_decloaked", unitID,unitDefID,teamID)
  end

  function gadget:RecvLuaMsg(msg, playerID)
    if (msg=="lups running") then
      SendToUnsynced("lups_luaui", playerID, true)
    elseif (msg=="lups shutdown") then
      SendToUnsynced("lups_luaui", playerID, false)
    end
  end

else

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--           __           _  _  _
-- | | |\ | (_  \ / |\ | /  |_ | \
-- |_| | \| __)  |  | \| \_ |_ |_/
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- speed ups + some table functions
--

local tinsert = table.insert
local type  = type
local pairs = pairs

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local Lups  --// Lua Particle System
local particleIDs = {}
local initialized = false --// if LUPS isn't started yet, we try it once a gameframe later
local tryloading  = 1     --// try to activate lups if it isn't found

local lups_luaui = false --// lups running as widget?
local nilDispList

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  �� some basic functions ��
--

local supportedFxs = {}
local function fxSupported(fxclass)
  if (supportedFxs[fxclass]~=nil) then
    return supportedFxs[fxclass]
  else
    supportedFxs[fxclass] = Lups.HasParticleClass(fxclass)
    return supportedFxs[fxclass]
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  �� cloaked unit handling ��
--

local CloakedHitEffect = { class='UnitJitter',options={ life=50, pos={0,0,0}, enemyHit=true, repeatEffect=false} }
local CloakEffect      = {
  { class='UnitCloaker',options={ life=60 } },
  { class='UnitJitter',options={ delay=30, life=math.huge } },
}
local DecloakEffect    = {
  { class='UnitCloaker',options={ inverse=true, life=60 } },
  { class='UnitJitter',options={ life=30 } },
}


local function UnitDamaged(_,unitID,unitDefID,teamID)
  local allyTeamID = Spring.GetUnitAllyTeam(unitID)

  local LocalAllyTeamID
  local _, specFullView = Spring.GetSpectatingState()
  if (specFullView) then
    LocalAllyTeamID = allyTeamID
  else
    LocalAllyTeamID = Spring.GetLocalAllyTeamID()
  end

  if (Spring.GetUnitIsCloaked(unitID))and(allyTeamID~=LocalAllyTeamID) then

    if (particleIDs[unitID]) then
      for _,fxID in ipairs(particleIDs[unitID]) do
        Lups.RemoveParticles(fxID)
      end
    end

    particleIDs[unitID] = {}
    CloakedHitEffect.options.unit = unitID
    CloakedHitEffect.options.team = teamID
    CloakedHitEffect.options.unitDefID = unitDefID
    tinsert( particleIDs[unitID],Lups.AddParticles(CloakedHitEffect.class,CloakedHitEffect.options) )
  end
end


local function UnitCloaked(_,unitID,unitDefID,teamID)
  if (not Lups) then
    return
  end

  local allyTeamID = Spring.GetUnitAllyTeam(unitID)

  local LocalAllyTeamID
  local _, specFullView = Spring.GetSpectatingState()
  if (specFullView) then
    LocalAllyTeamID = allyTeamID
  else
    LocalAllyTeamID = Spring.GetLocalAllyTeamID()
  end

  if (particleIDs[unitID]) then
    for _,fxID in ipairs(particleIDs[unitID]) do
      Lups.RemoveParticles(fxID)
    end
  end
  particleIDs[unitID] = {}
  for i=1,#CloakEffect do
    local fx = CloakEffect[i]
    if (fx.class~="UnitJitter")or(allyTeamID==LocalAllyTeamID) then
      if (fx.class=="UnitCloaker") then
        fx.options.unit      = unitID
        fx.options.unitDefID = unitDefID
        fx.options.team      = teamID
      else
        fx.options.unit      = unitID
        fx.options.unitDefID = unitDefID
        fx.options.pos       = {Spring.GetUnitBasePosition(unitID)}
        fx.options.team      = teamID
      end
      tinsert( particleIDs[unitID],Lups.AddParticles(fx.class,fx.options) )
    end
  end

end


local function UnitDecloaked(_,unitID,unitDefID,teamID)
  if (not Lups) then
    return
  end

  local allyTeamID = Spring.GetUnitAllyTeam(unitID)

  local LocalAllyTeamID
  local _, specFullView = Spring.GetSpectatingState()
  if (specFullView) then
    LocalAllyTeamID = allyTeamID
  else
    LocalAllyTeamID = Spring.GetLocalAllyTeamID()
  end

  if (particleIDs[unitID]) then
    for _,fxID in ipairs(particleIDs[unitID]) do
      Lups.RemoveParticles(fxID)
    end
  end
  particleIDs[unitID] = {}
  for i=1,#DecloakEffect do
    local fx = DecloakEffect[i]
    if (fx.class~="UnitJitter")or(allyTeamID==LocalAllyTeamID) then
      if (fx.class=="UnitCloaker") then
        fx.options.unit      = unitID
        fx.options.unitDefID = unitDefID
        fx.options.team      = teamID
      else
        fx.options.unit      = unitID
        fx.options.unitDefID = unitDefID
        fx.options.pos       = {Spring.GetUnitBasePosition(unitID)}
        fx.options.team      = teamID
      end
      tinsert( particleIDs[unitID],Lups.AddParticles(fx.class,fx.options) )
    end
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  �� Unit Destroyed handling ��
--

local function UnitDestroyed(_,unitID,unitDefID)
  if (particleIDs[unitID]) then
    local effects = particleIDs[unitID]
    for i=1,#effects do
      Lups.RemoveParticles(effects[i])
    end
    particleIDs[unitID] = nil
  end
end


local function UnitCreated(_,unitID,unitDefID)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function LupsLuaUI(_,playerID,enabled)
  if (playerID==Spring.GetLocalPlayerID()) then
    lups_luaui = enabled
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:Update()
  if (Spring.GetGameFrame()<1) then
    return
  end

  gadgetHandler:RemoveCallIn("Update")

  Lups  = GG['Lups']

  if (Lups) then
    initialized=true
  else
    return
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:Initialize()
  gadgetHandler:AddSyncAction("lups_unit_cloakeddamaged", UnitDamaged)
  gadgetHandler:AddSyncAction("lups_unit_cloaked",        UnitCloaked)
  gadgetHandler:AddSyncAction("lups_unit_decloaked",      UnitDecloaked)
  gadgetHandler:AddSyncAction("lups_unit_destroyed",      UnitDestroyed)

  gadgetHandler:AddSyncAction("lups_luaui",               LupsLuaUI)
  gadgetHandler:AddSyncAction("lups_unit_created",        UnitCreated)

  nilDispList = gl.CreateList(function() end)
end

function gadget:Shutdown()
  gadgetHandler:RemoveSyncAction("lups_unit_cloakeddamaged")
  gadgetHandler:RemoveSyncAction("lups_unit_cloaked")
  gadgetHandler:RemoveSyncAction("lups_unit_decloaked")
  gadgetHandler:RemoveSyncAction("lups_unit_destroyed")

  gadgetHandler:RemoveSyncAction("lups_luaui")
  gadgetHandler:RemoveSyncAction("lups_unit_created")

  if (initialized) then
    for _,unitFxIDs in pairs(particleIDs) do
      for _,fxID in ipairs(unitFxIDs) do
        Lups.RemoveParticles(fxID)
      end
    end
    particleIDs = {}
  end

  gl.DeleteList(nilDispList)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
end