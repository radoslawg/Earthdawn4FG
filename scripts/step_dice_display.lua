
local modifierWidget = nil;
local modifierFieldNode = nil;

function onInit()
	dieWidget = addTextWidget("sheettextsmall", "0");
	dieWidget.setFrame("tempmodsmall", 6, 3, 8, 5);
	dieWidget.setPosition("topleft", -10, 5);
	dieWidget.setVisible(false);
	super.onInit();
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
    super.onHover(state);
end