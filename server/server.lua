RegisterServerEvent("xp-mastershops:buyItem")
AddEventHandler("xp-mastershops:buyItem", function(name, label, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    print(name, price)
    if xPlayer.getAccount('money').money >= price then 
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem(name, 1)
    else 
        xPlayer.showNotification("No tienes suficiente ~r~dinero.")
    end
end)