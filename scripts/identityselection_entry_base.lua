
function onDoubleClick(x, y)
	if not User.isLocal() then
		User.requestIdentity(window.id, "charsheet", "name", window.localdatabasenode, window.requestResponse);
	else
		Interface.openWindow("charsheet", window.localdatabasenode);
		window.windowlist.window.close();
	end
	
	return true;
end

function onClickDown(button, x, y)
	window.windowlist.clearSelection();
	setFrame("sheetfocus", -2, -2, -1, -1);
	return true;
end
