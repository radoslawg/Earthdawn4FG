
function onInit()
	dieWidget = addTextWidget("sheettextsmall", "0");
	dieWidget.setFrame("tempmodsmall", 6, 3, 8, 5);
	dieWidget.setPosition("topright", 10, -5);
	dieWidget.setVisible(false);
end

function onGainFocus()
	setColor("#FF990099");
end

function onLoseFocus()
	setColor(nil);
end

function onDrag(button,x,y,dragdata)
	if getValue() >= 1 then
		dragdata.setType("dice");
		dragdata.setSlot(1);
		dice = {};
		mod = 0;
		dice, mod = Step.getStepDice(getValue());
		dragdata.setDieList(dice);
	
		dragdata.setDescription(description[1]);
		dragdata.setNumberData(mod);
	end
	return true;
end

function onDoubleClick()
	if getValue() >= 1 then
		dice = {};
		mod = 0;
		dice, mod = Step.getStepDice(getValue());
		ChatManager.control.throwDice("dice",dice, mod, description[1]);
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
