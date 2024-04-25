
-- local startX, endX = -3000, 3000
-- local startY, endY = -4000, 7000

local startX, endX = -3000, 3000
local startY, endY = -4000, 7000

-- local fromX, toX = -3, 3
-- local fromY, toY = -4, 7

local fromX, toX = -15, 15
local fromY, toY = -15, 30

local function lerp(x1, x2, t)
	return x1 + (x2 - x1) * t
end

function math.clamp(value, minClamp, maxClamp)
	return math.min(maxClamp, math.max(value, minClamp))
end

local sizes = {
	50.0,
	100.0,
	150.0,
}

local times = {
	10000,
	30000,
	60000,
}


function CreateDanger(pos, level)
	CreateThread(function()
		local blip = AddBlipForRadius(pos.x, pos.y, 0.0, sizes[level])
		-- local blip = AddBlipForArea(x, y, 0.0, 250.0, 250.0)
		-- SetBlipColour(blip, 6)
		SetBlipColour(blip, 0xFF000000)
		SetBlipAlpha(blip, 2)

		Wait(times[level])
		RemoveBlip(blip)
	end)
end

RegisterNetEvent("HOTZONE:ReceiveGunshot")
AddEventHandler("HOTZONE:ReceiveGunshot", CreateDanger)

CreateThread(function()
	while true do Wait(0)
		if IsPedShooting(PlayerPedId()) and not IsPedCurrentWeaponSilenced(PlayerPedId()) then
			-- CreateDanger(GetEntityCoords(PlayerPedId()))
			TriggerServerEvent("HOTZONE:GunshotEvent", GetEntityCoords(PlayerPedId()), 1)
			Wait(50)
		end
	end
end)

CreateThread(function()
	while true do Wait(0)
		if IsPedShooting(PlayerPedId()) then
			-- CreateDanger(GetEntityCoords(PlayerPedId()))
			TriggerServerEvent("HOTZONE:GunshotEvent", GetEntityCoords(PlayerPedId()), 2)
			Wait(1000)
		end
	end
end)

CreateThread(function()
	while true do Wait(0)
		if IsPedShooting(PlayerPedId()) then
			-- CreateDanger(GetEntityCoords(PlayerPedId()))
			TriggerServerEvent("HOTZONE:GunshotEvent", GetEntityCoords(PlayerPedId()), 3)
			Wait(2500)
		end
	end
end)

--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
			local _,wep = GetCurrentPedWeapon(PlayerPedId())
			_,cAmmo = GetAmmoInClip(PlayerPedId(), wep)
			if recoils[wep] and recoils[wep] ~= 0 then
				tv = 0
				if GetFollowPedCamViewMode() ~= 4 then
					repeat 
						Wait(0)
						p = GetGameplayCamRelativePitch()
						SetGameplayCamRelativePitch(p+0.1, 0.2)
						tv = tv+0.1
					until tv >= recoils[wep]
				else
					repeat 
						Wait(0)
						p = GetGameplayCamRelativePitch()
						if recoils[wep] > 0.1 then
							SetGameplayCamRelativePitch(p+0.6, 1.2)
							tv = tv+0.6
						else
							SetGameplayCamRelativePitch(p+0.016, 0.333)
							tv = tv+0.1
						end
					until tv >= recoils[wep]
				end
			end
		end
	end
end)
]]

--[[
CreateThread(function()
	for vx=fromX, toX do
	for vy=fromY, toY do
		local xp = (vx + math.abs(math.min(fromX, toX))) / math.abs(fromX - toX)
		local yp = (vy + math.abs(math.min(fromY, toY))) / math.abs(fromY - toY)
		
		local x = lerp(startX, endX, xp)
		local y = lerp(startY, endY, yp)
	
		local blip = AddBlipForRadius(x, y, 0.0, 200.0)
		-- local blip = AddBlipForArea(x, y, 0.0, 250.0, 250.0)
		-- SetBlipColour(blip, 6)
		SetBlipColour(blip, 0xAA000000)
		
		local dist = #vec(x, y)
		-- local scale = math.max(dist / 100.0, 1.0)
		local scale = math.clamp(dist / 800.0, 0.0, 1.0)
		-- local alpha = math.floor(lerp(0, 255, scale))
		local alpha = 255-math.floor(scale * 255)
		SetBlipAlpha(blip, alpha)
		-- SetBlipAlpha(blip, 25)
	end
	Wait(0)
	end
end)
]]