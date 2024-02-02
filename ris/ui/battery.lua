local battery = {}

local _battery = {
  __index = battery
}
function battery.new(name)
  local o = {
    name = name,
    stored = 0,
    avgOut = 0
  }
  return setmetatable(o, _battery)
end

function battery:update(stored, avgOut)
  self.avgOut = avgOut
  self.stored = stored

  battery.ris.io.put("update", {target=self.name, value={stored=stored, out=avgOut}})
end

function battery:updateStored(value)
  self.stored = value
  battery.ris.io.put("update", {target=self.name, value={stored=value, out=self.avgOut}})
end

function battery:updateAvgOut(value)
  self.avgOut = value
  battery.ris.io.put("update", {target=self.name, value={out=value, stored=self.stored}})
end

return battery
