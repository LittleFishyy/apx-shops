CreateThread(function()
    while true do 
        local wait = 800 
            for k,v in pairs (Config.Shops) do 
                local plyc = GetEntityCoords(PlayerPedId())
                if #(plyc - v.coords) < 2 then 
                    wait = 0
                    ESX.ShowFloatingHelpNotification("~r~E~w~ - "..v.name, v.coords)
                    if IsControlJustPressed(0, 38) then 
                        local elements = {}
                        print(json.encode(v.items))
                        for i = 1, #v.items do 
                            table.insert(elements, {
                                label = v.items[i].label .. ' - <span style="color: green;">' .. v.items[i].price ..'$</span>',
                                name = v.items[i].name,
                                price = v.items[i].price
                            })
                        end
                        print(json.encode(elements))
                        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "shop", {
                            title = v.name,
                            align = 'right',
                            elements = elements

                        }, function(data, menu)
                            local c = data.current
                            TriggerServerEvent('xp-mastershops:buyItem', c.name, c.label, c.price)

                        end, function(data, menu)
                            menu.close()
                        end)
                    end
                end
            end
        Wait(wait)
    end
end)

CreateThread(function()

    for k,v in pairs(Config.Shops) do
      v.blip = AddBlipForCoord(v.coords)
      SetBlipSprite(v.blip, v.blipid)
      SetBlipDisplay(v.blip, 4)
      SetBlipScale(v.blipsize, v.blipsize)
      SetBlipColour(v.blip, v.blipcolor)
      SetBlipAsShortRange(v.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(v.name)
      EndTextCommandSetBlipName(v.blip) 
    end

end)