ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local sellane={}
local rahat={}
local valmisk = false

MySQL.ready(function()
	MySQL.Async.fetchAll("SELECT * FROM `alueet`",
	{},
	function(result)
	
		sellane = {
		{omistaja = result[1]['omistaja']},
		{omistaja = result[2]['omistaja']},
		{omistaja = result[3]['omistaja']},
		{omistaja = result[4]['omistaja']},
		{omistaja = result[5]['omistaja']},
		{omistaja = result[6]['omistaja']},
		{omistaja = result[7]['omistaja']},
		{omistaja = result[8]['omistaja']},
		{omistaja = result[9]['omistaja']}
		}
	end)
	valmisk = true
end)

Citizen.CreateThread(function()
  while true do
	if valmisk then
		MySQL.Async.fetchAll("SELECT * FROM `alueet`",
		{},
		function(result)
		
			rahat = {
			{rahamaara = result[1]['rahamaara']},
			{rahamaara = result[2]['rahamaara']},
			{rahamaara = result[3]['rahamaara']},
			{rahamaara = result[4]['rahamaara']},
			{rahamaara = result[5]['rahamaara']},
			{rahamaara = result[6]['rahamaara']},
			{rahamaara = result[7]['rahamaara']},
			{rahamaara = result[8]['rahamaara']},
			{rahamaara = result[9]['rahamaara']}
			}
		end)
		Citizen.Wait(1000)
		for i=1, 9 do
			local rahattiskiin = rahat[i].rahamaara + 250
			MySQL.Async.execute("UPDATE alueet SET `rahamaara` = @rahoja WHERE alue = @numero",{["@numero"] = i,["@rahoja"] = rahattiskiin})
		end
		Citizen.Wait(10 * 60000)
		end
	Citizen.Wait(1)
	end
end)

RegisterServerEvent('kxl-jengialueet:toofar')
AddEventHandler('kxl-jengialueet:toofar', function(alue)
	TriggerClientEvent('kxl-jengialueet:toofarlocal', source)
	local xPlayers = ESX.GetPlayers()
	if sellane[alue].omistaja ~= "" then
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if sellane[alue].omistaja == xPlayer.job.name then
				TriggerClientEvent('kxl-jengialueet:killblip', xPlayers[i], alue)
				TriggerClientEvent('esx_jengialueet:valloitusilmoitus', xPlayers[i], alue)
			end
		end
	end
end)



RegisterServerEvent('kxl-jengialueet:mene')
AddEventHandler('kxl-jengialueet:mene', function(alue)
	TriggerClientEvent('kxl-jengialueet:toofarlocal', source)
	local xPlayers = ESX.GetPlayers()
	if sellane[tyo].omistaja ~= "" then
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if sellane[tyo].omistaja == xPlayer.job.name then
				TriggerClientEvent('kxl-jengialueet:killblip1', xPlayers[i], alue)
			end
		end
	end
end)


RegisterServerEvent('kxl-jengialueet:rostoohi')
AddEventHandler('kxl-jengialueet:rostoohi', function(tyo)
	TriggerClientEvent('kxl-jengialueet:claimcomplete', source)
	local homo = sellane[tyo].omistaja
	local xPlayer = ESX.GetPlayerFromId(source)
	local tyoukko = xPlayer.job.name
	local xPlayers = ESX.GetPlayers()
	for i = 1, #Jobit, 1 do
		if xPlayer.job.name == Jobit[i] then
			MySQL.Async.execute("UPDATE alueet SET `omistaja` = @ukontyo WHERE alue = @tyo",{['@tyo'] = tyo, ['@ukontyo']    = xPlayer.job.name})
			MySQL.Async.fetchAll("SELECT * FROM `alueet`",
			{},
			function(result)
			
				sellane = {
				{omistaja = result[1]['omistaja']},
				{omistaja = result[2]['omistaja']},
				{omistaja = result[3]['omistaja']},
				{omistaja = result[4]['omistaja']},
				{omistaja = result[5]['omistaja']},
				{omistaja = result[6]['omistaja']},
				{omistaja = result[7]['omistaja']},
				{omistaja = result[8]['omistaja']},
				{omistaja = result[9]['omistaja']}
				}
			end)
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if tyoukko == xPlayer.job.name then
					TriggerClientEvent('kxl-jengialueet:muille', xPlayers[i], tyo)
				end
			end
	if homo ~= "" then
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if homo == xPlayer.job.name then
				TriggerClientEvent('kxl-jengialueet:killblip1', xPlayers[i], tyo)
				TriggerClientEvent('esx_jengialueet:valloitusilmoitus', xPlayers[i], tyo)	
			end
		end
	end
end
	end

end)


RegisterServerEvent('kxl-jengialueet:fetchmestat')
AddEventHandler('kxl-jengialueet:fetchmestat', function()
	TriggerClientEvent('kxl-jengialueet:mestat', source, sellane)
end)
RegisterServerEvent('kxl-jengialueet:claim')
AddEventHandler('kxl-jengialueet:claim', function(k)
	local source = source

	local xPlayer = ESX.GetPlayerFromId(source)
	if sellane[k].omistaja == xPlayer.job.name then
		MySQL.Async.fetchAll("SELECT * FROM `alueet`",
		{},
		function(result)
		
			rahat = {
			{rahamaara = result[1]['rahamaara']},
			{rahamaara = result[2]['rahamaara']},
			{rahamaara = result[3]['rahamaara']},
			{rahamaara = result[4]['rahamaara']},
			{rahamaara = result[5]['rahamaara']},
			{rahamaara = result[6]['rahamaara']},
			{rahamaara = result[7]['rahamaara']},
			{rahamaara = result[8]['rahamaara']},
			{rahamaara = result[9]['rahamaara']}
			}
		end)
		Citizen.Wait(1000)
		xPlayer.addAccountMoney('black_money', tonumber(rahat[k].rahamaara))
		MySQL.Async.execute("UPDATE alueet SET `rahamaara` = @rahoja WHERE alue = @numero",{["@numero"] = k,["@rahoja"] = 0})

	else
		local xPlayers = ESX.GetPlayers()
		local cops = 0
		local lolli = 0




	if Areas[k] then
		local store = Areas[k]

		if (os.time() - store.lastRobbed) < 1800 and store.lastRobbed ~= 0 then
			TriggerClientEvent('esx:showNotification', source, "Alue on vallattu äskettäin! Yritä uudelleen joskus!")
			return
		end

	
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
					cops = cops + 1
			end
		end
		if sellane[k].omistaja ~= "" then
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if sellane[k].omistaja == xPlayer.job.name then
					lolli = lolli + 1
				end
			end
		end
		if cops >= 0 then
			if lolli >= 3 or sellane[k].omistaja == "" then
				TriggerClientEvent("kxl-jengialueet:starttimer", source)
				TriggerClientEvent("kxl-jengialueet:currentlyclaiming", source, k)
				Areas[k].lastRobbed = os.time() 
				if sellane[k].omistaja ~= "" then
					for i=1, #xPlayers, 1 do
						local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
						if sellane[k].omistaja == xPlayer.job.name then	
							TriggerClientEvent('kxl-jengialueet:setblip', xPlayers[i], k)
							TriggerClientEvent("esx_jengialueet:valloitusilmoitus", xPlayers[i], k)
							Areas[k].lastRobbed = os.time()
						end
					end
				end
			else
				
				TriggerClientEvent('esx:showNotification', source, "Kaupungissa pitää olla vähintään ~r~3 alueen omistajaa~s~ paikalla valtauksen aloitukseen.")
			end
		else
		
             TriggerClientEvent('esx:showNotification', source, "Kaupungissa pitää olla vähintään ~b~0 poliisia~s~ paikalla valtauksen aloitukseen.")
			end
		else
			TriggerClientEvent('esx:showNotification', source, "Alue on vallattu äskettäin! Yritä uudelleen joskus!")
		
		end
	end
end)
