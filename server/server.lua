RegisterNetEvent("XF:Characters:PlayerJoined")
AddEventHandler("XF:Characters:PlayerJoined", function()
  local src = source
  local player = exports.xf_core:GetPlayer(src)
  player = Player.Convert(player)
  player:TriggerEvent("XF:Characters:OpenCharacters", XF.Characters:GetCharacters(src))
end)

RegisterNetEvent("XF:Characters:CreateCharacter")
AddEventHandler("XF:Characters:CreateCharacter", function(data)
  local src = source
  local player = exports.xf_core:GetPlayer(src)
  player = Player.Convert(player)
  local created = XF.Characters:CreateCharacter(src, data.character)
  if created then
    local characters = XF.Characters:GetCharacters(src)
    player:TriggerEvent("XF:Characters:UpdateCharacters", characters)
  end
end)

RegisterNetEvent("XF:Characters:DeleteCharacter")
AddEventHandler("XF:Characters:DeleteCharacter", function(id)
  local src = source
  local player = exports.xf_core:GetPlayer(src)
  player = Player.Convert(player)
  local isPlayers = XF.Characters:IsPlayersCharacter(id, player.Id)
  if isPlayers then
    local deleted = XF.Characters:DeleteCharacter(src, id)
    if deleted then
      local characters = XF.Characters:GetCharacters(src)
      player:TriggerEvent("XF:Characters:UpdateCharacters", characters)
    end
  end
end)

RegisterNetEvent("XF:Characters:SelectCharacter")
AddEventHandler("XF:Characters:SelectCharacter", function(id)
  local src = source
  local player = exports.xf_core:GetPlayer(src)
  player = Player.Convert(player)
  local isPlayers = XF.Characters:IsPlayersCharacter(id, player.Id)
  if isPlayers then
    local char = Character.Load(id)
    if char then
      XF.Characters:AddCharacter(src, char)
      player:TriggerEvent("XF:Characters:LoadCharacter", {
        ismale = char.ismale
      })
    end
  end
end)