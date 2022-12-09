-- Halvkyrie's STAND Toolbox
-- Source: https://github.com/Halvkyrie/Halvkyrie-STAND-Toolbox
-- Don't steal thanks

-- Requirements 
util.require_natives(1651208000)

-- Script Meta

local SCRIPT_NAME = "Halvkyrie's Toolbox"
local SCRIPT_SHORT_NAME = "HalvTools"
local SCRIPT_VERSION = "0.1"
local SCRIPT_SOURCE = "https://github.com/Halvkyrie/Halvkyrie-STAND-Toolbox"

-- Script Meta Menu

local SCRIPT_META_LIST = menu.list(menu.my_root(), "About this Script")
menu.divider(SCRIPT_META_LIST, SCRIPT_NAME .. " Version " .. SCRIPT_VERSION)
menu.divider(SCRIPT_META_LIST, "By Halvkyrie")
menu.hyperlink(SCRIPT_META_LIST, "Source Code on GitHub", SCRIPT_SOURCE, "View the source code on GitHub")
menu.hyperlink(SCRIPT_META_LIST, "My Page", "https://halvkyrie.github.io/", "Don't click it if you hate comic sans")

-- The rest

drawScriptMenu = function()
    menu.divider(menu.my_root(), "Halvkyrie's Toolbox")

end

drawScriptMenu()


-- Equipment Menu

local EQUIPMENT_MENU_LIST = menu.list(menu.my_root(), "Equipment")

local EQUIPMENT_MENU_HELMET_LIST = menu.list(EQUIPMENT_MENU_LIST, "Helmet")

-- Helmet stuff

menu.action(EQUIPMENT_MENU_HELMET_LIST, "Equip Motorbike Helmet", {"mchelmon"}, "Equips your Motorcycle Helmet", function()
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

    -- Weapons Debug

    local PLAYER_OPTIONS_WEAPONS_DEBUG_LIST = menu.list(PLAYER_OPTIONS_WEAPONS_LIST, "[DEBUG OPTIONS]")

    menu.action(PLAYER_OPTIONS_WEAPONS_DEBUG_LIST, "[DEBUG] Get current weapon hash", {"getweaponhash"}, "", function()
        local player_ped = PLAYER.GET_PLAYER_PED(player_id)
        local player_ped_weapon = WEAPON.GET_SELECTED_PED_WEAPON(player_ped)
        util.toast("Current weapon hash is ".. tostring(player_ped_weapon))
    end, nil, nil, COMMANDPERM_FRIENDLY)

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
        
    
    menu.action(PLAYER_OPTIONS_WEAPONS_LIST, "Remove Hazardous Jerry Can", {"removehazardcan"}, "", function()
        local player_ped = PLAYER.GET_PLAYER_PED(player_id)
        local hazardcan_hash = util.joaat("weapon_hazardcan")
        WEAPON.REMOVE_WEAPON_FROM_PED(player_ped, hazardcan_hash)
        util.toast("Player ID is ".. tostring(player_id))
        util.toast("Hazardcan hash is ".. tostring(hazardcan_hash))
    end, nil, nil, COMMANDPERM_FRIENDLY)

    menu.action(PLAYER_OPTIONS_WEAPONS_LIST, "Remove current weapon", {"removecurrentweapon"}, "", function()
        local player_ped = PLAYER.GET_PLAYER_PED(player_id)
        local current_weapon_hash = WEAPON.GET_SELECTED_PED_WEAPON(player_ped)
        util.toast("Current weapon hash is ".. tostring(current_weapon_hash))
        WEAPON.REMOVE_WEAPON_FROM_PED(player_ped, current_weapon_hash)
    end, nil, nil, COMMANDPERM_FRIENDLY)
    
end)


-- Make the menu do the thing



while true do
    util.yield()
end