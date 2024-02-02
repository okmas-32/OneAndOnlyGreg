local json = require("lib.json")

--[[ DOCS
  file io: https://ocdoc.cil.li/api:non-standard-lua-libs#input_and_output_facilities
  "graphics": https://ocdoc.cil.li/api:term
  """graphics" utils"": https://ocdoc.cil.li/api:text
]]

--[[  CHAT WINDOW
bajo jajo
]]

local data

local function loadData()
  -- Read file
  local fh = io.open("eventlog.json", "r")
  if not fh then return {} end
  local strData = fh:read("*a")

  fh:close()

  data = json.decode(strData)

  return data
end

local function saveData()
  -- Open file
  local fh = io.open("eventlog.json", "w")
  if not fh then error("Cant write file: ") end
  
  local strData = json.encode(data)
  fh:write(strData)

  fh:close()

  return {}
end

---@param date string full date of event
---@param title string short title of event
---@param desc string long description
---@param guilty string person guilty for the event
---@param tags string 
local function newEntry(date, title, desc, guilty, tags)
  local evData = {
    datum = date,
    nazov = title,
    popis = desc,
    pachatel = guilty,
    tagy = tags
  }

  table.insert(data, evData)
  saveData()
end

local function display()

end


local function processInput()

  return true
end

---@param tbl table Table to be prionted
---@param rootName string Name of the root object
local function printTable(tbl, rootName, level)
  level = level or 0
  rootName = rootName or "root"
  for k, v in pairs(tbl) do
    if type(v) == "table" then
      printTable(v, rootName .. "." .. k, level + 1)
    else
      -- datum    2023.11.27
      print(string.rep("\t", level) .. rootName.. "." .. k, v)
    end
  end
end

local function main(args)
  loadData()

  local inputs = {}
  while true do
    display(inputs)
    inputs = processInput()

    if inputs.exit then break end
  end
end

main({...})

