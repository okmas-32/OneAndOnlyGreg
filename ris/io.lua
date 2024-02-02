local json = require("lib.json")
local net = require("internet")
local rtvars = require("lib.rtvars")

local _ULR_BASE = rtvars.get("ris", "IO_URL_BASE")

local risio = {}

local function handleTransfer(handle)
  local data = {}

  for chunk in handle do
    table.insert(data, chunk)
  end

  return table.concat(data)
end

function risio.get(cesta)
  local handle = net.request(_ULR_BASE .. cesta)
  return json.decode(handleTransfer(handle))
end

function risio.put(cesta, data)
  local jdata = json.encode(data)
  --print(jdata)
  local handle = net.request(_ULR_BASE .. cesta, jdata, {}, "PUT")

  return json.decode(handleTransfer(handle))
end

return risio
