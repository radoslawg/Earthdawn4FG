local modifierWidget = nil;
local modifierFieldNode = nil;

function getModifier()
	return modifierFieldNode.getValue();
end

function setModifier(value)
	modifierFieldNode.setValue(value);
end

function onGainFocus()
	setColor("#FF990099");
end

function onLoseFocus()
	setColor(nil);
end

function setModifierDisplay(value)
	if value > 0 then
		modifierWidget.setText("+" .. value);
	else
		modifierWidget.setText(value);
	end
	
	if value == 0 then
		modifierWidget.setVisible(false);
	else
		modifierWidget.setVisible(true);
	end
end

function updateModifier(source)
	setModifierDisplay(modifierFieldNode.getValue());
end


function onInit()
	dieWidget = addTextWidget("sheettextsmall", "0");
	dieWidget.setFrame("tempmodsmall", 6, 3, 8, 5);
	dieWidget.setPosition("left", 10, 0);
	dieWidget.setVisible(false);
	modifierWidget = addTextWidget("sheettextsmall", "0");
	modifierWidget.setFrame("tempmodsmall", 6, 3, 8, 5);
	modifierWidget.setPosition("topleft", 10, 0);
	modifierWidget.setVisible(false);
	
	-- By default, the modifier is in a field named based on the parent control.
	local modifierFieldName = getName() .. "modifier";
	if modifierfield then
		-- Use a <modifierfield> override
		modifierFieldName = modifierfield[1];
	end
	
	modifierFieldNode = window.getDatabaseNode().createChild(modifierFieldName, "number");
	modifierFieldNode.onUpdate = updateModifier;
	addSourceWithOp(modifierFieldName, "+");

	updateModifier(modifierFieldNode);

	super.onInit();

end

function onWheel(notches)
	setModifier(getModifier() + notches);
	return true;
end

function onDrop(x, y, draginfo)
	if draginfo.getType() == "number" then
		setModifier(draginfo.getNumberData());
	end
	return true;
end


function onDrag(button,x,y,dragdata)
	if getValue() >= 1 then
		dragdata.setType("dice");
		dragdata.setSlot(1);
		dice = {};
		mod = 0;
		dice, mod = Step.getStepDice(getValue());
		dragdata.setDieList(dice);
	
		dragdata.setDescription(window[field[1]].getValue() .. " " .. description[1]);
		dragdata.setNumberData(mod);
	end
	return true;
end

function onDoubleClick()
	if getValue() >= 1 then
		dice = {};
		mod = 0;
		dice, mod = Step.getStepDice(getValue());
		ChatManager.control.throwDice("dice",dice, mod, window[field[1]].getValue() .. " " .. description[1]);
	end
end

function onHover(state)
	if state and getValue() >= 1 then
		diestring = "";
		dice = {};
		mod = 0;
		dice, mod = Step.getStepDice(getValue());
		for i=1,table.maxn(dice) do
			diestring = diestring .. dice[i] .. "+";
		end
		if mod < 0 then
			diestring = string.sub(diestring,1,string.len(diestring)-1) .. mod;
		else
			diestring = string.sub(diestring,1,string.len(diestring)-1);
		end
		dieWidget.setText(diestring);
		dieWidget.setVisible(true);
	else
		dieWidget.setVisible(false);
	end
end
