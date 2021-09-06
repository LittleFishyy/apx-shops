CreateThread(function()
    while true do 
        local wait = 800 
            for k,v in pairs (Config.Shops) do 
                local plyc = GetEntityCoords(PlayerPedId())
                if #(plyc - v.coords) < 2 then 
                    wait = 0
                    FloatingNotification("~r~E~w~ - "..v.name, v.coords)
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
      SetBlipScale(v.blip, v.blipsize)
      SetBlipColour(v.blip, v.blipcolor)
      SetBlipAsShortRange(v.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(v.name)
      EndTextCommandSetBlipName(v.blip) 
    end

end)

-- Show Floating Text --
function FloatingNotification(msg, coords)
    SetFloatingHelpTextWorldPosition(1, coords.x, coords.y, coords.z)
    SetFloatingHelpTextStyle(1, 1, 5, -1, 3, 0)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(2, false, true, -1)
end