ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

TriggerEvent('esx_phone:registerNumber', 'salims', 'Salim Samtal', true, true)
TriggerEvent('esx_society:registerSociety', 'salims', 'Salims', 'society_salims', 'society_salims', 'society_salims', {type = 'public'})

RegisterServerEvent('force_pizzamakerReward2')
AddEventHandler('force_pizzamakerReward2', function(rewardItem)
    local player = ESX.GetPlayerFromId(source)

    player.addInventoryItem(rewardItem, 1)
    TriggerClientEvent('esx:showNotification', src, 'Du fick en' .. rewardItem)
end)

RegisterServerEvent('force_salimsbizzeriaBuyWater')
AddEventHandler('force_salimsbizzeriaBuyWater', function()
    local player = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_salims', function(account)

        if account.money >= 6 then
            account.removeMoney(6)
            player.addInventoryItem('water', 1)
        else
            ESX.ShowNotification('Företaget har inte råd med detta!')
        end
    end)
end)

RegisterServerEvent('force_salimsbizzeriaBuyWater2')
AddEventHandler('force_salimsbizzeriaBuyWater2', function()
    local player = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_salims', function(account)

        if account.money >= 8 then
            account.removeMoney(8)
            player.addInventoryItem('water2', 1)
        else
            ESX.ShowNotification('Företaget har inte råd med detta!')
        end
    end)
end)

RegisterServerEvent('force_salimsbizzeriaBuyPowerking')
AddEventHandler('force_salimsbizzeriaBuyPowerking', function()
    local player = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_salims', function(account)

        if account.money >= 9 then
            account.removeMoney(9)
            player.addInventoryItem('powerking', 1)
        else
            ESX.ShowNotification('Företaget har inte råd med detta!')
        end
    end)
end)

RegisterServerEvent('force_salimsbizzeriaBuyRedbull')
AddEventHandler('force_salimsbizzeriaBuyRedbull', function()
    local player = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_salims', function(account)

        if account.money >= 9 then
            account.removeMoney(9)
            player.addInventoryItem('redbull', 1)
        else
            ESX.ShowNotification('Företaget har inte råd med detta!')
        end
    end)
end)

RegisterServerEvent('force_salimsbizzeriaBuyBeer')
AddEventHandler('force_salimsbizzeriaBuyBeer', function()
    local player = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_salims', function(account)

        if account.money >= 10 then
            account.removeMoney(10)
            player.addInventoryItem('beer', 1)
        else
            ESX.ShowNotification('Företaget har inte råd med detta!')
        end
    end)
end)