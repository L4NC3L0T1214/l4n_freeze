
--██╗░░░░░░░██╗██╗███╗░░██╗░█████╗░███████╗██╗░░░░░░█████╗░████████╗  ██████╗░███████╗██╗░░░██╗
--██║░░░░░░██╔╝██║████╗░██║██╔══██╗██╔════╝██║░░░░░██╔══██╗╚══██╔══╝  ██╔══██╗██╔════╝██║░░░██║
--██║░░░░░██╔╝░██║██╔██╗██║██║░░╚═╝█████╗░░██║░░░░░██║░░██║░░░██║░░░  ██║░░██║█████╗░░╚██╗░██╔╝
--██║░░░░░███████║██║╚████║██║░░██╗██╔══╝░░██║░░░░░██║░░██║░░░██║░░░  ██║░░██║██╔══╝░░░╚████╔╝░
--███████╗╚════██║██║░╚███║╚█████╔╝███████╗███████╗╚█████╔╝░░░██║░░░  ██████╔╝███████╗░░╚██╔╝░░
--╚══════╝░░░░░╚═╝╚═╝░░╚══╝░╚════╝░╚══════╝╚══════╝░╚════╝░░░░╚═╝░░░  ╚═════╝░╚══════╝░░░╚═╝░░░

ESX = nil
local isDead = false

Citizen.CreateThread(function()
    Wait(1000)

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

	local loaded = true 

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'freeze', {
        title    = "ป้องกันตัวละครตกแมพ",
        align    = 'center',
        elements = {
            {label = "กดปุ่ม ENTER เมื่อคุณมั่นใจว่าแมพโหลดเสร็จสิ้น", value = 'freeze_accept'}
    }}, function(data, menu)
        loaded = false
        FreezeEntityPosition(PlayerPedId(),false)
        menu.close()
    end, function(data, menu)
		loaded = false
        FreezeEntityPosition(PlayerPedId(),false)
        menu.close()
    end)

	while loaded and not isDead do
		FreezeEntityPosition(PlayerPedId(),true)
		Wait(0)
	end
end)

AddEventHandler('esx:onPlayerDeath', function() 
    isDead = true
end)

AddEventHandler('playerSpawned', function() 
    isDead = false
end)
