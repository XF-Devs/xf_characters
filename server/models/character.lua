Character = {}
Character.__index = Character

function Character.Load(id, playerid)
  local loadedCharacter = {}
  setmetatable(loadedCharacter, Character)

  loadedCharacter.id = id
  loadedCharacter.playerid = playerid
  loadedCharacter.character = loadedCharacter:LoadBaseData()
  loadedCharacter.components = loadedCharacter:GetAllComponents()
  loadedCharacter.props = loadedCharacter:GetAllProps()
  loadedCharacter.parents = loadedCharacter:GetParents()
  loadedCharacter.features = loadedCharacter:GetFeatures()
  loadedCharacter.overlays = loadedCharacter:GetOverlays()

  return loadedCharacter
end

function Character:LoadBaseData()
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[
      SELECT *
      FROM `characters`
      WHERE `id` = :id
    ]],
    data = {
      id = self.id
    }
  })

  if results.status then
    if #results.data >= 1 then
      return results.data
    end
  end
  return nil
end

function Character:GetAllComponents()
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[
      SELECT *
      FROM `character_components`
      WHERE `char_id` = :charid
    ]],
    data = {
      charid = self.id
    }
  })

  if results.status then
    if #results.data >= 1 then
      return results.data
    end
  end
  return nil
end

function Character:GetAllProps()
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[
      SELECT *
      FROM `character_props`
      WHERE `char_id` = :charid
    ]],
    data = {
      charid = self.id
    }
  })

  if results.status then
    if #results.data >= 1 then
      return results.data
    end
  end
  return nil
end

function Character:GetParents()
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[
      SELECT *
      FROM `character_parents`
      WHERE `char_id` = :charid
    ]],
    data = {
      charid = self.id
    }
  })

  if results.status then
    if #results.data >= 1 then
      return results.data
    end
  end
  return nil
end

function Character:GetFeatures()
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[
      SELECT *
      FROM `character_features`
      WHERE `char_id` = :charid
    ]],
    data = {
      charid = self.id
    }
  })

  if results.status then
    if #results.data >= 1 then
      return results.data
    end
  end
  return nil
end

function Character:GetOverlays()
  local results = exports.ExternalSQL:AsyncQuery({
    query = [[
      SELECT *
      FROM `character_overlays`
      WHERE `char_id` = :charid
    ]],
    data = {
      charid = self.id
    }
  })

  if results.status then
    if #results.data >= 1 then
      return results.data
    end
  end
  return nil
end

function Character:Update(key, value)

end

function Character:Delete()

end

function Character:Save()
  
end