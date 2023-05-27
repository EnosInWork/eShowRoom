if Config.Framework == "esx" then
    ESX = nil
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent(Config.SharedObject, function(obj) ESX = obj end)
            Citizen.Wait(100)
        end
        ESX.PlayerData = ESX.GetPlayerData()
    end)
elseif Config.Framework == "newEsx" then 
    ESX = exports["es_extended"]:getSharedObject()
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	ESX.PlayerData.job = job  
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

function ShowRoom(type)
    FreezeEntityPosition(PlayerPedId(), true)
    local showroom = Config.Showrooms[type]
    local ShowroomMain = RageUI.CreateMenu("ShowRoom", type)
    ShowroomMain:SetRectangleBanner(showroom.ColorMenuR, showroom.ColorMenuG, showroom.ColorMenuB, showroom.ColorMenuA)
    RageUI.Visible(ShowroomMain, not RageUI.Visible(ShowroomMain))
    while ShowroomMain do
        Citizen.Wait(0)
        RageUI.IsVisible(ShowroomMain, true, true, true, function()

            for i = 1, #showroom.ExpositionPosition do
                local exposition = showroom.ExpositionPosition[i]
                if #exposition.vehicles > 0 then 
                    RageUI.ButtonWithStyle("~r~Supprimer le " .. i, nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SuprVehicle(type, i)
                        end
                    end)
                else
                    RageUI.ButtonWithStyle("Emplacement " .. i, nil, {RightLabel = "Libre"}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            local modele = KeyboardInput("Entrez le modèle", "", 100)
                            SpawnVehicle(type, i, modele)
                        end
                    end)
                end
            end

        end, function()
        end)

        if not RageUI.Visible(ShowroomMain) then
            ShowroomMain = RMenu:DeleteType("ShowroomMain", true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

function SuprVehicle(type, index)
    local exposition = Config.Showrooms[type].ExpositionPosition[index]

    while #exposition.vehicles > 0 do
        local vehicle = exposition.vehicles[1]
        ESX.Game.DeleteVehicle(vehicle)
        table.remove(exposition.vehicles, 1)
    end
    
end

function SpawnVehicle(type, index, model)
    local showroom = Config.Showrooms[type]
    local exposition = Config.Showrooms[type].ExpositionPosition[index]

    local car = GetHashKey(model)

    if not IsModelInCdimage(car) then
        ESX.ShowNotification("~r~Modèle non valide!")
        return
    end

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local vehicle = CreateVehicle(car, exposition.position, true)
    FreezeEntityPosition(vehicle, true)
    SetVehicleDoorsLocked(vehicle, 4)
    SetEntityAsMissionEntity(vehicle, true, true)
    table.insert(exposition.vehicles, vehicle)

    if showroom.rotateVehicle then
        Citizen.CreateThread(function()
            while true do
                if DoesEntityExist(vehicle) then
                    local heading = GetEntityHeading(vehicle)
                    SetEntityHeading(vehicle, heading + 1.0)
                    Citizen.Wait(30)
                else
                    break
                end
            end
        end)
    end

end

Citizen.CreateThread(function()
    while true do
        local _Wait = 500
        local PlyID = GetPlayerPed(-1)
        local PlayerCoords = GetEntityCoords(PlyID, false)
        for showroomType, showroomConfig in pairs(Config.Showrooms) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == showroomConfig.job then
                local Dist = Vdist(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, showroomConfig.Menu.x, showroomConfig.Menu.y, showroomConfig.Menu.z)
                if Dist <= showroomConfig.Marker.DrawDistance then
                    _Wait = 0
                    DrawMarker(showroomConfig.Marker.Type, showroomConfig.Menu.x, showroomConfig.Menu.y, showroomConfig.Menu.z-0.99, nil, nil, nil, -90, nil, nil, showroomConfig.Marker.Size.x, showroomConfig.Marker.Size.y, showroomConfig.Marker.Size.z, showroomConfig.Marker.Color.R, showroomConfig.Marker.Color.G, showroomConfig.Marker.Color.B, showroomConfig.Marker.Color.A)
                end
                if Dist <= showroomConfig.Marker.DrawInteract then
                    _Wait = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le showroom")
                    if IsControlJustPressed(1,51) then
                        TypeShow = showroomType
                        ShowRoom(TypeShow)
                    end
                end
            end
        end
        Citizen.Wait(_Wait)   
    end
end)