local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/backup', 'Call the officers for help.', {
    	{ name="Backup Call", help="1, 2, 3" }
	})
end)

RegisterNetEvent('ik-backup:client:getCoords', function(level)
	local ped = PlayerPedId()
	local pCoords = GetEntityCoords(ped)
	QBCore.Functions.TriggerCallback('ik-backup:server:getCharName', function(fname, lname)
		if fname ~= nil and lname ~= nil then
			name = fname..' '..lname
			TriggerServerEvent('ik-backup:server:alertCops', pCoords, level, name)
		end
	end)
end)