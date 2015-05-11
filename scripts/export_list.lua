-- 
-- Please see the readme.txt file included with this distribution for 
-- attribution and copyright information.
--

function onInit()
	addCategories();
end

function onDrop(x, y, draginfo)
	if draginfo.isType("shortcut") then
		for k,v in ipairs(getWindows()) do
			local class, recordname = draginfo.getShortcutData();
		
			-- Find matching export category
			if string.find(recordname, v.exportsource) == 1 then
				-- Check duplicates
				for l,c in ipairs(v.entries.getWindows()) do
					if c.getDatabaseNode().getNodeName() == recordname then
						return true;
					end
				end
			
				-- Create entry
				local w = v.entries.createWindow(draginfo.getDatabaseNode());
				w.open.setValue(class, recordname);
				
				v.all.setState(false);
				break;
			end
		end
		
		return true;
	end
end

function addCategories()
	local aCategories = {
		{ name = "encounter", class = "encounter", label = "Story" },
		{ name = "image", class = "imagewindow", label = "Images & Maps" },
		{ name = "battle", class = "battle", label = "Encounters" },
		{ name = "npc", class = "npc", label = "Personalities" },
		{ name = "item", class = "item", label = "Items" },
		};
	
	for keyCat, rCat in ipairs(aCategories) do
		local win = createWindow();
		win.setExportName(rCat.name);
		win.setExportClass(rCat.class);
		win.label.setValue(rCat.label);
	end
end
