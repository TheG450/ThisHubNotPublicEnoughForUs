

local player = game.Players.LocalPlayer
local host = "http://ec2-3-106-212-13.ap-southeast-2.compute.amazonaws.com:3000/api/"

local url = host.."/getaccess?userKey=" .. script_key

local function FeariseLodded()
    print([[
                    
                 ______              _          _    _       _     
                |  ____|            (_)        | |  | |     | |    
                | |__ ___  __ _ _ __ _ ___  ___| |__| |_   _| |__  
                |  __/ _ \/ _` | '__| / __|/ _ \  __  | | | | '_ \ 
                | | |  __/ (_| | |  | \__ \  __/ |  | | |_| | |_) |
                |_|  \___|\__,_|_|  |_|___/\___|_|  |_|\__,_|_.__/ 
                    | |             | |   | |        | |          
                    | |     ___   __| | __| | ___  __| |          
                    | |    / _ \ / _` |/ _` |/ _ \/ _` |          
                    | |___| (_) | (_| | (_| |  __/ (_| |          
                    |______\___/ \__,_|\__,_|\___|\__,_|          
                                                                    
                ]])
end

-- ตรวจสอบว่า request() ใช้ได้หรือไม่
local requestFunction = (http_request or request or syn.request)
if not requestFunction then
    return warn("[[DEBUG]]: HTTP request function not found.")
end

-- กำหนด Header และทำ Request
local response = requestFunction({
    Url = url,
    Method = "GET",
    Headers = {
        ["Content-Type"] = "application/json"
    }
})

-- ตรวจสอบผลลัพธ์
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
if response and response.Success then
    -- แปลง JSON string เป็น table
    local data = game.HttpService:JSONDecode(response.Body)

    if data.success then
        if not data.isBanned then
            if data.hwid and data.hwid == tostring(HWID) then
                FeariseLodded()
                script_path = data.gameNames
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Malemz1/FORTUNE-HUB/refs/heads/main/CheckMapSrc.lua", true))()
            elseif data.hwid and data.hwid == "N/A" then
                local postData = game.HttpService:JSONEncode({
                    userKey = script_key,
                    myHwid = HWID
                })
                
                local postResponse = requestFunction({
                    Url = host.."/resethwid",
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = postData
                })

                if postResponse and postResponse.Success then
                    FeariseLodded()
                    script_path = data.gameNames
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/Malemz1/FORTUNE-HUB/refs/heads/main/CheckMapSrc.lua", true))()
                end
            else
                player:Kick("Got Kick Code [AR01]") --HWID NOT MATCH
            end
        else
            player:Kick("Got Banneded")
        end
    end
else
    warn("Cant Fetch Data")
    local response = requestFunction({
        Url = "https://httpbin.org/user-agent", 
        Method = "GET",
        Headers = {
            ["Content-Type"] = "application/json"
        }
    })
    if response and response.Success then
    	local data = game:GetService("HttpService"):JSONDecode(response.Body)
    	print("Executor: "..data["user-agent"])
    else
    	warn("[[DEBUG]]: Not Have Response")
    end
end
