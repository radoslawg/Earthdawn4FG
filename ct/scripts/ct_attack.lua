-- 
-- Please see the readme.txt file included with this distribution for 
-- attribution and copyright information.
--

local parsed = false;
local rPower = nil;

local hoverAbility = nil;
local clickAbility = nil;

function onValueChanged()
	parsed = false;
end

function onHover(oncontrol)
	if dragging then
		return;
	end

	-- Reset selection when the cursor leaves the control
	if not oncontrol then
		-- Clear hover tracking
		hoverAbility = nil;
		
		-- Clear any auras
		window.windowlist.window.token.updateUnderlay();

		-- Clear any selections
		setSelectionPosition(0);
	end
end

function onHoverUpdate(x, y)
	-- If we're typing or dragging, then exit
	if dragging then
		return;
	end

	-- Compute the locations of the relevant phrases, and the mouse
	if not parsed then
		parsed = true;
		rPower = CombatCommon.parseCTAttackLine(getValue());
	end
	local mouse_index = getIndexAt(x, y);

	-- Clear any memory of the last hover update
	hoverAbility = nil;
	
	-- Clear any auras
	window.windowlist.window.token.updateUnderlay();

	-- Capture the power that we're over, so we can name it
	if rPower then
		for k, v in pairs(rPower.abilities) do
			if (v.startpos <= mouse_index) and (v.endpos > mouse_index) then
				hoverAbility = k;
				setCursorPosition(v.startpos);
				setSelectionPosition(v.endpos);
				break;
			end
		end

		if hoverAbility then
			if rPower.abilities[hoverAbility].type == "attack" or rPower.abilities[hoverAbility].type == "damage" then
				setHoverCursor("hand");
			else
				setHoverCursor("arrow");
			end

			if rPower.abilities[hoverAbility].type == "aura" then
				window.windowlist.window.token.drawAura(rPower.abilities[hoverAbility].val, window.windowlist.window.space.getValue());
			end

			return;
		end
	end

	-- Reset the cursor
	setHoverCursor("arrow");
end

function rechargePower()
	if rPower and rPower.usage_val == "USED" then
		local s = string.sub(getValue(), 1, rPower.usage_startpos - 2) .. string.sub(getValue(), rPower.usage_endpos + 1);
		setValue(s);

		EffectsManager.removeEffect(window.windowlist.window.getDatabaseNode(), "RCHG: %d " .. string.gsub(rPower.name, "%*", "%%%*"));
	end
end

function usePower()
	if rPower and rPower.usage_val and rPower.usage_val ~= "USED" then
		local s = string.sub(getValue(), 1, rPower.usage_endpos) .. "[USED]" .. string.sub(getValue(), rPower.usage_endpos + 1);
		setValue(s);

		local recharge_val = string.match(rPower.usage_val, 'R:(%d)');
		if recharge_val then
			EffectsManager.addEffect("", "", window.windowlist.window.getDatabaseNode(), { sName = "RCHG: " .. recharge_val .. " " .. rPower.name, nGMOnly = 1 });
		end
	end
end

function showPowerDetails(rAbility)
	local powername = string.gsub(rAbility.name, '*', '');

	local shown = false;
	local lookup_node = window.windowlist.window.link.getTargetDatabaseNode();
	if lookup_node then
		if lookup_node.getChild("powers") then
			local powerchildren = lookup_node.getChild("powers").getChildren();
			for k, v in pairs(powerchildren) do
				if v.get("name", "") == powername then
					Interface.openWindow("reference_power_custom", v.getNodeName());
					shown = true;
				end
			end
		end
	end

	if not shown then
		ChatManager.Message("[WARNING] Unable to locate power '" .. powername .. "'");
	end
end

function handleDoubleClick(rAbility)
	-- NAME
	if rAbility.type == "name" then
		showPowerDetails(rAbility);

	-- ATTACK
	elseif rAbility.type == "attack" then
		local rActor = CombatCommon.getActor("ct", getDatabaseNode().getChild("...."));
		local atk_name, atk_dice, atk_mod = RulesManager.buildAttackRoll(rActor, rAbility, nil);
		usePower(rPower);
		RulesManager.dclkAction("attack", atk_mod, atk_name, rActor, nil, atk_dice);

	-- DAMAGE
	elseif rAbility.type == "damage" then
		local rActor = CombatCommon.getActor("ct", getDatabaseNode().getChild("...."));
		local dmg_name, dmg_dice, dmg_mod = RulesManager.buildDamageRoll(rActor, rAbility, nil);
		RulesManager.dclkAction("damage", dmg_mod, dmg_name, rActor, nil, dmg_dice);

	-- USAGE
	elseif rAbility.type == "usage" then
		if rPower.usage_val == "USED" then
			rechargePower(rPower);
		else
			usePower(rPower);
		end
	end
end

function handleDrag(rAbility, draginfo)
	-- ATTACK
	if rAbility.type == "attack" then
		local rActor = CombatCommon.getActor("ct", getDatabaseNode().getChild("...."));
		local atk_name, atk_dice, atk_mod = RulesManager.buildAttackRoll(rActor, rAbility, nil);
		usePower(rPower);
		RulesManager.dragAction(draginfo, "attack", atk_mod, atk_name, rActor, atk_dice);

	-- DAMAGE
	elseif rAbility.type == "damage" then
		local rActor = CombatCommon.getActor("ct", getDatabaseNode().getChild("...."));
		local dmg_name, dmg_dice, dmg_mod = RulesManager.buildDamageRoll(rActor, rAbility, nil);
		RulesManager.dragAction(draginfo, "damage", dmg_mod, dmg_name, rActor, dmg_dice);
	end
end

function onClickDown(button, x, y)
	-- Suppress default processing to support dragging
	clickAbility = hoverAbility;
	
	return true;
end

function onClickRelease(button, x, y)
	-- Enable edit mode on mouse release
	setFocus();
	
	local n = getIndexAt(x, y);
	
	setSelectionPosition(n);
	setCursorPosition(n);
	
	return true;
end

function onDoubleClick(x, y)
	if hoverAbility then
		handleDoubleClick(rPower.abilities[hoverAbility]);
		return true;
	end
end

function onDrag(button, x, y, draginfo)
	if dragging then
		return true;
	end

	if clickAbility then
		handleDrag(rPower.abilities[clickAbility], draginfo);
		
		clickAbility = nil;
		dragging = true;
	end
	
	return true;
end

function onDragEnd(dragdata)
	setCursorPosition(0);
	dragging = false;
end
