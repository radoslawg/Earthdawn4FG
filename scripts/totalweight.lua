function total()
	char = window.getDatabaseNode().getChild("weight");
	-- setValue(armorsource.getValue() + invsource.getValue() + weapsource.getValue());
	-- setValue(armorsource.getValue() + invsource.getValue());
	setValue(round(invsource.getValue(),2));
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function armorUpdate()
	total();
end

function invUpdate()
	total();
end

function weapUpdate()
	total();
end

function onInit()
	-- armorsource = window.getDatabaseNode().getChild("weight.armor");
	-- armorsource.onUpdate = armorUpdate;

	invsource = window.getDatabaseNode().getChild("weight.inv");
	invsource.onUpdate = invUpdate;

	weisource = window.getDatabaseNode().getChild("cwtotal");
	weisource.onUpdate = findWeightMax;

	strsource = window.getDatabaseNode().getChild("attributes.strength.base");
	strsource.onUpdate = findWeightMax;

	-- weapsource = window.getDatabaseNode().getChild("weight.weap");
	-- weapsource.onUpdate = weapUpdate;
	labelwidget = addTextWidget("sheetlabelinline", string.upper(label[1]));
					
	local w,h = labelwidget.getSize();
	labelwidget.setPosition("bottomleft", w/2, h/2-5);


	total();

end

function findWeightMax()
	--print("finding weight");
	local strstat = window.getDatabaseNode().getChild("attributes.strength.base");
	local dexstat = window.getDatabaseNode().getChild("attributes.dexterity.base");
	local dextmp = window.getDatabaseNode().getChild("attributes.dexterity.tmp");
	--print("Str = " .. strstat.getValue());
	--print("dex = " .. dexstat.getValue());
	--print("dextmp = " .. dextmp.getValue());
	local penalty = 0;
	local pentext = "";
	--print("dextmp = " .. dextmp.getValue());

	local strvalue = strstat.getValue();
	local wlimit = 0;
	if strvalue <= 1 then
		wlimit = 10;
	elseif strvalue == 2 then
		wlimit = 15;
	elseif strvalue == 3 then
		wlimit = 20;
	elseif strvalue == 4 then
		wlimit = 25;
	elseif strvalue == 5 then
		wlimit = 30;
	elseif strvalue == 6 then
		wlimit = 35;
	elseif strvalue == 7 then
		wlimit = 40;
	elseif strvalue == 8 then
		wlimit = 50;
	elseif strvalue == 9 then
		wlimit = 60;
	elseif strvalue == 10 then
		wlimit = 70;
	elseif strvalue == 11 then
		wlimit = 80;
	elseif strvalue == 12 then
		wlimit = 90;
	elseif strvalue == 13 then
		wlimit = 105;
	elseif strvalue == 14 then
		wlimit = 125;
	elseif strvalue == 15 then
		wlimit = 145;
	elseif strvalue == 16 then
		wlimit = 165;
	elseif strvalue == 17 then
		wlimit = 200;
	elseif strvalue == 18 then
		wlimit = 230;
	elseif strvalue == 19 then
		wlimit = 270;
	elseif strvalue == 20 then
		wlimit = 315;
	elseif strvalue == 21 then
		wlimit = 360;
	elseif strvalue == 22 then
		wlimit = 430;
	elseif strvalue == 23 then
		wlimit = 500;
	elseif strvalue == 24 then
		wlimit = 580;
	elseif strvalue == 25 then
		wlimit = 675;
	elseif strvalue == 26 then
		wlimit = 790;
	elseif strvalue == 27 then
		wlimit = 920;
	elseif strvalue == 28 then
		wlimit = 1075;
	elseif strvalue == 29 then
		wlimit = 1200;
	elseif strvalue == 30 then
		wlimit = 1450;
	end
	local curwt = tonumber(window.getDatabaseNode().getChild("cwtotal").getValue());
	--print("curwt = " .. curwt);
	--print("wlimit = " .. wlimit);
	window.getDatabaseNode().getChild("cwlimit").setValue(wlimit);
	local strneeded = 0;
	if curwt > wlimit then
		--print("oops to much weight, getting a dex pen, enjoy!");
		if curwt <= 10 then
			strneeded = 1;
		elseif curwt <= 15 then
			strneeded = 2;
		elseif curwt <= 20 then
			strneeded = 3;
		elseif curwt <= 25 then
			strneeded = 4;
		elseif curwt <= 30 then
			strneeded = 5;
		elseif curwt <= 35 then
			strneeded = 6;
		elseif curwt <= 40 then
			strneeded = 7;
		elseif curwt <= 50 then
			strneeded = 8;
		elseif curwt <= 60 then
			strneeded = 9;
		elseif curwt <= 70 then
			strneeded = 10;
		elseif curwt <= 80 then
			strneeded = 11;
		elseif curwt <= 90 then
			strneeded = 12;
		elseif curwt <= 105 then
			strneeded = 13;
		elseif curwt <= 125 then
			strneeded = 14;
		elseif curwt <= 145 then
			strneeded = 15;
		elseif curwt <= 165 then
			strneeded = 16;
		elseif curwt <= 200 then
			strneeded = 17;
		elseif curwt <= 230 then
			strneeded = 18;
		elseif curwt <= 270 then
			strneeded = 19;
		elseif curwt <= 315 then
			strneeded = 20;
		elseif curwt <= 360 then
			strneeded = 21;
		elseif curwt <= 430 then
			strneeded = 22;
		elseif curwt <= 500 then
			strneeded = 23;
		elseif curwt <= 580 then
			strneeded = 24;
		elseif curwt <= 675 then
			strneeded = 25;
		elseif curwt <= 790 then
			strneeded = 26;
		elseif curwt <= 920 then
			strneeded = 27;
		elseif curwt <= 1075 then
			strneeded = 28;
		elseif curwt <= 1200 then
			strneeded = 29;
		elseif curwt <= 1450 then
			strneeded = 30;
		end
		--print("strneeded = " .. strneeded);
		penalty = strvalue - strneeded;
		pentext = "Dexterity Penalty: " .. penalty;
	end
	--print("penalty = " .. penalty);
	window.getDatabaseNode().getChild("cwencumbrance").setValue(pentext);
	local oldpen = dextmp.getValue(penalty)
	if penalty ~= oldpen then
		--print("updating penalty from " .. oldpen .. " to " .. penalty)
		dextmp.setValue(penalty);
	else
		--print("no change in penalty");
	end
end
