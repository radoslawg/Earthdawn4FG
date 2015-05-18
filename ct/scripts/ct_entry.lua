--[[ vim: set tabstop=4 shiftwidth=4 foldmethod=marker commentstring=\-\-\[\[\%s\]\]: ]]
-- 
-- Please see the readme.txt file included with this distribution for 
-- attribution and copyright information.
--

function onInit()
	-- Set the displays to what should be shown
	setTargetingVisible(false);
	setActiveVisible(false);
	setDefensiveVisible(false);
	setSpacingVisible(false);
	setEffectsVisible(false);

	-- Acquire token reference, if any
	linkToken();
	
	-- Set up the PC links
    linkPCFields();
	
	onWoundsChanged();
	
	-- Register the deletion menu item for the host
	registerMenuItem(Interface.getString("list_menu_deleteitem"), "delete", 6);
	registerMenuItem(Interface.getString("list_menu_deleteconfirm"), "delete", 6, 7);

end

function updateDisplay()--[[{{{]]
	local sFaction = friendfoe.getStringValue();

	if DB.getValue(getDatabaseNode(), "active", 0) == 1 then
		name.setFont("sheetlabel");
		
		active_spacer_top.setVisible(true);
		active_spacer_bottom.setVisible(true);
		
		if sFaction == "friend" then
			setFrame("ctentrybox_friend_active");
		elseif sFaction == "neutral" then
			setFrame("ctentrybox_neutral_active");
		elseif sFaction == "foe" then
			setFrame("ctentrybox_foe_active");
		else
			setFrame("ctentrybox_active");
		end
	else
		name.setFont("sheettext");
		
		active_spacer_top.setVisible(false);
		active_spacer_bottom.setVisible(false);
		
		if sFaction == "friend" then
			setFrame("ctentrybox_friend");
		elseif sFaction == "neutral" then
			setFrame("ctentrybox_neutral");
		elseif sFaction == "foe" then
			setFrame("ctentrybox_foe");
		else
			setFrame("ctentrybox");
		end
	end
end--[[}}}]]

function linkToken()--[[{{{]]
	local imageinstance = token.populateFromImageNode(tokenrefnode.getValue(), tokenrefid.getValue());
	if imageinstance then
		TokenManager.linkToken(getDatabaseNode(), imageinstance);
	end
end--[[}}}]]

function onMenuSelection(selection, subselection)--[[{{{]]
	if selection == 6 and subselection == 7 then
		delete();
	end
end--[[}}}]]

function delete()
	local node = getDatabaseNode();
	if not node then
		close();
		return;
	end
	
	-- Remember node name
	local sNode = node.getNodeName();
	
	-- Clear any effects and wounds first, so that saves aren't triggered when initiative advanced
	effects.reset(false);
	
	-- Move to the next actor, if this CT entry is active
	if DB.getValue(node, "active", 0) == 1 then
		CombatManager.nextActor();
	end

	-- Delete the database node and close the window
	node.delete();

	-- Update list information (global subsection toggles)
	windowlist.onVisibilityToggle();
	windowlist.onEntrySectionToggle();
end

function onLinkChanged()
	-- If a PC, then set up the links to the char sheet
	local sClass, sRecord = link.getValue();
	if sClass == "charsheet" then
		linkPCFields();
		name.setLine(false);
	end
end

function onFactionChanged()
	-- Update the entry frame
	updateDisplay();

	-- If not a friend, then show visibility toggle
	if friendfoe.getStringValue() == "friend" then
		tokenvis.setVisible(false);
	else
		tokenvis.setVisible(true);
	end
end

function onVisibilityChanged()
	TokenManager.updateVisibility(getDatabaseNode());
	windowlist.onVisibilityToggle();
end


function onWoundsChanged()--[[{{{]]
	-- Based on the percent wounded, change the font color for the Wounds field
	--[[if totaldamage.getValue() <= 0 then
		totaldamage.setFont("ct_healthy_number");
	elseif totaldamage.getValue() >= deathrating.getValue()  then
		totaldamage.setFont("ct_dead_number");
	elseif totaldamage.getValue() >= unconrating.getValue()  then
		totaldamage.setFont("ct_bloodied_number");
	elseif totaldamage.getValue() <= unconrating.getValue() / 2 then
		totaldamage.setFont("ct_ltwound_number");
	else 
		totaldamage.setFont("ct_ltwound_number");
	end

	-- Based on the percent wounded, set the Status text field
	if totaldamage.getValue() <= 0 then
		status.setValue("Healthy");
	elseif totaldamage.getValue() >= deathrating.getValue()  then
		status.setValue("Dead");
	elseif totaldamage.getValue() >= unconrating.getValue()  then
		status.setValue("Unconscious");
	elseif totaldamage.getValue() <= unconrating.getValue() / 2 then
		status.setValue("Light");
	else
		status.setValue("Damaged");
	end
	-- Update the token underlay to reflect wound status
	token.updateUnderlay(); --]]
end--[[}}}]]

function onSurgesChanged()--[[{{{]]
	-- Update the healing surges remaining field when healing surges max or healing surges used changes
	if type.getValue() == "pc" then
		--[[healsurgeremaining.setValue(healsurgesmax.getValue() - healsurgesused.getValue());]]
	end
end--[[}}}]]

function linkPCFields(src)--[[{{{]]
	local src = link.getTargetDatabaseNode();
    Debug.console(src);
	if src then
		name.setLink(src.createChild("name", "string"), true);
		wounds.setLink(src.createChild("health.wounds", "number"));
--		wounds.setReadOnly(true);
		damagetaken.setLink(src.createChild("health.damage", "number"));
		blooddamage.setLink(src.createChild("health.bmdamage.base", "number"));
		--totaldamage.setLink(src.createChild("totdamage", "number"));
		init.setLink(src.createChild("init.step.total", "number"), true);
		init.setReadOnly(true);
        
		--mysticarmor.setLink(src.createChild("armor.mystic.total", "number"));
		--mysticarmor.setReadOnly(true);
		--physicalarmor.setLink(src.createChild("armor.physical.total", "number"));
		--physicalarmor.setReadOnly(true);

		physicaldef.setLink(src.createChild("defense.physical.total", "number"), true);
		physicaldef.setReadOnly(true);
		spelldef.setLink(src.createChild("defense.spell.total", "number"), true);
		spelldef.setReadOnly(true);
		socialdef.setLink(src.createChild("defense.social.total", "number"), true);
		socialdef.setReadOnly(true);

		unconrating.setLink(src.createChild("health.unconscious.total", "number"), true);
		unconrating.setReadOnly(true);
		deathrating.setLink(src.createChild("health.death.total", "number"), true);
		deathrating.setReadOnly(true);
		woundthresh.setLink(src.createChild("health.woundthreshold.total", "number"), true);
		woundthresh.setReadOnly(true);
		
		rectsts.setLink(src.createChild("health.recovery.current.total", "number"), true);
		rectsts.setReadOnly(true);
		recstep.setLink(src.createChild("recovery.step.total", "number"), true);
		recstep.setReadOnly(true);

		--numattacks.setReadOnly(true);
		--numattackslabel.setReadOnly(true);
		--attackstep.setReadOnly(true);
		--attacksteplabel.setReadOnly(true);
		--damagestep.setReadOnly(true);
		--damagesteplabel.setReadOnly(true);
		--numspells.setReadOnly(true);
		--numspellslabel.setReadOnly(true);
		--spellstep.setReadOnly(true);
		--spellsteplabel.setReadOnly(true);
		--effectstep.setReadOnly(true);
		--effectsteplabel.setReadOnly(true);

		--combatmv.setLink(src.createChild(src, "move.combat", "number"), true);
		--fullmv.setLink(src.createChild(src, "move.full", "number"), true);

	end
end--[[}}}]]

--
-- SECTION VISIBILITY FUNCTIONS
--

function setTargetingVisible()
	local v = false;
	if activatetargeting.getValue() == 1 then
		v = true;
	end

	targetingicon.setVisible(v);	
	sub_targeting.setVisible(v);	
	frame_targeting.setVisible(v);
	target_summary.onTargetsChanged();
end

function setActiveVisible(v)--[[{{{]]
	local v = false;
	if activateactive.getValue() == 1 then
		v = true;
	end
	
	activeon = v;
	activeicon.setVisible(v);
    frame_active.setVisible(v);

	--effectstep.setVisible(v);
	--effectsteplabel.setVisible(v);
	--spellstep.setVisible(v);
	--spellsteplabel.setVisible(v);
	--numspells.setVisible(v);
	--numspellslabel.setVisible(v);
	--damagestep.setVisible(v);
	--damagesteplabel.setVisible(v);
	--attackstep.setVisible(v);
	--attacksteplabel.setVisible(v);
	--numattacks.setVisible(v);
	--numattackslabel.setVisible(v);
	init.setVisible(v);
	initlabel.setVisible(v);
	--attacks.setVisible(v);
	--atklabel.setVisible(v);
end--[[}}}]]

function setDefensiveVisible(v)
	local v = false;
	if activatedefensive.getValue() == 1 then
		v = true;
	end
	
	defensiveicon.setVisible(v);
    frame_defensive.setVisible(v);

	physicaldef.setVisible(v);
	physicaldeflabel.setVisible(v);
	spelldef.setVisible(v);
	spelldeflabel.setVisible(v);
	socialdef.setVisible(v);
	socialdeflabel.setVisible(v);

	deathrating.setVisible(v);
	deathratinglabel.setVisible(v);
	woundthresh.setVisible(v);
	woundthreshlabel.setVisible(v);
	unconrating.setVisible(v);
	unconratinglabel.setVisible(v);

	rectsts.setVisible(v);
	rectstslabel.setVisible(v);
	recstep.setVisible(v);
	recsteplabel.setVisible(v);

end
	
function setSpacingVisible()
	local v = false;
	if activatespacing.getValue() == 1 then
		v = true;
	end

	spacingicon.setVisible(v);
	
	space.setVisible(v);
	spacelabel.setVisible(v);
	reach.setVisible(v);
	reachlabel.setVisible(v);
	
	frame_spacing.setVisible(v);
end

function setEffectsVisible()
	local v = false;
	if activateeffects.getValue() == 1 then
		v = true;
	end
	
	effecticon.setVisible(v);
	
	effects.setVisible(v);
	effects_iadd.setVisible(v);
	for _,w in pairs(effects.getWindows()) do
		w.idelete.setValue(0);
	end

	frame_effects.setVisible(v);

	effect_summary.onEffectsChanged();
end


function getStepInit(step)
        if step > 0 then
                print("Init step " .. step);
                dice, modifier = Step.getStepDice(step);
                total = modifier;
                for k, v in ipairs(dice) do
                        repeat
                                roll = math.random(string.sub(v,2));
                                total = total + roll;
                        until roll ~= tonumber(string.sub(v,2));
                end
                return total;
        else
                return 0;
        end
end

