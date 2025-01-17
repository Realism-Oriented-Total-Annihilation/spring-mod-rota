----- mission spirits settigns ------
----- more about: http://springrts.com/phpbb/viewtopic.php?f=55&t=28259

local spGetUnitPosition	= Spring.GetUnitPosition

newPlan = {
    ["attackShip"] = function(groupID, teamNumber)
		local myName = unitsUnderGreatEyeIDtoName[groupInfo[groupID].membersList[1]]
		local numberOfAttacker = string.sub(myName, 6)
		local targetName = "target1"
		local x, y, z = spGetUnitPosition(unitsUnderGreatEyeNameToID[targetName].id)
		-- commands.Attack.Unit(groupID, {x, y, z})
		
		commands.Attack.Unit(groupID, unitsUnderGreatEyeNameToID[targetName].id)
		return true
	end,
	["patrolCarrier"] = function(groupID, teamNumber)
		commands.Move.Unit(groupID, map["shipsPositions"][3])
		commands.Patrol.Unit(groupID, map["shipsPositions"][1], 1, {"shift"})
		commands.Patrol.Unit(groupID, map["shipsPositions"][2], 1, {"shift"})

		return true
	end,
	["wait"] = function(groupID, teamNumber)
        return true
	end,
}

newSpiritDef = {
    ["torpeder"] = function(groupID, teamNumber, mode)
	    if (mode == "prepare") then
		    return -- do nothing
		else  -- execute mode:
		    local thisGroup = groupInfo[groupID]
			local isAttacking = blackboard.Get(groupID, "isAttacking")
		    if (isAttacking) then
				plan.wait(groupID, teamNumber)
			else
				plan.attackShip(groupID, teamNumber)
				blackboard.Set(groupID, "isAttacking", true)
			end
		end
    end,
	["carrier"] = function(groupID, teamNumber, mode)
	    if (mode == "prepare") then
		    return -- do nothing
		else  -- execute mode:
		    local thisGroup = groupInfo[groupID]
			local isMoving = blackboard.Get(groupID, "isMoving")
		    if (isMoving) then
				plan.wait(groupID, teamNumber)
			else
				plan.patrolCarrier(groupID, teamNumber)
				blackboard.Set(groupID, "isMoving", true)
			end
		end
    end,
}