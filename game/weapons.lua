local weapons = {
    names = {
        [0] = "Fist",
        [1] = "Brass Knuckles",
        [2] = "Golf Club",
        [3] = "Nightstick",
        [4] = "Knife",
        [5] = "Baseball Bat",
        [6] = "Shovel",
        [7] = "Pool Cue",
        [8] = "Katana",
        [9] = "Chainsaw",
        [10] = "Purple Dildo",
        [11] = "Dildo",
        [12] = "Vibrator",
        [13] = "Silver Vibrator",
        [14] = "Flowers",
        [15] = "Cane",
        [16] = "Grenade",
        [17] = "Teargas",
        [18] = "Molotov Cocktail",
        [22] = "Pistol",
        [23] = "Silenced Pistol",
        [24] = "Desert Eagle",
        [25] = "Shotgun",
        [26] = "Sawn-off Shotgun",
        [27] = "SPAS-12",
        [28] = "Micro Uzi",
        [29] = "MP5",
        [30] = "AK-47",
        [31] = "M4",
        [32] = "Tec-9",
        [33] = "Country Rifle",
        [34] = "Sniper Rifle",
        [35] = "Rocket Launcher",
        [36] = "Heat-Seeking RPG",
        [37] = "Flamethrower",
        [38] = "Minigun",
        [39] = "Satchel Charge",
        [40] = "Detonator",
        [41] = "Spraycan",
        [42] = "Fire Extinguisher",
        [43] = "Camera",
        [44] = "Night Vision Goggles",
        [45] = "Thermal Goggles",
        [46] = "Parachute",
    },
    id = {
        FIST = 0,
        BRASSKNUCKLE = 1,
        GOLFCLUB = 2,
        NITESTICK = 3,
        KNIFE = 4,
        BASEBALLBAT = 5,
        SHOVEL = 6,
        POOLCUE = 7,
        KATANA = 8,
        CHAINSAW = 9,
        DILDO1 = 10,
        DILDO2 = 11,
        VIBE1 = 12,
        VIBE2 = 13,
        FLOWERS = 14,
        CANE = 15,
        GRENADE = 16,
        TEARGAS = 17,
        MOLOTOV = 18,
        COLT45 = 22,
        SILENCED = 23,
        DEAGLE = 24,
        SHOTGUN = 25,
        SAWNOFF = 26,
        SPAS12 = 27,
        MICRO_UZI = 28,
        MP5 = 29,
        AK47 = 30,
        M4 = 31,
        TEC9 = 32,
        COUNTRYRIFLE = 33,
        SNIPER = 34,
        ROCKETLAUNCHER = 35,
        HEATSEEKER = 36,
        FLAMETHROWER = 37,
        MINIGUN = 38,
        SATCHEL_CHARGE = 39,
        DETONATOR = 40,
        SPRAYCAN = 41,
        EXTINGUISHER = 42,
        CAMERA = 43,
        NIGHTVISION = 44,
        INFRARED = 45,
        PARACHUTE = 46,
    }
}

setmetatable(weapons.names, {
    __index = function(t, k)
        return "Unknown"
    end
})

setmetatable(weapons, {
    __index = function(t, k)
        if type(k) == 'number' then
            return weapons.names[k]
        end
        return weapons.id[k]
    end
})

return weapons
