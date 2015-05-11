
function onDiceLanded(draginfo)
	if draginfo.isType("dice") then
		local dielist = draginfo.getDieList();
		
		if window.rollmode.isVisible() then
			window.rollmode.subwindow.rolls.applyRoll(dielist);
		end
	
		return true;
	end
end
