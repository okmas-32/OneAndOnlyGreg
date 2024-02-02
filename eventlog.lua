local json = require("lib.json")
local term = require("term")
local event = require("event")

--[[ DOCS
  file io: https://ocdoc.cil.li/api:non-standard-lua-libs#input_and_output_facilities
  "graphics": https://ocdoc.cil.li/api:term
  """graphics" utils"": https://ocdoc.cil.li/api:text
]]

--[[  CHAT WINDOW
bajo jajo
]]

local data = {}

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
end

---@param date string full date of event
---@param title string short title of event
---@param desc string long description
---@param guilty string person guilty for the event
---@param tags table array of tags 
---@return boolean,string returns false and error message on error otherwise
local function newEntry(date, title, desc, guilty, tags)

  -- Check if there was any input
  if (#date == 0) and (#title == 0) and (#desc == 0) and (#guilty == 0) and (#tags == 0) then
    print("")
    return false, "E: parameters were empty" 
  end
  
  local evData = {
    datum = date or "",
    nazov = title or "",
    popis = desc or "",
    pachatel = guilty or "",
    tagy = tags or {""}
  }

  table.insert(data, evData)
  saveData()
  return true
end


---@param tbl table Table to be prionted
---@param rootName string|nil Name of the base object
---@param level number|nil depth of the scope
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

local function display()
  
  -- sort table
  table.sort( data ,function(a, b)
      return a["datum"] > b["datum"]
    end
  )
  
  local function filter(name, ...)
    return name == "key_down"
  end

  for _, v in ipairs(data) do
    term.clear()
    local width, height, x_offset, y_offset, relative_x,relative_y = term.getViewport()

    term.setCursor(2, 2)
    print("nazov eventu: " .. v["nazov"])
    print(" datum: "..v["datum"])
    print(" pachatel: "..v["pachatel"])
    print(" popis: "..v["popis"])
    print(" tagy: "..table.concat(v["tagy"], ", "))

    local e = {event.pullFiltered(filter)}
    if e[3] == 113 then break end
  end
end

local function cli_mkEvent()
  print("Enter day of the event:")
  local date = io.read("*l") or ""
  print("Enter title of the event:")
  local title = io.read("*l") or ""
  print("Enter description of the event:")
  local description = io.read("*l") or ""
  print("Enter guilty of the event:")
  local guilty = io.read("*l") or ""
  
  print("Enter tag of the event:")
  local tagsStr = io.read("*l") or ""
  local tags = {}
  for tag in tagsStr:gmatch("([^,]+),?")do
    table.insert(tags, tag)
  end

  local status, error = newEntry(date, title, description, guilty, tags)
  if not status then print(error) end
  return {}
end

local function main(args)
  loadData()

  if args[1] == "new" then
    cli_mkEvent()
  elseif args[1] == "print" then
    display()
  else
    print("\nUsage: eventlog [OPTION]\n eventlog new (creates new event to log)\n eventlog print (will print all loget events)")
  end
  print("")
  
  --[[
    local inputs = {}
    while true do
      display(inputs)
      inputs = processInput()
  
      if inputs.exit then break end
    end
  ]]--
  
end

main({...})

