local ris = {
  io = require("ris.io"),
  ui = {
    battery = require("ris.ui.battery"),
    switch = require("ris.ui.switch")
  },
  discord = require("ris.discord")
}

function ris.getStatus()
  local status = rio.get("status")
  return status
end

function ris.update(target, value)
  local status = rio.put("update", {target = target, value = value})
  return status
end

return (function()
  for _, v in pairs(ris.ui) do
    v.ris = ris
  end
  ris.discord.ris = ris

  return ris
end)()
