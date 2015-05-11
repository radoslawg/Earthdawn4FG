-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

function onInit()
	ActionsManager.registerResultHandler("step", onResult);
end

function performSRoll(draginfo, rActor, nodeWin, skillType)
	local sSkillName = DB.getValue(nodeWin, "name", "");
    local nSkillMod = 0;
	
	local nSkillTemp = nil;
	nSkillTemp = nodeWin.getValue(0);
    local nStrain = DB.getValue(nodeWin, "strain", 0);
	if skillType == nil then	
		skillType = nodeWin.getParent().getName();
	end
	
	performRoll(draginfo, skillType, rActor, sSkillName, nSkillMod, sSkillStat, nSkillTemp, nSkillTarget, bSecretRoll, nStrain);
end

function performRoll(draginfo, skillType, rActor, sSkillName, nSkillMod, sSkillStat, nSkillTemp, nSkillTarget, bSecretRoll, nStrain)
	local rRoll = getRoll(rActor, skillType, sSkillName, nSkillMod, sSkillStat, nSkillTemp, nSkillTarget, bSecretRoll, nStrain);
	ActionsManager.performAction(draginfo, rActor, rRoll);
end

function getRoll(rActor, skillType, sSkillName, nSkillMod, sSkillStat, nSkillTemp, nSkillTarget, bSecretRoll, nStrain)
	local rRoll = {};
	rRoll.sType = "step";
	rRoll.aDice, rRoll.nMod = Step.getStepDice(nSkillTemp);
    rRoll.sDesc = "[" .. StringManager.capitalize(skillType);
	if sSkillName then
		rRoll.sDesc = rRoll.sDesc .. ": " .. sSkillName .. "]";
	end
    if nStrain > 0 then
            rRoll.sDesc = rRoll.sDesc .. " [Strain Damage: " .. nStrain .. "]";
    end
	rRoll.bSecret = bSecretRoll;
    rRoll.nStrain = nStrain;
	return rRoll;
end

function serializeTable(val)
    local tmp = ""
    for k, v in pairs(val) do
        tmp =  tmp .. v.result .. "," .. v.type .. ";"
    end

    return tmp
end

function deserializeTable(val)
    local result = {}
    for k,i in string.gmatch(val, "(%w+),(%w+)") do
        local vvv = {}
        vvv.result = k
        vvv.type = i
        table.insert(result, vvv)
    end
    return result
end

function getReRoll(aDice, iRoll)
    local rRoll = {}
    rRoll.aDice = aDice
    rRoll.nMod = iRoll.nMod 
    rRoll.sType = iRoll.sType
    rRoll.bSecret = iRoll.bSecret 
    rRoll.nStrain = iRoll.nStrain
    rRoll.sDesc = iRoll.sDesc
    rRoll.rPreviousResult = serializeTable(iRoll.aDice)
    return rRoll
end

function onResult(rSource, rTarget, rRoll)
	local isMaxResult = function(rDie)
		if tonumber(rDie.type:match("^d(%d+)")) == rDie.result then
			return rDie.result
		else
			return 0
		end
	end
	
    explode = {}
	for i,die in ipairs(rRoll.aDice) do
		local reroll = isMaxResult(die)
		if reroll>0 then
            table.insert(explode, die.type)
		end
	end
    if rRoll.rPreviousResult then
        prev = deserializeTable(rRoll.rPreviousResult)
        for i,roll in ipairs(prev) do
            table.insert(rRoll.aDice, 1, roll)
        end
    end
    if table.getn(explode) > 0 then
        ActionsManager.performAction(draginfo, rActor, getReRoll(explode, rRoll));        
        return false;
    end;
	
    if tonumber(rRoll.nStrain) > 0 then
        local st = tonumber(rRoll.nStrain);
        local hd = DB.getChild(rSource.sCreatureNode, "health.damage");
        hd.setValue(hd.getValue() + st );
    end
    
	local rMessage = ActionsManager.createActionMessage(rSource, rRoll);
	local nTotal = ActionsManager.total(rRoll);

	Comm.deliverChatMessage(rMessage);
end