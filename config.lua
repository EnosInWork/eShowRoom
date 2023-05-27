Config = {}

Config.Framework = "esx" -- esx = trigger / newEsx = export for legacy new version
Config.SharedObject = "esx:getSharedObject"

Config.Showrooms = {

    ["Bateaux"] = { -- Bateaux = catégorie de ton showroom
        --------------------
        ColorMenuR = 255, -- Bannière couleur R
        ColorMenuG = 255, -- Bannière couleur G
        ColorMenuB = 255, -- Bannière couleur B
        ColorMenuA = 150, -- Bannière couleur A
        MenuPositionX = 0, -- Bannière position X sur l'écran
        MenuPositionY = 0, -- Bannière position Y sur l'écran
        --------------------
        job = "boatdealer", -- job qui a accès au menu 
        --------------------
        Marker = {
            Type = 6, -- type du marker
            Color = {R = 255, G = 255, B = 255, A = 255}, -- color du marker
            Size =  {x = 1.0, y = 1.0, z = 1.0}, -- taille du marker
            DrawDistance = 10, -- Distance ou le marker est affiché
            DrawInteract = 1.5, -- Distance ou on peux interact avec le marker
        },
        --------------------
        rotateVehicle = false,  -- true = le véhicule tournera sur lui même / false = non
        --------------------
        Menu = vector3(954.15277099609,-155.47308349609,74.553916931152), -- menu du showroom
        --------------------
        ExpositionPosition = {
            -----------------------------------------------------------------------
            -- position = ou le véhicule seras positioné / vehicles = stockage des véhicules en expo, ne pas toucher.
            -----------------------------------------------------------------------
            {position = vector4(946.90972900391,-151.13523864746,73.539161682129, 236.65097045898), vehicles = {}}, 
            {position = vector4(944.69885253906,-154.67977905273,73.542823791504, 239.95260620117), vehicles = {}},
            {position = vector4(941.01629638672,-159.64959716797,73.526748657227, 245.64337158203), vehicles = {}},
            {position = vector4(949.46673583984,-144.58541870117,73.519866943359, 236.92681884766), vehicles = {}},
        },
    },

    --- Ajoutez vos showrooms ici en copiant celui bateau en modifiant ["Bateaux"] ligne 8, job, coordonnées menu/expo. Enjoy ! 

}
