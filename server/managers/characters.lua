XF.Characters = {}

-- FUNCTIONS
function XF.Characters:AddCharacter(source, character)
  self[source] = character
end

function XF.Characters:RemoveCharacter(source)
  self[source] = nil
end

function XF.Characters:GetCharacter(source)
  return self[source]
end

exports("GetCharacter", function(source)
  return XF.Characters:GetCharacter(source)
end)

function XF.Characters:CreateCharacter(source, charData)
  local player = exports.xf_core:GetPlayer(source)
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[
      INSERT INTO `characters` (
        `firstname`,
        `middlename`,
        `lastname`,
        `age`,
        `ismale`,
        `player_id`
      ) VALUES (
        :first,
        :middle,
        :last,
        :age,
        :male,
        :playerid
      );
    ]],
    data = {
      first = charData.firstname,
      middle = charData.middlename,
      last = charData.lastname,
      age = charData.age,
      male = charData.ismale,
      playerid = player.Id
    }
  })
  if results.status then
    return true, results
  end
  return false, results
end

function XF.Characters:DeleteCharacter(source, id)
  local player = exports.xf_core:GetPlayer(source)
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[
      DELETE FROM 
        `characters`
      WHERE 
        `id` = :id 
    ]],
    data = {
      id = id
    }
  })

  if results.status then
    return true
  end
  return false
end

function XF.Characters:GetCharacters(source)
  local player = exports.xf_core:GetPlayer(source)
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[
      SELECT 
        *
      FROM
        `characters`
      WHERE
        `player_id` = :playerid
    ]],
    data = {
      playerid = player.Id
    }
  })
  return results.data
end

function XF.Characters:IsPlayersCharacter(id, playerid)
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[
      SELECT
        `id`
      FROM
        `characters`
      WHERE
        `id` = :id
      AND 
        `player_id` = :playerid
      LIMIT 1
    ]],
    data = {
      id = id,
      playerid = playerid
    }
  })

  if results.data[1] then
    return true
  end
  return false
end

exports("GetCharacter", function(source)
  return XF.Characters:GetCharacter(source)
end)