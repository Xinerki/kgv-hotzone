
function ReceiveGunshot(pos, level)
	TriggerClientEvent("HOTZONE:ReceiveGunshot", -1, pos, level)
end

RegisterServerEvent("HOTZONE:GunshotEvent")
AddEventHandler("HOTZONE:GunshotEvent", ReceiveGunshot)