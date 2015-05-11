
local updating = false;

local modifierWidget = nil;
local modifierFieldNode = nil;

function getModifier()
	return modifierFieldNode.getValue();
end

function setModifier(value)
	if not updating then
	updating = true;
	--print("modifier update " .. getName());
	modifierFieldNode.setValue(value);
	updating = false;
	end
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
	local locationName = "bottomright";
	if modifierloc then
		locationName = modifierloc[1];
	end
	modifierWidget = addTextWidget("sheettextsmall", "0");
	modifierWidget.setFrame("tempmodsmall", 4, 2, 4, 4);
	modifierWidget.setPosition(locationName, 5, 0);
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
