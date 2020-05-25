local camera = nil
local cam = {
  pos = vector3(1705.61, -2517.48, 462.09),
  rot = vector3(0.0, 0.0, 60.0),
  time = 10000
}

Citizen.CreateThread(function()
  Citizen.Wait(2500)
  TriggerServerEvent("XF:Characters:PlayerJoined")
  SendNUIMessage({
    type = "set_resource_defaults",
    data = {
      resource = GetCurrentResourceName(),
    }
  })

  camera = Camera.New()
end)



RegisterNetEvent("XF:Characters:OpenCharacters")
AddEventHandler("XF:Characters:OpenCharacters", function(characters)
  SendNUIMessage({
    type = "send_characters",
    data = {
      characters = characters
    }
  })
  SendNUIMessage({
    type = "open_ui",
    data = {}
  })
  SetNuiFocus(true, true)

  camera:SetActive(true)
  camera:Render(true, true, 0)
  camera:SetPosition(cam.pos)
  camera:SetRotation(cam.rot)
end)

RegisterNetEvent("XF:Characters:UpdateCharacters")
AddEventHandler("XF:Characters:UpdateCharacters", function(characters)
  SendNUIMessage({
    type = "send_characters",
    data = {
      characters = characters
    }
  })
end)

RegisterNetEvent("XF:Characters:LoadCharacter")
AddEventHandler("XF:Characters:LoadCharacter", function(data)
  local model = GetHashKey("mp_m_freemode_01")

  if data.ismale == 0 then
    model = GetHashKey("mp_f_freemode_01")
  end

  RequestModel(model)
  while not HasModelLoaded(model) do
    Citizen.Wait(0)
  end

  SetPlayerModel(PlayerId(), model)
  SetPedDefaultComponentVariation(PlayerPedId())

  -- Disable NUI
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "close_ui",
    data = {}
  })

  camera:Render(false, false, 0)
  camera:SetActive(false)
end)

RegisterNUICallback("create_character", function(data)
  TriggerServerEvent("XF:Characters:CreateCharacter", data)
end)

RegisterNUICallback("delete_character", function(data)
  TriggerServerEvent("XF:Characters:DeleteCharacter", data.id)
end)

RegisterNUICallback("select_character", function(data)
  TriggerServerEvent("XF:Characters:SelectCharacter", data.id)
end)