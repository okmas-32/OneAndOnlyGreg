local net = require("internet")
local rtvars = require("lib.rtvars")

local _ULR_BASE = rtvars.get("sync2", "URL_BASE")

local function download(cesta)
  local url = string.format(_ULR_BASE, cesta)
  local handle = net.request(url)

  local data = {}

  for chunk in handle do
    table.insert(data, chunk)
  end

  return table.concat(data)
end

local function main()
  for fileName in download("filelist.txt"):gmatch("([^\n]+)\n") do
    io.write("Stahujem: ", fileName, "\n")

    local fh = io.open(fileName, "w")
    fh:write(download(fileName))
    fh:close()
  end
end

main()
