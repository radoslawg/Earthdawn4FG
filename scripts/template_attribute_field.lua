function onMenuSelection(selection1)
	if selection1 == 7 then
		win = Interface.openWindow("lpinc", getDatabaseNode().getParent());
		totaldesc = string.sub(getName(),1,3) .. "base";
		win.label.setValue(window[totaldesc].description[1].text[1] .. " LP increases");
		win.label.setReadOnly(true);
	end
end

function onWheel()
	return true;
end

function onGainFocus()
	setColor("#FF990099");
end

function onLoseFocus()
	setColor(nil);
end

function onHover(state)
	if state and totalnode.getValue() ~= 0 then
		lptotal = totalnode.getValue();
		lpstring = "Orig:" .. (getValue() - lptotal);
		lpWidget.setText(lpstring);
		lpWidget.setVisible(true);
	else
		lpWidget.setVisible(false);
	end
end

function onValueChanged()
	orig.setValue(getValue()-totalnode.getValue());
end

function update()
	setValue(orig.getValue()+totalnode.getValue());
end

function onInit()
	lpWidget = addTextWidget("smallcontrol", "0");
	lpWidget.setFrame("tempmodsmall", 6, 3, 6, 3);
	lpWidget.setPosition("top", 0,0);
	lpWidget.setVisible(false);
	
	orig = getDatabaseNode().getParent().createChild("original", "number");
	
	registerMenuItem("Legend Point increases", "layers", 7);
	totalnode = window.getDatabaseNode().createChild(modifierfield[1], "number");
	totalnode.onUpdate = update;
	update();
end
