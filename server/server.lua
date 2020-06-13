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
  local created, createdResults = XF.Characters:CreateCharacter(src, data)
  if created then

    local insertId = createdResults.data.insertId

    exports.ExternalSQL:AsyncQuery({
      query = [[
        INSERT INTO `character_parents` (
          `mother`,
          `father`,
          `mix`,
          `char_id`
        ) VALUES (
          :mother,
          :father,
          :mix,
          :charid
        )
      ]],
      data = {
        father = data.parents.father,
        mother = data.parents.mother,
        mix = data.parents.mix,
        charid = insertId
      }
    })

    for k, v in pairs(data.components) do
      exports.ExternalSQL:AsyncQuery({
        query = [[
          INSERT INTO `character_components` (
            `component`,
            `drawable`,
            `texture`,
            `primaryColor`,
            `secondaryColor`,
            `char_id`
          ) VALUES (
            :component,
            :drawable,
            :texture,
            :color,
            :color_two,
            :charid
          );
        ]],
        data = {
          component = k,
          drawable = v.drawable,
          texture = v.texture,
          color = v.primaryColor or -1,
          color_two = v.secondaryColor or -1,
          charid = insertId
        }
      })
    end

    for k, v in pairs(data.props) do
      exports.ExternalSQL:AsyncQuery({
        query = [[
          INSERT INTO `character_props` (
            `prop`,
            `drawable`,
            `texture`,
            `char_id`
          ) VALUES (
            :prop,
            :drawable,
            :texture,
            :charid
          )
        ]],
        data = {
          prop = k,
          drawable = v.drawable,
          texture = v.texture,
          charid = insertId
        }
      })
    end

    for k, v in pairs(data.overlays) do
      exports.ExternalSQL:AsyncQuery({
        query = [[
          INSERT INTO `character_overlays` (
            `overlay`,
            `opacity`,
            `index`,
            `colorType`,
            `color`,
            `color_two`,
            `char_id`
          ) VALUEs (
            :overlay,
            :opacity,
            :index,
            :colortype,
            :color,
            :colortwo,
            :charid
          )
        ]],
        data = {
          overlay = k,
          opacity = v.opacity,
          index = v.overlay,
          colortype = v.colorType,
          color = v.color,
          colortwo = v.color_two,
          charid = insertId
        }
      })
    end

    for k, v in pairs(data.facefeatures) do
      exports.ExternalSQL:AsyncQuery({
        query = [[
          INSERT INTO `character_features` (
            `feature`,
            `scale`,
            `char_id`
          ) VALUES (
            :feature,
            :scale,
            :charid
          )
        ]],
        data = {
          feature = k,
          scale = v.scale,
          charid = insertId
        }
      })
    end

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
    local char = Character.Load(id, player.Id)
    if char then
      XF.Characters:AddCharacter(src, char)
      player:TriggerEvent("XF:Characters:LoadCharacter", char)
      player:TriggerEvent("XF:Characters:PlayerLoadedCharacter")
      TriggerEvent("XF:Characters:PlayerLoadedCharacter", src)
    end
  end
end)