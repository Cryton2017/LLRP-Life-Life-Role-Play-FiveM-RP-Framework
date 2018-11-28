Citizen.CreateThread(function()
	local items = { "Online Player List", "Character", "Vehicle", "Weapon", "Word", "Settings", "Close" }
	local currentItemIndex = 1
	local selectedItemIndex = 1
	local checkbox = true

	WarMenu.CreateMenu('lifeLike', 'Life Like Menu')
	WarMenu.CreateSubMenu('Close', 'lifeLike', 'Are you sure?')
	WarMenu.CreateSubMenu('OnlinePlayers', 'lifeLike', 'Online Players')

	while true do
		if WarMenu.IsMenuOpened('lifeLike') then
			if WarMenu.CheckBox('Checkbox', checkbox, function(checked)
					checkbox = checked
				end) then
					-- Do your stuff here
			elseif WarMenu.ComboBox('Combobox', items, currentItemIndex, selectedItemIndex, function(currentIndex, selectedIndex)
					currentItemIndex = currentIndex
					selectedItemIndex = selectedIndex

					-- Do your stuff here if current index was changed (don't forget to check it)
				end) then
					-- Do your stuff here if current item was activated
			elseif WarMenu.MenuButton('Online Players', 'OnlinePlayers') then
			elseif WarMenu.MenuButton('Exit', 'Close') then
			
			end

			

			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('OnlinePlayers') then

			local players = GetPlayers()
			for _, i in ipairs(players) do
			local pnames = GetPlayerName(i)
				--If any player was selected:
				if WarMenu.Button(pnames) then
					--Do Something here:
				end
			end


			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('Close') then
			if WarMenu.Button('Yes') then
				WarMenu.CloseMenu()
			elseif WarMenu.MenuButton('No', 'lifeLike') then
			end

			WarMenu.Display()
		elseif IsControlJustReleased(0, 244) then -- M by default
			WarMenu.OpenMenu('lifeLike')
		end

		Citizen.Wait(0)
	end
end)

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

AddEventHandler('playerSpawned', function()
	WarMenu.OpenMenu('lifeLike')
end)