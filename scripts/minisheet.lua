
function onInit()
	MinisheetSnapper.registerSheet(self);
end

function onClose()
	MinisheetSnapper.unregisterSheet(self);
end
