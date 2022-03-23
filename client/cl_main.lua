ESX              = nil
local PlayerData = {}
local pizzaMakingIsStarted = false
local processOneIsDone = false
local processTwoIsDone = false
local processThreeIsDone = false
local processFourIsDone = false
local processFiveIsDone = false

Citizen.CreateThread(function()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) 
		ESX = obj 
	  end)
  
	  Citizen.Wait(0)
	end
  
	if ESX.IsPlayerLoaded() then
	  ESX.PlayerData = ESX.GetPlayerData()
	end
  
	while true do
	  Citizen.Wait(5)
  
	  if IsControlJustPressed(0, 167) then
		if PlayerData.job ~= nil and PlayerData.job.name == 'salims' then
		  F6MenuMadeByForceYeye()
		end
	  end
	end
  end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	Citizen.Wait(100)

	while true do
		local sleepThread = 500

		if PlayerData.job ~= nil and PlayerData.job.name == 'salims' then

			local player  = PlayerPedId()
			local pCoords = GetEntityCoords(player)
			local dist1   = #(pCoords - Config.StartMarker)
			local dist2	  = #(pCoords - Config.StashPos)
			local dist3	  = #(pCoords - Config.DrinkPosStorage)
			local dist4   = #(pCoords - Config.BuyDrinkPos)

			if dist1 >= 1.5 and dist1 <= 6 then
				sleepThread = 5
				if not pizzaMakingIsStarted then
					DrawMarker(6, Config.StartMarker, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				end
			end

			if dist1 < 1.5 then
				sleepThread = 5
				if not pizzaMakingIsStarted then
					ESX.ShowHelpNotification('~INPUT_PICKUP~ Gör en pizza')
					DrawMarker(6, Config.StartMarker, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
					if IsControlJustPressed(1, 38) then
						ChoosePizza()
					end
				end
			end

			if dist2 >= 1.5 and dist2 <= 6 then
				sleepThread = 5
				if not pizzaMakingIsStarted and exports['btrp_keysystem']:HasKey("Salims") then
					DrawMarker(6, Config.StashPos, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				end
			end

			if dist2 < 1.5 then
				sleepThread = 5
				if not pizzaMakingIsStarted and exports['btrp_keysystem']:HasKey("Salims") then
					ESX.ShowHelpNotification('~INPUT_PICKUP~ Öppna Pizza Förråd')
					DrawMarker(6, Config.StashPos, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
					if IsControlJustPressed(1, 38) then
						exports["btrp_storage"]:OpenStorageUnit('Salims Bizzeria Pizza Förråd', 10000.0, 120.0)
					end
				end
			end

			if dist3 >= 1.5 and dist3 <= 6 then
				sleepThread = 5
				if not pizzaMakingIsStarted and exports['btrp_keysystem']:HasKey("Salims") then
					DrawMarker(6, Config.DrinkPosStorage, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				end
			end

			if dist3 < 1.5 then
				sleepThread = 5
				if not pizzaMakingIsStarted and exports['btrp_keysystem']:HasKey("Salims") then
					ESX.ShowHelpNotification('~INPUT_PICKUP~ Öppna drink förråd')
					DrawMarker(6, Config.DrinkPosStorage, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
					if IsControlJustPressed(1, 38) then
						exports["btrp_storage"]:OpenStorageUnit('Salims Bizzeria Drink Förråd', 10000.0, 120.0)
					end
				end
			end

			if dist4 >= 1.5 and dist4 <= 6 then
				sleepThread = 5
				if not pizzaMakingIsStarted and exports['btrp_keysystem']:HasKey("Salims") then
					DrawMarker(6, Config.BuyDrinkPos, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				end
			end

			if dist4 < 1.5 then
				sleepThread = 5
				if not pizzaMakingIsStarted and exports['btrp_keysystem']:HasKey("Salims") then
					ESX.ShowHelpNotification('~INPUT_PICKUP~ Öppna drink inköp')
					DrawMarker(6, Config.BuyDrinkPos, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
					if IsControlJustPressed(1, 38) then
						BuyDrink()
					end
				end
			end
		
		end
		Citizen.Wait(sleepThread)
	end
end)

RegisterNetEvent('force_pizzamakerPizzaMaker1')
AddEventHandler('force_pizzamakerPizzaMaker1', function(chosenPizza, prop_name1, prop_name2)
	while pizzaMakingIsStarted do
		Citizen.Wait(7)

	local player = PlayerPedId()
	local pCoords = GetEntityCoords(player)
	local dist1 = #(pCoords - Config.StartMarker)
	local distFirstProccesMarker = #(pCoords - Config.FirstProccesMarker)
	local distSecondProccesMarker = #(pCoords - Config.SecondProccesMarker)
	local distFourProccesMarker = #(pCoords - Config.FourProccesMarker)
	local distThirdProccesMarker = #(pCoords - Config.ThirdProcessMarker)
	local prop_name1 = prop_name1 or 'prop_pizza_box_02'
	local prop_name2 = prop_name2 or 'prop_cs_cardbox_01'

	if chosenPizza == 'kebab' then
		rewardItem = Config.KebabPizzaItem
	elseif chosenPizza == 'margarita' then
		rewardItem = Config.MargaritaPizzaItem
	elseif chosenPizza == 'capricciosa' then
		rewardItem = Config.CapricciosaPizzaItem
	elseif chosenPizza == 'lacostaspecial' then
		rewardItem = Config.LacostaspecialPizzaItem
	elseif chosenPizza == 'fyraostar' then
		rewardItem = Config.FyraostarPizzaItem
	elseif chosenPizza == 'robertosspecial' then
		rewardItem = Config.RobertosspecialPizzaItem
	elseif chosenPizza == 'kebabrulle' then
		rewardItem = Config.KebabrullePizzaItem
	end

		if dist1 < 20 then
			if not processOneIsDone then
				if distFirstProccesMarker >= 1.5 and distFirstProccesMarker <= 6 then
					DrawMarker(6, Config.FirstProccesMarker, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				end
				if not processOneIsDone then
					if distFirstProccesMarker < 1.5 then
						ESX.ShowHelpNotification('~INPUT_PICKUP~ Process 1')
						DrawMarker(6, Config.FirstProccesMarker, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
						if IsControlJustPressed(1, 38) then
							processOneIsDone = true
							SetEntityHeading(player, Config.FirstProccesMarkerHeading)
							SetEntityCoords(player, Config.FirstProccesMarker, 1, 0, 0, 1)
							Citizen.Wait(7)
							ESX.LoadAnimDict("mini@repair")
							TaskPlayAnim(player, 'mini@repair', 'fixing_a_ped', 1.0, -1.0, 15000, 69, 0, 0, 0, 0)
							FreezeEntityPosition(player, true)
							exports["btrp_progressbar"]:StartDelayedFunction({
								["text"] = "Bakar degen",
								["delay"] = 15000
							})
							Citizen.Wait(15000)
							ESX.ShowNotification('Du bakade degen gå nu och hämta topingen')
							FreezeEntityPosition(player, false)
						end
					end
				end
			end
		end
		if processOneIsDone and not processTwoIsDone then
			if distSecondProccesMarker >= 1.5 and distSecondProccesMarker <= 6 then
				DrawMarker(6, Config.SecondProccesMarker, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
			end
			if processOneIsDone and not processTwoIsDone then
				if distSecondProccesMarker < 1.5 then
					ESX.ShowHelpNotification('~INPUT_PICKUP~ Process 2')
					DrawMarker(6, Config.SecondProccesMarker, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
					if IsControlJustPressed(1, 38) then
						processTwoIsDone = true
						SetEntityHeading(player, Config.SecondProccesMarkerHeading)
						SetEntityCoords(player, Config.SecondProccesMarker, 1, 0, 0, 1)
						Citizen.Wait(7)
						ESX.LoadAnimDict("mp_am_hold_up")
						TaskPlayAnim(player, 'mp_am_hold_up', 'purchase_beerbox_shopkeeper', 1.0, -1.0, 15000, 69, 0, 0, 0, 0)
						FreezeEntityPosition(player, true)
						exports["btrp_progressbar"]:StartDelayedFunction({
							["text"] = "Tar toppings",
							["delay"] = 15000
						})
						Citizen.Wait(15000)
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop2 = CreateObject(GetHashKey(prop_name2), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop2, player, GetPedBoneIndex(player, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
						FreezeEntityPosition(player, false)
						ESX.ShowNotification('Du tog toppingsen')
					end
				end
			end
		end
		if processOneIsDone and processTwoIsDone and not processThreeIsDone then
			if distFirstProccesMarker >= 1.5 and distFirstProccesMarker <= 6 then
				DrawMarker(6, Config.FirstProccesMarker, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
			end
			if processOneIsDone and processTwoIsDone and not processThreeIsDone then
				if distFirstProccesMarker < 1.5 then
					ESX.ShowHelpNotification('~INPUT_PICKUP~ Process 3')
					DrawMarker(6, Config.FirstProccesMarker, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
					if IsControlJustPressed(1, 38) then
						processThreeIsDone = true
						SetEntityHeading(player, Config.FirstProccesMarkerHeading)
						SetEntityCoords(player, Config.FirstProccesMarker, 1, 0, 0, 1)
						DeleteObject(prop2)
						Citizen.Wait(7)
						ESX.LoadAnimDict("mini@repair")
						TaskPlayAnim(player, 'mini@repair', 'fixing_a_ped', 1.0, -1.0, 15000, 69, 0, 0, 0, 0)
						FreezeEntityPosition(player, true)
						exports["btrp_progressbar"]:StartDelayedFunction({
							["text"] = "Lägger på toppings",
							["delay"] = 15000
						})
						Citizen.Wait(15000)
						FreezeEntityPosition(player, false)
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop1 = CreateObject(GetHashKey(prop_name1), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop1, player, GetPedBoneIndex(player, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
						ESX.ShowNotification('Du lade på toppings')
					end
				end
			end
		end
		if processOneIsDone and processTwoIsDone and processThreeIsDone and not processFourIsDone then
			if distThirdProccesMarker >= 1.5 and distThirdProccesMarker <= 6 then
				DrawMarker(6, Config.ThirdProcessMarker, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
			end
			if processOneIsDone and processTwoIsDone and processThreeIsDone and not processFourIsDone then
				if distThirdProccesMarker < 1.5 then
					ESX.ShowHelpNotification('~INPUT_PICKUP~ Process 4')
					DrawMarker(6, Config.ThirdProcessMarker, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
					if IsControlJustPressed(1, 38) then
						processFourIsDone = true
						SetEntityHeading(player, Config.ThirdProcessMarkerHeading)
						SetEntityCoords(player, Config.ThirdProcessMarker, 1, 0, 0, 1)
						DeleteObject(prop1)
						Citizen.Wait(7)
						ESX.LoadAnimDict("mini@repair")
						TaskPlayAnim(player, 'mini@repair', 'fixing_a_ped', 1.0, -1.0, 15000, 69, 0, 0, 0, 0)
						FreezeEntityPosition(player, true)
						exports["btrp_progressbar"]:StartDelayedFunction({
							["text"] = "Lägger in pizzan i ugnen",
							["delay"] = 15000
						})
						Citizen.Wait(15000)
						FreezeEntityPosition(player, false)
						ESX.ShowNotification('Du lade in pizzan')
					end
				end
			end
		end
		if processOneIsDone and processTwoIsDone and processThreeIsDone and processFourIsDone and not processFiveIsDone then
			if distThirdProccesMarker >= 1.5 and distThirdProccesMarker <= 6 then
				DrawMarker(6, Config.ThirdProcessMarker, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
			end
			if processOneIsDone and processTwoIsDone and processThreeIsDone and processFourIsDone and not processFiveIsDone then
				if distThirdProccesMarker < 1.5 then
					ESX.ShowHelpNotification('~INPUT_PICKUP~ Process 5')
					DrawMarker(6, Config.ThirdProcessMarker, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
					if IsControlJustPressed(1, 38) then
						processFiveIsDone = true
						SetEntityHeading(player, Config.ThirdProcessMarkerHeading)
						SetEntityCoords(player, Config.ThirdProcessMarker, 1, 0, 0, 1)
						Citizen.Wait(7)
						ESX.LoadAnimDict("mini@repair")
						TaskPlayAnim(player, 'mini@repair', 'fixing_a_ped', 1.0, -1.0, 15000, 69, 0, 0, 0, 0)
						FreezeEntityPosition(player, true)
						exports["btrp_progressbar"]:StartDelayedFunction({
							["text"] = "Tar ut pizzan ur ugnen",
							["delay"] = 15000
						})
						Citizen.Wait(15000)
						FreezeEntityPosition(player, false)
						ESX.ShowNotification('Du fick pizzan!')
						TriggerServerEvent('force_pizzamakerReward2', rewardItem)

						pizzaMakingIsStarted = false
						processOneIsDone = false
						processTwoIsDone = false
						processThreeIsDone = false
						processFourIsDone = false
						processFiveIsDone = false
					end
				end
			end
		end
	end
end)

function ChoosePizza()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weamenu',
    {
        title = 'Vilken pizza vill du göra?',
        align = 'center',
        elements = {
			{label = 'Kebab Pizza', option = 'kebab'},
            {label = 'Margarita', option = 'margarita'},
			{label = 'Capricciosa', option = 'capricciosa'},
			{label = 'La Costa Special', option = 'lacostaspecial'},
			{label = 'Fyra Ostar', option = 'fyraostar'},
			{label = 'Robertos Special', option = 'robertosspecial'},
			{label = 'Kebabrulle', option = 'kebabrulle'},
        }
    },

    function(data, menu)
        local chosen = data.current.option

		if chosen == 'kebab' then
			menu.close()
			Citizen.Wait(100)
			AcceptPizza(chosen)
		elseif chosen == 'margarita' then
			menu.close()
			Citizen.Wait(100)
			AcceptPizza(chosen)
		elseif chosen == 'capricciosa' then
			menu.close()
			Citizen.Wait(100)
			AcceptPizza(chosen)
		elseif chosen == 'lacostaspecial' then
			menu.close(chosen)
			Citizen.Wait(100)
			AcceptPizza(chosen)
		elseif chosen == 'fyraostar' then
			menu.close(chosen)
			Citizen.Wait(100)
			AcceptPizza(chosen)
		elseif chosen == 'robertosspecial' then
			menu.close(chosen)
			Citizen.Wait(100)
			AcceptPizza(chosen)
		elseif chosen == 'kebabrulle' then
			menu.close(chosen)
			Citizen.Wait(100)
			AcceptPizza(chosen)
        end
    end,
    function(data, menu)
        menu.close()
		ESX.ShowNotification('Du är sämst därför vill du inte göra en pizza :(')
    end)
end

function AcceptPizza(chosenPizza)
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weamenu',
    {
        title = 'Vill du göra denna pizza?',
        align = 'center',
        elements = {
            {label = 'Ja', option = 'ja'},
            {label = 'Nej', option = 'nej'},
        }
    },

    function(data, menu)
        -- menu.close()
        local chosen = data.current.option

        if chosen == 'ja' then
			ESX.ShowNotification('Du har nu börjat proccesen för att göra en pizza')
			pizzaMakingIsStarted = true
			TriggerEvent('force_pizzamakerPizzaMaker1', chosenPizza)
            menu.close()
			elseif chosen == 'nej' then
            menu.close()
			ESX.ShowNotification('Du är sämst därför vill du inte göra en pizza :(')
        end
    end,
    function(data, menu)
        menu.close()
		ESX.ShowNotification('Du är sämst därför vill du inte göra en pizza :(')
    end)
end

function F6MenuMadeByForceYeye()
    ESX.UI.Menu.CloseAll()

	local elements = {
		{label = 'Fakturera Civil', option = 'invoice'},
		{label = 'Fakturera Företag', option = 'invoice_company'},
	}

	if PlayerData.job and PlayerData.job.grade_name == "boss" or "chef" then
		table.insert(elements, {label = 'Chefs Meny', option = 'bossmenu'})
	end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weamenu',
    {
        title = 'Salims Bizzeria',
        align = 'right',
        elements = elements
    },

    function(data, menu)
        local chosen = data.current.option

        if chosen == 'invoice' then
			TriggerEvent("rdrp_invoice:startCreatingInvoice")
            menu.close()
			elseif chosen == 'invoice_company' then
            menu.close()
			TriggerEvent("rdrp_invoice:startCreatingJobInvoice")
			elseif chosen == 'bossmenu' then
            menu.close()
			TriggerEvent("btrp_jobpanel:openJobPanel", "salims")
        end
    end,
    function(data, menu)
        menu.close()
		ESX.ShowNotification('Du kan göra hemma varsegod!')
    end)
end

function BuyDrink()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weamenu',
    {
        title = 'Köp in drickor!',
        align = 'center',
        elements = {
            {label = 'Vatten (6kr)', option = 'water'},
            {label = 'Ramlösa (8kr)', option = 'water2'},
			{label = 'Powerking Strawberry (9kr)', option = 'powerking'},
            {label = 'Redbull (9kr)', option = 'redbull'},
			{label = 'Öl (10kr)', option = 'beer'},
        }
    },

    function(data, menu)
        local chosen = data.current.option

        if chosen == 'water' then
			ESX.ShowNotification('Du köpte in 1 Vatten, det drogs 6kr från kassan!')
			TriggerServerEvent('force_salimsbizzeriaBuyWater')
            menu.close()
			elseif chosen == 'water2' then
			ESX.ShowNotification('Du köpte in 1 Ramlösa, det drogs 8kr från kassan!')
			TriggerServerEvent('force_salimsbizzeriaBuyWater2')
            menu.close()
			elseif chosen == 'powerking' then
			ESX.ShowNotification('Du köpte in 1 Powerking Strawberry, det drogs 9kr från kassan!')
			TriggerServerEvent('force_salimsbizzeriaBuyPowerking')
            menu.close()
			elseif chosen == 'redbull' then
			ESX.ShowNotification('Du köpte in 1 Redbull, det drogs 9kr från kassan!')
			TriggerServerEvent('force_salimsbizzeriaBuyRedbull')
            menu.close()
			elseif chosen == 'beer' then
			ESX.ShowNotification('Du köpte in 1 Öl, det drogs 10kr från kassan!')
			TriggerServerEvent('force_salimsbizzeriaBuyBeer')
            menu.close()
        end
    end,
    function(data, menu)
        menu.close()
		ESX.ShowNotification('Du kan göra hemma varsegod!')
    end)
end

Citizen.CreateThread(function()
	blip = AddBlipForCoord(Config.StartMarker)

	SetBlipSprite (blip, 267)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.7)
	SetBlipColour (blip, 0)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Groves Pizzeria')
	EndTextCommandSetBlipName(blip)

end)
