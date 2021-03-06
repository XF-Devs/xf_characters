local camera = nil
local cam = {
  pos = vector3(1705.61, -2517.48, 462.09),
  rot = vector3(0.0, 0.0, 60.0),
  time = 10000
}
local playerFirstJoined = true

AddEventHandler('playerSpawned', function()
  if playerFirstJoined then
    Citizen.Wait(1000)
    SendNUIMessage({
      type = "set_resource_defaults",
      data = {
        resource = GetCurrentResourceName(),
      }
    })
    TriggerServerEvent("XF:Characters:PlayerJoined")
    SetNuiFocus(false, false)
    camera = Camera.New()
    playerFirstJoined = false
  end
end)

Citizen.CreateThread(function()
  SetEntityHealth(PlayerPedId(), 0)
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
    type = "toggle_ui",
    data = {
      visible = true
    }
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

  if data.character[1].ismale == 0 then
    model = GetHashKey("mp_f_freemode_01")
  end

  RequestModel(model)
  while not HasModelLoaded(model) do
    Citizen.Wait(0)
  end

  SetPlayerModel(PlayerId(), model)
  SetPedDefaultComponentVariation(PlayerPedId())

  local ped = PlayerPedId()
  SetPedHeadBlendData(ped, data.parents[1].father, data.parents[1].mother, 0, data.parents[1].father, data.parents[1].mother, 0, data.parents[1].mix + 0.0, data.parents[1].mix + 0.0, data.parents[1].mix + 0.0, true)
  
  for k, v in pairs(data.components) do
    SetPedComponentVariation(ped, v.component, v.drawable, v.texture, 0)
    print(v.primaryColor, v.secondaryColor)
    if v.primaryColor ~= -1 and v.secondaryColor ~= -1 then
      SetPedHairColor(ped, v.primaryColor, v.secondaryColor)
    end
  end
  for k, v in pairs(data.props) do
    SetPedPropIndex(ped, v.prop, v.drawable, v.texture, true)
  end
  for k, v in pairs(data.features) do
    SetPedFaceFeature(ped, v.feature, v.scale)
  end
  for k, v in pairs(data.overlays) do
    SetPedHeadOverlay(ped, v.overlay, v.index, v.opacity + 0.0)
    SetPedHeadOverlayColor(ped, v.overlay, v.colorType, v.color, v.color_two)
  end

  -- Disable NUI
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "toggle_ui",
    data = {}
  })

  camera:Render(false, false, 0)
  camera:SetActive(false)
end)

RegisterCommand("p", function()
  print("ROT: " .. GetEntityRotation(PlayerPedId()))
end, false)

RegisterNUICallback("delete_character", function(data)
  TriggerServerEvent("XF:Characters:DeleteCharacter", data.id)
end)

RegisterNUICallback("select_character", function(data)
  TriggerServerEvent("XF:Characters:SelectCharacter", data.id)
end)

RegisterNUICallback("start_creator", function(data)
  TriggerEvent("XF:Characters:StartCreator")
end)

-- CHARACTER CREATOR CODE --
AddEventHandler("XF:Characters:StartCreator", function()
  local model = GetHashKey("mp_m_freemode_01")

  RequestModel(model)
  while not HasModelLoaded(model) do
    Citizen.Wait(0)
  end

  SetPlayerModel(PlayerId(), model)

  local ped = PlayerPedId()

  SetPedDefaultComponentVariation(ped)
  SetPedHeadBlendData(ped, 0, 0, 0, 0, 0, 0, 0, 0, 0, true)
  NetworkSetEntityInvisibleToNetwork(ped, true)
  SetEntityCoords(ped, 402.88, -996.81, -99.0, 0, 0, 0, false)
  SetEntityHeading(ped, 180.0)

  local components = {
    ["1"] = 0,
    ["2"] = 0,
    ["3"] = 0,
    ["4"] = 0,
    ["6"] = 0,
    ["7"] = 0,
    ["8"] = 0,
    ["11"] = 0
  }
  local props = {
    ["0"] = 0,
    ["1"] = 0,
    ["2"] = 0,
    ["6"] = 0,
    ["7"] = 0
  }

  for k, _ in pairs(components) do
    components[tostring(k)] = GetNumberOfPedDrawableVariations(ped, tonumber(k))
  end

  for k, _ in pairs(props) do
    props[tostring(k)] = GetNumberOfPedPropDrawableVariations(ped, tonumber(k))
  end

  SendNUIMessage({
    type = "set_character_data",
    data = {
      components = components,
      props = props
    }
  })

  Citizen.Wait(750)
  local creatorCamPos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 0.0)

  camera:SetActive(true)
  camera:Render(true, true, 0)
  camera:SetPosition(creatorCamPos)
  camera:PointAtBone(ped, 0, vector3(0.0, 0.0, 0.0))
  DisplayRadar(false)

  while not IsInteriorReady(94722) do
    FreezeEntityPosition(ped, true)
    Citizen.Wait(0)
  end

  FreezeEntityPosition(ped, false)

  SendNUIMessage({
    type = "toggle_menus",
    data = {
      showManager = false
    }
  })

end)

RegisterNUICallback("gender_changed", function(data)
  local model = GetHashKey("mp_m_freemode_01")

  if data.ismale == false then
    model = GetHashKey("mp_f_freemode_01")
  end

  RequestModel(model)
  while not HasModelLoaded(model) do
    Citizen.Wait(0)
  end

  SetPlayerModel(PlayerId(), model)

  local ped = PlayerPedId()

  SetPedDefaultComponentVariation(ped)
  SetPedHeadBlendData(ped, 0, 0, 0, 0, 0, 0, 0, 0, 0, true)
  NetworkSetEntityInvisibleToNetwork(ped, true)
  SetEntityCoords(ped, 402.88, -996.81, -99.0, 0, 0, 0, false)
  SetEntityHeading(ped, 180.0)
end)

RegisterNUICallback("parents_changed", function(data)
  data.father = tonumber(data.father)
  data.mother = tonumber(data.mother)
  data.mix = tonumber(data.mix) + 0.0
  local ped = PlayerPedId()
  SetPedHeadBlendData(ped, data.father, data.mother, 0, data.father, data.mother, 0, data.mix, data.mix, data.mix, true)
end)

RegisterNUICallback("component_drawable_changed", function(data, cb)
  local ped = PlayerPedId()
  SetPedComponentVariation(ped, tonumber(data.id), tonumber(data.drawable), 0, 0)
  cb({
    textures = GetNumberOfPedTextureVariations(ped, tonumber(data.id), tonumber(data.drawable))
  })
end)

RegisterNUICallback("component_texture_changed", function(data)
  local ped = PlayerPedId()
  SetPedComponentVariation(ped, tonumber(data.id), tonumber(data.drawable), tonumber(data.texture), 0)
end)

RegisterNUICallback("prop_drawable_changed", function(data, cb)
  local ped = PlayerPedId()
  SetPedPropIndex(ped, tonumber(data.id), tonumber(data.drawable), 0, 0)
  cb({
    textures = GetNumberOfPedPropTextureVariations(ped, tonumber(data.id), tonumber(data.drawable))
  })
end)

RegisterNUICallback("prop_texture_changed", function(data)
  local ped = PlayerPedId()
  SetPedPropIndex(ped, tonumber(data.id), tonumber(data.drawable), tonumber(data.texture), attach)
end)

RegisterNUICallback("overlay_changed", function(data)
  local ped = PlayerPedId()
  SetPedHeadOverlay(ped, tonumber(data.id), tonumber(data.overlay), tonumber(data.opacity) + 0.0)
  SetPedHeadOverlayColor(ped, tonumber(data.id), 1, tonumber(data.color), tonumber(data.color_two))
end)

RegisterNUICallback("set_hair_color", function(data)
  local ped = PlayerPedId()
  SetPedHairColor(ped, tonumber(data.color), tonumber(data.color_two))
end)

RegisterNUICallback("set_face_feature", function(data)
  local ped = PlayerPedId()
  print(json.encode(data))
  SetPedFaceFeature(ped, tonumber(data.id), tonumber(data.scale) + 0.0)
end)

RegisterNUICallback("set_camera_focus", function(data)
  local ped = PlayerPedId()
  if data.type == "face" then
    local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.75)
    camera:SetPosition(pos)
    camera:PointAtBone(ped, 31086, vector3(0.0, 0.1, 0.7))
  else
    local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 0.0)
    camera:SetPosition(pos)
    camera:PointAtBone(ped, 0, vector3(0.0, 0.0, 0.0))
  end
end)

RegisterNUICallback("finish_character_creation", function(data, cb)
  TriggerServerEvent("XF:Characters:CreateCharacter", data)
  cb()
end)