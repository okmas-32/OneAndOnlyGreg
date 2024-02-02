local json = require("json")

local rtvars = {
  __DEFAULT_FILEPATH = ""
}

---@param path string|nil path pointing to rtvars file, uses default if nil
---@return table rtvars table
function rtvars.load(path)
  path = path or rtvars.__DEFAULT_FILEPATH

  local fhnd = io.open(path, "r")
  local strEnv = fhnd:read("*a")
  fhnd:close()

  local tblEnv = json.decode(strEnv)

  return tblEnv
end

---@param category string category name in the root array
---@param key string name of the variable
---@return any value from rtvars
function rtvars.get(category, key)
  return rtvars.load()[category][key]
end



return rtvars
