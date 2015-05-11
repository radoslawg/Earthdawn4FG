-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

function onInit()
	CombatManager.setCustomSort(sortfunc);
	CombatManager.setCustomCombatReset(resetInit);
end

--
-- CALLBACKS
--

-- NOTE: Lua sort function expects the opposite boolean value compared to built-in FG sorting
function sortfunc(node1, node2)
	local nValue1 = DB.getValue(node1, "initresult", 0);
	local nValue2 = DB.getValue(node2, "initresult", 0);
	if nValue1 ~= nValue2 then
		return nValue1 > nValue2;
	end
	
	local sValue1 = DB.getValue(node1, "name", "");
	local sValue2 = DB.getValue(node2, "name", "");
	if sValue1 ~= sValue2 then
		return sValue1 < sValue2;
	end

	return node1.getNodeName() < node2.getNodeName();
end

--
-- ACTIONS
--

function resetInit()
	for _, vChild in pairs(DB.getChildren(CombatManager.CT_LIST)) do
		DB.setValue(vChild, "initresult", "number", 0);
	end
end

function rollInit(sCharType)
	for _, v in pairs(DB.getChildren(CombatManager.CT_LIST)) do
		local sClass, _ = DB.getValue(v, "link", "", "");
		if (sClass == "charsheet" and sCharType == "PC") or (sClass ~= "charsheet" and sCharType == "NPC") or sCharType == "All" then
            local ctinitval = DB.getValue(v, "init", 0);
			local nInit = getStepInit(ctinitval)
			DB.setValue(v, "initresult", "number", nInit);

		end
        
        if sCharType == "All" then
            DB.setValue(v, "active", "number", 0);        
        end
	end	
end

function getStepInit(step)
        if step > 0 then
                --print("Init step " .. step);
                dice, modifier = Step.getStepDice(step);
                total = modifier;
                for k, v in ipairs(dice) do
                        repeat
                                roll = math.random(string.sub(v,2));
                                total = total + roll;
                        until roll ~= tonumber(string.sub(v,2));
                end
                return total;
        else
                return 0;
        end
end