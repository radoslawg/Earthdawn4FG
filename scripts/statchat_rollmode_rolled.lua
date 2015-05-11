
function onInit()
	activewidget = addBitmapWidget(activeicon[1]);
	activewidget.setVisible(false);
end

function onClickDown(button, x, y)
	window.reset();
end

function setState(state)
	activewidget.setVisible(state);
end
