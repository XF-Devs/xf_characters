Character = {}
Character.__index = Character

function Character.New(playerid)
  local newCharacter = {}
  setmetatable(newCharacter, Character)

  newCharacter.player_id = player_id

  local results = exports.ExternalSQL:AsyncQuery({
    query = [[]],
    data = {}
  })

  return newCharacter
end

function Character.Load(id)
  local loadedCharacter = {}
  setmetatable(loadedCharacter, Character)
  
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[
      SELECT *
      FROM characters
      WHERE id = :id
      LIMIT 1
    ]],
    data = {
      id = id
    }
  })

  if results.status then
    if #results.data > 0 then
      loadedCharacter = results.data[1]
    end
  end

  return loadedCharacter
end

function Character:Update(key, value)

end

function Character:Delete()

end

function Character:Save()
  
end