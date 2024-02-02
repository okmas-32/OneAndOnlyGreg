local lfs = require("lfs")

local _ignore_list = {".filelistignore"}

local function isIgnored(path)
  if path == "." or path == ".." then
    return true
  end
  for _, v in pairs(_ignore_list) do
    if path:find(v, 1) then
      return true
    end
  end

  return false
end

local function listFiles(dir, list)
  list = list or {}

  for entry in lfs.dir(dir) do
    local entryPath = dir .. "/" .. entry
    if not isIgnored(entry) and not isIgnored(entryPath) then
      local attr = lfs.attributes(entryPath)
      assert (type(attr) == "table")
      if attr.mode == "directory" then
          listFiles(entryPath, list)
      else
        table.insert(list, entryPath:sub(3))
      end
    end
  end

  table.sort(list)
  return list
end

local function loadIgnores()
  for line in io.lines(".filelistignore") do
    table.insert(_ignore_list, line)
  end
end

local function main(args)
  loadIgnores()
  local list = listFiles(".")

  local fhList = io.open("filelist.txt", "w")

  for _, v in ipairs(list) do
    fhList:write(v, "\n")
  end

  fhList:close()
end

main({...})
