-- Halvkyrie's STAND Toolbox
-- Source: https://github.com/Halvkyrie/Halvkyrie-STAND-Toolbox
-- Don't steal thanks

--[[
    THANK YOU!
    to a lot of people, for making scripts that i can look at at learn from.
    Particularly: IceDoomFist, Lance, CocoW, Jackz, and more. I'm sorry if i forgot any
]]--


-- Requirements 
util.require_natives(1651208000)

-- Script Meta

local SCRIPT_NAME = "Halvkyrie's Toolbox"
local SCRIPT_SHORT_NAME = "HalvTools"
local SCRIPT_VERSION = "0.1.4"
local SCRIPT_SOURCE = "https://github.com/Halvkyrie/Halvkyrie-STAND-Toolbox"

-- Script Meta Menu

local SCRIPT_META_LIST = menu.list(menu.my_root(), "About this Script")
menu.divider(SCRIPT_META_LIST, SCRIPT_NAME .. " Version " .. SCRIPT_VERSION)
menu.divider(SCRIPT_META_LIST, "By Halvkyrie")
menu.hyperlink(SCRIPT_META_LIST, "Source Code on GitHub", SCRIPT_SOURCE, "View the source code on GitHub")
menu.hyperlink(SCRIPT_META_LIST, "My Page", "https://halvkyrie.github.io/", "Don't click it if you hate comic sans")


-- Globals things. Oh boy. Thanks IceDoomFist

function SET_INT_GLOBAL(Global, Value)
    memory.write_int(memory.script_global(Global), Value)
end
function SET_FLOAT_GLOBAL(Global, Value)
    memory.write_float(memory.script_global(Global), Value)
end
-- The rest

drawScriptMenu = function()
    menu.divider(menu.my_root(), "Halvkyrie's Toolbox")

end

drawScriptMenu()

-- UI / HUD Menu

local UI_MENU_LIST = menu.list(menu.my_root(), "UI and HUD")
local UI_MENU_DEBUG_LIST = menu.list(UI_MENU_LIST, "[DEBUG] Options")

menu.action(UI_MENU_DEBUG_LIST, "[DEBUG] Help msg check", {"checkhelpmsg"}, "", function()

    local help_msg_on_screen = HUD.IS_HELP_MESSAGE_ON_SCREEN()
    local help_msg_displayed = HUD.IS_HELP_MESSAGE_BEING_DISPLAYED()

    if help_msg_on_screen == true then
        util.toast("Help Message is on screen")
    else
        util.toast("Help Message is not on screen")
    end
    
    if help_msg_displayed == true then
        util.toast("Help Message is being displayed")
    else
        util.toast("Help Message is not being displayed")
    end

end)

menu.action(UI_MENU_LIST, "Clear help message", {"clearhelp"}, "", function()
    HUD.CLEAR_HELP()
end)


-- Services and Vehicles

local SERVICE_MENU_LIST = menu.list(menu.my_root(), "Services and Vehicles")
local SERVICE_MENU_VEHICLES_LIST = menu.list(SERVICE_MENU_LIST, "Vehicles")
local SERVICE_MENU_VEHICLES_RETURN_LIST = menu.list(SERVICE_MENU_VEHICLES_LIST, "Return Vehicle")

--[[ Need to figure this shit out :(
menu.action(SERVICE_MENU_VEHICLES_LIST, "Request Sparrow", {"reqsparrow"}, "Requests Sparrow via Kosatka", function()
    SET_INT_GLOBAL(??)
end)

menu.action(SERVICE_MENU_VEHICLES_RETURN_LIST, "Return Moon Pool Vehicle", {"retmpveh"}, "Returns current Moon Pool vehicle to Kosatka", function()
    SET_INT_GLOBAL(??)
end)]]--

-- Equipment Menu

local EQUIPMENT_MENU_LIST = menu.list(menu.my_root(), "Equipment")
local EQUIPMENT_MENU_HELMET_LIST = menu.list(EQUIPMENT_MENU_LIST, "Helmet")

-- Helmet stuff

menu.action(EQUIPMENT_MENU_HELMET_LIST, "Equip Motorbike Helmet", {"mchelmon"}, "Equips your Motorcycle Helmet. NOTE: This doesn't fetch the textureIndex for the helmet properly, so it will use the default texture for that helmet type. i think.", function()
    local HF_MC_Helmet = 4096
    local player_ped = players.user_ped()
    local player_has_helmet = PED.IS_PED_WEARING_HELMET(player_ped)
    if player_has_helmet == true then
        util.toast("You are already wearing a helmet?")
    else
        PED.GIVE_PED_HELMET(player_ped, false, HF_MC_Helmet)
        util.toast("Equipped Motorcycle Helmet (Hopefully)")
    end
end)

menu.action(EQUIPMENT_MENU_HELMET_LIST, "Unequip Helmet", {"helmoff"}, "Unequips any current helmet", function()
    local player_ped = players.user_ped()
    local player_has_helmet = PED.IS_PED_WEARING_HELMET(player_ped)
    local remove_instant = false
    if player_has_helmet == true then
        PED.REMOVE_PED_HELMET(player_ped, remove_instant)
        util.toast("Removed Helmet")
    else
        util.toast("You are not wearing a helmet. None to unequip")
    end
end)

-- Player Options

players.add_command_hook(function(player_id)
    menu.divider(menu.player_root(player_id), "Halvkyrie's Toolbox")

    -- Player Option Categories

    local PLAYER_OPTIONS_WEAPONS_LIST = menu.list(menu.player_root(player_id), "Weapons")
    local PLAYER_OPTIONS_WEAPONS_DEBUG_LIST = menu.list(PLAYER_OPTIONS_WEAPONS_LIST, "[DEBUG OPTIONS]")
    local PLAYER_OPTIONS_WEAPONS_ADD_LIST = menu.list(PLAYER_OPTIONS_WEAPONS_LIST, "Add/Give Options")
    local PLAYER_OPTIONS_WEAPONS_REMOVE_LIST = menu.list(PLAYER_OPTIONS_WEAPONS_LIST, "Remove Options")

    menu.action(PLAYER_OPTIONS_WEAPONS_DEBUG_LIST, "[DEBUG] Get current weapon hash", {"getweaponhash"}, "", function()
        local player_ped = PLAYER.GET_PLAYER_PED(player_id)
        local player_ped_weapon = WEAPON.GET_SELECTED_PED_WEAPON(player_ped)
        util.toast("Current weapon hash is ".. tostring(player_ped_weapon))
    end)
    menu.action(PLAYER_OPTIONS_WEAPONS_DEBUG_LIST, "[DEBUG] Remove Hazardous Jerry Can ammo", {"removehazardcanammo"}, "", function()
        local player_ped = PLAYER.GET_PLAYER_PED(player_id)
        local hazardcan_hash = util.joaat("weapon_hazardcan")
        WEAPON.SET_PED_AMMO(player_ped, hazardcan_hash, 0)
    end)
    menu.action(PLAYER_OPTIONS_WEAPONS_DEBUG_LIST, "[DEBUG] Remove all current weapon ammo", {"removeammo"}, "", function()
        local player_ped = PLAYER.GET_PLAYER_PED(player_id)
        local current_weapon_hash = WEAPON.GET_SELECTED_PED_WEAPON(player_ped)
        WEAPON.SET_PED_AMMO(player_ped, current_weapon_hash, 0)
    end)
    menu.action(PLAYER_OPTIONS_WEAPONS_DEBUG_LIST, "[DEBUG] Remove Hazardous Jerry Can", {"removehazardcan"}, "", function()
        local player_ped = PLAYER.GET_PLAYER_PED(player_id)
        local hazardcan_hash = util.joaat("weapon_hazardcan")
        WEAPON.REMOVE_WEAPON_FROM_PED(player_ped, hazardcan_hash)
        util.toast("Player ID is ".. tostring(player_id))
        util.toast("Hazardcan hash is ".. tostring(hazardcan_hash))
    end)

    menu.action(PLAYER_OPTIONS_WEAPONS_REMOVE_LIST, "Remove current weapon", {"removecurrentweapon"}, "", function()
        local player_ped = PLAYER.GET_PLAYER_PED(player_id)
        local current_weapon_hash = WEAPON.GET_SELECTED_PED_WEAPON(player_ped)
        util.toast("Current weapon hash is ".. tostring(current_weapon_hash))
        WEAPON.REMOVE_WEAPON_FROM_PED(player_ped, current_weapon_hash)
    end)

    menu.action(PLAYER_OPTIONS_WEAPONS_ADD_LIST, "Copy your current weapon to them", {"givemyweapon"}, "Checks your currently held weapon and gives the same weapon to them", function()
        local target_player_ped = PLAYER.GET_PLAYER_PED(player_id)
        local source_player_ped = players.user_ped()
        local source_player_weapon = WEAPON.GET_SELECTED_PED_WEAPON(source_player_ped)
        local ammo_count = 9999
        WEAPON.GIVE_WEAPON_TO_PED(target_player_ped, source_player_weapon, ammmo_count, false, true)
    end)

    
end)


-- Make the menu do the thing



while true do
    util.yield()
end