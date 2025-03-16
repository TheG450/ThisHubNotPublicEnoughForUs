local path = script_path    
warn("Script Lodded")
    if game.PlaceId == 18668065416 or game.PlaceId == 92517437168342 then
        if string.find(path, "BluelockRival") then
            print("Bluelock : Rival Lodded")
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Malemz1/FORTUNE-HUB/refs/heads/main/BlueLock.lua", true))()
        else
            game.Players.LocalPlayer:Kick("Your Not Have Game Access")
        end
    elseif game.PlaceId == 73956553001240 then
        if string.find(path, "VolleyballLegend") then
            print("Volleyball Legend Lodded")
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Malemz1/FORTUNE-HUB/refs/heads/main/Haikyuu.lua", true))()
        else
            game.Players.LocalPlayer:Kick("Your Not Have Game Access")
        end
    elseif  game.PlaceId == 115815718131154 then
        if string.find(path, "KuroKuNoBasketball") then
            print("KuroKu No Basketball Lodded")
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Malemz1/FORTUNE-HUB/refs/heads/main/Kuroku.lua", true))()
        else
            game.Players.LocalPlayer:Kick("Your Not Have Game Access")
        end
    elseif  game.PlaceId == 9301186334 then
        if string.find(path, "RiderWorld") then
            print("Rider : World Lodded")
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Malemz1/FORTUNE-HUB/refs/heads/main/Rider%20World.lua", true))()
        else
            game.Players.LocalPlayer:Kick("Your Not Have Game Access")
        end
    else
        game.Players.LocalPlayer:Kick("This Game Not Register")
    end
