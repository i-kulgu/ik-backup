local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('ik-backup:server:getCharName', function(source, cb)
	local src = source
	local Player =  QBCore.Functions.GetPlayer(src)
	local fn = Player.PlayerData.charinfo.firstname
	local ln = Player.PlayerData.charinfo.lastname
	if Player ~= nil then
		cb(fn, ln)
	else
		cb(nil)
	end
end)

RegisterCommand('backup', function(source, args)
	local src = source
	local Player =  QBCore.Functions.GetPlayer(src)
	local Job = Player.PlayerData.job.name
	local level   = args[1]
	local radiocount = Player.Functions.GetItemByName("radio").amount
	if Job == 'police' or Job == 'sheriff' then
		if radiocount > 0 then
			if level ~= nil and level == '1' or level == '2' or level == '3' then
				TriggerClientEvent('ik-backup:client:getCoords', src, level)
			else
				TriggerClientEvent('QBCore:Notify', src, "Code can't be empty! /backup 1 / 2 / 3", 'error', 3000)
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You don't have a radio on you!", 'error', 3000)
		end
	end
end)

RegisterNetEvent('ik-backup:server:alertCops', function(coords, level, name)
	local players = QBCore.Functions.GetQBPlayers()
	local message = ""
	local title = ""
	if level == 1 then
		title = "Backup Needed"
		message = "Officier "..name.." needs immediate backup at his location!"
	elseif level == 2 then
		title = "Shots Fired"
		message = "There is shootout at the location of officier "..name
	elseif level == 3 then
		title = "Officier Down"
		message = "Officier "..name.." is down and needs help!"
	end
	for _, v in pairs(players) do
        if v and v.PlayerData.job.name == 'police' and v.PlayerData.job.onduty then
            local alertData = {title = title, coords = {x = coords.x, y = coords.y, z = coords.z}, description = message}
            TriggerClientEvent("qb-phone:client:addPoliceAlert", v.PlayerData.source, alertData)
            TriggerClientEvent('police:client:policeAlert', v.PlayerData.source, coords, message)
        end
    end
end)