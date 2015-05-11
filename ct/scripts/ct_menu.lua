-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

function onInit()
	if User.isHost() then

		registerMenuItem(Interface.getString("ct_menu_itemdelete"), "delete", 3);
		registerMenuItem(Interface.getString("ct_menu_itemdeletenonfriendly"), "delete", 3, 1);
		registerMenuItem(Interface.getString("ct_menu_itemdeletefoe"), "delete", 3, 3);
        
        registerMenuItem("Initiative", "turn", 7);
        registerMenuItem("Roll All Initiatives", "shuffle", 7, 8);
        registerMenuItem("Roll NPC Initiatives", "mask", 7, 7);
        registerMenuItem("Roll PC Initiatives", "portrait", 7, 6);
        registerMenuItem("Clear All Initiatives", "pointer_circle", 7, 4);        
	end
end

function onClickDown(button, x, y)
	return true;
end

function onClickRelease(button, x, y)
	if button == 1 then
		Interface.openRadialMenu();
		return true;
	end
end

function onMenuSelection(selection, subselection, subsubselection)
	if User.isHost() then
		if selection == 7 then
			if subselection == 4 then
				CombatManager.resetInit();
			elseif subselection == 6 then
				CombatManager2.rollInit("PC");
			elseif subselection == 7 then
				CombatManager2.rollInit("NPC");
			elseif subselection == 8 then
				CombatManager2.rollInit("All")
			end
		elseif selection == 3 then
			if subselection == 1 then
				clearNPCs();
			elseif subselection == 3 then
				clearNPCs(true);
			end
		end
	end
end

function clearNPCs(bDeleteOnlyFoe)
	for _, vChild in pairs(window.list.getWindows()) do
		local sFaction = vChild.friendfoe.getStringValue();
		if bDeleteOnlyFoe then
			if sFaction == "foe" then
				vChild.delete();
			end
		else
			if sFaction ~= "friend" then
				vChild.delete();
			end
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