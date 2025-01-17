
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "Production Rate",
    desc      = "Adds a button that sets the production rate" ..
                "for a factory",
    author    = "CAKE",
    date      = "Oct 20, 2007",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

if (not gadgetHandler:IsSyncedCode()) then
  return false  --  silent removal
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--Speed-ups

local GetUnitDefID    = Spring.GetUnitDefID
local GetUnitCommands = Spring.GetUnitCommands
local FindUnitCmdDesc = Spring.FindUnitCmdDesc
local SetUnitBuildspeed = Spring.SetUnitBuildSpeed

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- temporary include from commmand constants
-- CMD_BUILDSPEED
include("LuaRules/Configs/commandsIDs.lua")

local buildspeedlist = {}

local factoryDefs = {
  armlab = true,
  corlab = true,
  armvp = true,
  corvp = true,
  armap = true,
  corap = true,
  armhp = true,
  corhp = true,
  armcsy = true,
  corcsy = true,
  armplat = true,
  corplat = true,
  armalab = true,
  coralab = true,
  armavp = true,
  coravp = true,
  armaap = true,
  coraap = true,
  armfff = true,
  corgant = true,
  armhklab = true,
  corvalkfac = true,
  armshltx = true,
  corslab = true,

}

local buildspeedCmdDesc = {
  id      = CMD_BUILDSPEED,
  type    = CMDTYPE.ICON_MODE,
  name    = 'Production',
  cursor  = 'Production',
  action  = 'Production',
  tooltip = 'Orders: Production Rate',
  params  = { '0', '25%', '50%', '75%', '100%'}
}
  
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function AddBuildspeedCmdDesc(unitID)
  if (FindUnitCmdDesc(unitID, CMD_BUILDSPEED)) then
    return  -- already exists
  end
  local insertID = 
    FindUnitCmdDesc(unitID, CMD.CLOAK)      or
    FindUnitCmdDesc(unitID, CMD.ONOFF)      or
    FindUnitCmdDesc(unitID, CMD.TRAJECTORY) or
    FindUnitCmdDesc(unitID, CMD.REPEAT)     or
    FindUnitCmdDesc(unitID, CMD.MOVE_STATE) or
    FindUnitCmdDesc(unitID, CMD.FIRE_STATE) or
    123456 -- back of the pack
  buildspeedCmdDesc.params[1] = '1'
  Spring.InsertUnitCmdDesc(unitID, insertID + 1, buildspeedCmdDesc)
end


local function UpdateButton(unitID, statusStr)
  local cmdDescID = FindUnitCmdDesc(unitID, CMD_BUILDSPEED)
  if (cmdDescID == nil) then
    return
  end

  local tooltip
  if (statusStr == '0') then
    tooltip = 'Orders: Production at 25%.'
  elseif (statusStr == '1') then
    tooltip = 'Orders: Production at 50%.'
  elseif (statusStr == '2') then
    tooltip = 'Orders: Production at 75%.'
  else
    tooltip = 'Orders: Full Production.'
  end

  buildspeedCmdDesc.params[1] = statusStr

  Spring.EditUnitCmdDesc(unitID, cmdDescID, { 
    params  = buildspeedCmdDesc.params, 
    tooltip = tooltip,
  })
end


local function BuildspeedCommand(unitID, unitDefID, cmdParams, teamID)

  local ud = UnitDefs[unitDefID]
  if (factoryDefs[ud.name]) then

    local status
    if cmdParams[1] == 1 then
      status = '1'
      Spring.SetUnitBuildSpeed(unitID, buildspeedlist[unitID]*.5)
    elseif cmdParams[1] == 2 then
      status = '2'

      Spring.SetUnitBuildSpeed(unitID, buildspeedlist[unitID]*.75)
     elseif cmdParams[1] == 3 then
      status = '3'
      Spring.SetUnitBuildSpeed(unitID, buildspeedlist[unitID]*1)
    else
      status = '0'
      Spring.SetUnitBuildSpeed(unitID, buildspeedlist[unitID]*.25)
    end
  UpdateButton(unitID, status)
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:UnitCreated(unitID, unitDefID, teamID, builderID)
  local ud = UnitDefs[unitDefID]
  if (factoryDefs[ud.name]) then
    buildspeedlist[unitID]=ud.buildSpeed
    AddBuildspeedCmdDesc(unitID)
    UpdateButton(unitID, '3')
    --RetreatCommand(unitID, unitDefID, { builderInfo[1] }, teamID)
  end
end

function gadget:UnitDestroyed(unitID, _, teamID)
  buildspeedlist[unitID] = nil
end

function gadget:Initialize()
  gadgetHandler:RegisterCMDID(CMD_BUILDSPEED)
  for _, unitID in ipairs(Spring.GetAllUnits()) do
    local teamID = Spring.GetUnitTeam(unitID)
    local unitDefID = GetUnitDefID(unitID)
    gadget:UnitCreated(unitID, unitDefID, teamID)
  end
end




function gadget:AllowCommand(unitID, unitDefID, teamID, cmdID, cmdParams, _)
  local returnvalue
  if cmdID ~= CMD_BUILDSPEED then
    return true
  end
  BuildspeedCommand(unitID, unitDefID, cmdParams, teamID)  
  return false
end

function gadget:Shutdown()
  for _, unitID in ipairs(Spring.GetAllUnits()) do
    local cmdDescID = FindUnitCmdDesc(unitID, CMD_BUILDSPEED)
    if (cmdDescID) then
      Spring.RemoveUnitCmdDesc(unitID, cmdDescID)
    end
  end
end



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
