local switch = {}
local _switch = {
  __index = switch
}

function switch.new(id)
  local o = {
    id = id,
    state = false
  }

  return setmetatable(o, _switch)
end

function switch:getState()
  return self.state
end

function switch:update()
  local status = switch.ris.io.get("status")
  self.state = status[self.id]
end

return switch
