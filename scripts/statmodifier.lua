function onInit()
    runStep();
end

function onValueChanged()
    runStep();
end

function runStep()
	if getValue() then
		local ret = setStep();
		return ret;
	end
end

function setStep(something)
	if type(something) ~= "string" then
		something = "attribute";
	end
	local stepsource = "";
	if getValue() == "Dexterity" then 
        stepsource = "...attributes.dexterity.step";
	elseif getValue() == "Strength" then
		stepsource = "...attributes.strength.step";
	elseif getValue() == "Toughness" then
		stepsource = "...attributes.toughness.step";
	elseif getValue() == "Perception" then
		stepsource = "...attributes.perception.step";
	elseif getValue() == "Willpower" then
		stepsource = "...attributes.willpower.step";
	elseif getValue() == "Charisma" then
		stepsource = "...attributes.charisma.step";
	end
	if stepsource ~= "" then
        window.attribute.clearSources();
        window.attribute.addSourceWithOp(stepsource, "+");
        window.attribute.sourceUpdate();
		if something == "attribute" then
			window.attribute.setReadOnly(true);
		end
		return true;
	else
		if something == "attribute" then
            window.attribute.clearSources();
			window.attribute.setReadOnly(false);
            window.attribute.setValue(0);
		end
		return false;
	end
end
function grabTalentInfo(targetlist, chkfield, locstepfield, lookfor)
	local node = window.getDatabaseNode().getParent().getParent();
	local talentnumber = node.getChild(targetlist).getChildCount();
	local source = node.getChild(targetlist);
	local templist = source.getChildren();
	local attrib, karmaok, tname, karmavis,karmaval,karmaro,karmaclass;
	for i in pairs(templist) do
		if templist[i].getChild(chkfield) then
			attrib = templist[i].getChild(chkfield).getValue();
			karmaok = false;
			if attrib == getValue() then
				tname = getValue();
				window.getDatabaseNode().getChild(locstepfield).setValue(templist[i].getChild("step.total").getValue());
					
				if targetlist == "talents" then
					--print(".Karma check");
					karmavis = false;
					karmaval = 1;
					karmaro = false;
					karmaok = false;
					if templist[i].getChild("karma").getValue() == 1 then
						--print("..Karma Required");
						karmavis = true;
						karmaval = 1;
						karmaro = false;
						karmaok = true;
						
					end
					if templist[i].getChild("discipline").getValue() == 1 then
						--print("..Karma Allowed");
						karmavis = true;
						karmaval = 0;
						karmaro = true;
						karmaok = true;
					end
					if string.match(locstepfield, "attackbonus") == "attackbonus" then
						if window.karmaonattack.isVisible() == true or karmavis == true then
							karmavis = true;
						else
							karmavis = false;
							karmaval = false;
						end
						if window.karmaonattack.isEnabled() == true or karmaro == true then
							karmaro = true;
						else
							karmaro = false;
						end
						if window.karmaonattack.getState() == true then
							karmaval = true;
						elseif window.karmaonattack.getState() == false and karmaval == 1 and window.karmaonattack.isEnabled() == true then
							karmaval = true;
						elseif window.karmaonattack.isEnabled() == false and karmaval == 1 then
							karmaval = true;
						else
							karmaval = false;
						end
						--print ("...setting " .. tname .. " karmaclass: ");
						karmaclass = "attackkarmaclass";
						karmastep = "attackkarmastep";
						
						window.karmaonattack.setEnabled(true);
						window.karmaonattacklabel.setVisible(karmavis);
						window.karmaonattack.setVisible(karmavis);
						window.karmaonattackvis.setState(karmavis);
						window.karmaonattack.setState(karmaval);
						window.karmaonattack.setEnabled(karmaro);
						--print (".... karmaclass = " .. karmaclass);
					end
					if string.match(locstepfield, "damagebonus") == "damagebonus" then
						if window.karmaondamage.isVisible() == true or karmavis == true then
							karmavis = true;
						else
							karmavis = false;
							karmaval = false;
						end
						if window.karmaondamage.isEnabled() == true or karmaro == true then
							karmaro = true;
						else
							karmaro = false;
						end
						if window.karmaondamage.getState() == true then
							karmaval = true;
						elseif window.karmaondamage.getState() == false and karmaval == 1 and window.karmaondamage.isEnabled() == true then
							karmaval = true;
						elseif window.karmaondamage.isEnabled() == false and karmaval == 1 then
							karmaval = true;
						else
							karmaval = false;
						end
						--print ("...setting " .. tname .. " karmaclass: ");
						karmaclass = "damagekarmaclass";
						karmastep = "damagekarmastep";
						
						window.karmaondamage.setEnabled(true);
						window.karmaondamagelabel.setVisible(karmavis);
						window.karmaondamage.setVisible(karmavis);
						window.karmaondamagevis.setState(karmavis);
						window.karmaondamage.setState(karmaval);
						window.karmaondamage.setEnabled(karmaro);
						--print (".... karmaclass = " .. karmaclass);
					end
					if karmaok then
						window.getDatabaseNode().createChild(karmaclass, "string").setValue(templist[i].getChild("disciplinename").getValue());
					end
				end
				return true;
			end
		end
	end
	return false;
end
function updateStatBonuses(targetlist, desc, chkfield, modfield)
	if not updating then
	updating = true;
	--[[print("...working with " .. targetlist .. " for " .. desc);]]
	local node = window.getDatabaseNode();
	--[[print("node= " .. node.getNodeName());]]
	--[local talentnumber = node.getChild(targetlist).getChildCount();]]
	--[print("talentnumber = " .. talentnumber);]]
	
	local source = node.getChild(targetlist);
	local templist = source.getChildren();
	for i in pairs(templist) do
		if templist[i].getChild(chkfield) then
			local attrib = templist[i].getChild(chkfield).getValue();
			if attrib == desc then
				local tname = templist[i].getChild("name").getValue();
		--[[	
				print(tname .. " uses " .. attrib);
				test2 = templist[i].getChild(modfield).getValue();
				print("test2 = " .. test2); 
		]]
				templist[i].getChild(modfield).setValue(getValue());
		--[[
				test3 = templist[i].getChild(modfield).getValue();
				print("test3 = " .. test3);
		]]
			end
		end
	end
	updating = false;
	end
	--[print("...done with " .. targetlist .. " for " .. desc);]]
end
function updateListBonuses(targetlist, desc, chkfield, modfield)
	if not updating then
	updating = true;
	local node = window.windowlist.window.getDatabaseNode();
	local talentnumber = node.getChild(targetlist).getChildCount();
	
	local source = node.getChild(targetlist);
	local templist = source.getChildren();
	for i in pairs(templist) do
		if templist[i].getChild(chkfield) then
			local attrib = templist[i].getChild(chkfield).getValue();
			if attrib == desc then
				templist[i].getChild(modfield).setValue(getValue());
			end
		end
	end
	updating = false;
	end
end

