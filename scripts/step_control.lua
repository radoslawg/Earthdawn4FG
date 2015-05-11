local updating = false;
function update()
	if not updating then
		local updating = true;
		setValue(Step.getStep(source.getValue()));
		local updating = false;
	end
end

function onInit()
	valuefield = valuefield[1];
	source = window.getDatabaseNode().getChild(valuefield);
	source.onUpdate = update;
	update();
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
