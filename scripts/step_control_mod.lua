local modifierWidget = nil;
local modifierFieldNode = nil;

function getModifier()
	return modifierFieldNode.getValue();
end

function setModifier(value)
	modifierFieldNode.setValue(value);
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

function onGainFocus()
	setColor("#FF990099");
end

function onLoseFocus()
	setColor(nil);
end

function update()
	setValue(Step.getStep(source.getValue()));
end

function onInit()
	valuefield = valuefield[1];
	source = window.getDatabaseNode().getChild(valuefield);
	source.onUpdate = update;
	update();
	dieWidget = addTextWidget("sheettextsmall", "0");
	dieWidget.setFrame("tempmodsmall", 6, 3, 8, 5);
	dieWidget.setPosition("topleft", 10, -5);
	dieWidget.setVisible(false);

	modifierWidget = addTextWidget("sheettextsmall", "0");
	modifierWidget.setFrame("tempmodsmall", 6, 3, 8, 5);
	modifierWidget.setPosition("bottomright", 7, 0);
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

function onDrag(button,x,y,dragdata)
	dragdata.setType("dice");
	dragdata.setSlot(1);
	dice = {};
	mod = 0;
	dice, mod = Step.getStepDice(Step.getStep(source.getValue()));
	dragdata.setDieList(dice);
	
	dragdata.setDescription(description[1]);
	dragdata.setNumberData(mod);
	
	return true;
end

function onDoubleClick()
	dice = {};
	mod = 0;
	dice, mod = Step.getStepDice(Step.getStep(source.getValue()));
	ChatManager.control.throwDice("dice",dice, mod, description[1]);
end

function onHover(state)
	if state then
		diestring = "";
		dice = {};
		mod = 0;
		dice, mod = Step.getStepDice(Step.getStep(source.getValue()));
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
