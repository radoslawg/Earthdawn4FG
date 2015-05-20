-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

function onInit()
    local msg = {font = "emotefont", icon="portrait_ruleset_token"};
    msg.text = "CoreRPG v3.0.10 ruleset for Fantasy Grounds.\rCopyright 2013 Smiteworks USA, LLC."
 	ChatManager.registerLaunchMessage(msg);
	
	Interface.onDesktopInit = onDesktopInit;

	registerPublicNodes();
    
	buildDesktop();
end

function onDesktopInit()
	if not User.isLocal() and not User.isHost() then
		Interface.openWindow("charselect_client", "", true);
	end
end

function registerPublicNodes()
	if User.isHost() then
		DB.createNode("options").setPublic(true);
		DB.createNode("partysheet").setPublic(false);
		DB.createNode("calendar").setPublic(true);
		DB.createNode("combattracker").setPublic(true);
		DB.createNode("modifiers").setPublic(true);
		DB.createNode("effects").setPublic(true);
	end
end

function onInit()
	if User.isLocal() then
		DesktopManager.registerStackShortcut2("button_characters", "button_characters_down", "Characters", "identityselection");
		DesktopManager.registerStackShortcut2("button_pointer", "button_pointer_down", "Colors", "pointerselection");
		DesktopManager.registerStackShortcut2("button_portraits", "button_portraits_down", "Portraits", "portraitselection");
		DesktopManager.registerStackShortcut2("button_modules", "button_modules_down", "Modules", "moduleselection");
		DesktopManager.registerDockShortcut2("button_library", "button_library_down", "Library", "library");
    
	elseif User.isHost() then
        DesktopManager.registerStackShortcut2("button_light", "button_light_down", "Lighting", "lightingselection");
        DesktopManager.registerStackShortcut2("button_color", "button_color_down", "sidebar_tooltip_colors", "pointerselection");
        DesktopManager.registerStackShortcut2("button_ct", "button_ct_down", "sidebar_tooltip_ct", "combattracker_host", "combattracker");
        DesktopManager.registerStackShortcut2("button_modifiers", "button_modifiers_down", "sidebar_tooltip_modifiers", "modifiers", "modifiers");
        DesktopManager.registerStackShortcut2("button_effects", "button_effects_down", "sidebar_tooltip_effects", "effectlist", "effects");
        DesktopManager.registerStackShortcut2("button_options", "button_options_down", "sidebar_tooltip_options", "options");
		DesktopManager.registerStackShortcut2("button_calendar", "button_calendar_down", "sidebar_tooltip_calendar", "calendar", "calendar");		
        
        DesktopManager.registerDockShortcut2("button_characters", "button_characters_down", "sidebar_tooltip_character", "charselect_host", "charsheet");
        DesktopManager.registerDockShortcut2("button_book", "button_book_down", "sidebar_tooltip_story", "encounterlist", "encounter");
        DesktopManager.registerDockShortcut2("button_maps", "button_maps_down", "sidebar_tooltip_image", "imagelist", "image");
        DesktopManager.registerDockShortcut2("button_people", "button_people_down", "sidebar_tooltip_npc", "npclist", "npc");
        DesktopManager.registerDockShortcut2("button_items", "button_items_down", "sidebar_tooltip_item", "itemlist", "item");
        DesktopManager.registerDockShortcut2("button_notes", "button_notes_down", "sidebar_tooltip_note", "notelist", "notes");
        DesktopManager.registerDockShortcut2("button_library", "button_library_down", "sidebar_tooltip_library", "library");
        
        DesktopManager.registerDockShortcut2("button_tokencase", "button_tokencase_down", "sidebar_tooltip_token", "tokenbag", nil, true);

    else
		DesktopManager.registerStackShortcut2("button_ct", "button_ct_down", "sidebar_tooltip_ct", "combattracker_client", "combattracker");
--		DesktopManager.registerStackShortcut2("button_partysheet", "button_partysheet_down", "sidebar_tooltip_ps", "partysheet_client", "partysheet");

		-- DesktopManager.registerStackShortcut2("button_tables", "button_tables_down", "sidebar_tooltip_tables", "tablelist", "tables");
		DesktopManager.registerStackShortcut2("button_calendar", "button_calendar_down", "sidebar_tooltip_calendar", "calendar", "calendar");

		DesktopManager.registerStackShortcut2("button_color", "button_color_down", "sidebar_tooltip_colors", "pointerselection");
		DesktopManager.registerStackShortcut2("button_options", "button_options_down", "sidebar_tooltip_options", "options");

		DesktopManager.registerStackShortcut2("button_modifiers", "button_modifiers_down", "sidebar_tooltip_modifiers", "modifiers", "modifiers");
		--DesktopManager.registerStackShortcut2("button_effects", "button_effects_down", "sidebar_tooltip_effects", "effectlist", "effects");

		DesktopManager.registerDockShortcut2("button_characters", "button_characters_down", "sidebar_tooltip_character", "charselect_client");
		--DesktopManager.registerDockShortcut2("button_book", "button_book_down", "sidebar_tooltip_story", "encounterlist", "encounter");
		DesktopManager.registerDockShortcut2("button_maps", "button_maps_down", "sidebar_tooltip_image", "imagelist", "image");
		DesktopManager.registerDockShortcut2("button_people", "button_people_down", "sidebar_tooltip_npc", "npclist", "npc");
		DesktopManager.registerDockShortcut2("button_items", "button_items_down", "sidebar_tooltip_item", "itemlist", "item");
		DesktopManager.registerDockShortcut2("button_notes", "button_notes_down", "sidebar_tooltip_note", "notelist", "notes");
		DesktopManager.registerDockShortcut2("button_library", "button_library_down", "sidebar_tooltip_library", "library");
		
		--DesktopManager.registerDockShortcut2("button_tokencase", "button_tokencase_down", "sidebar_tooltip_token", "tokenbag", nil, true);

	end
end
