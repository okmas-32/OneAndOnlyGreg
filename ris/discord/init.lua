local discord = {}

local function printTable(t, parent)
  parent = parent or "root"
  for k, v in pairs(t) do
    if type(v) == "table" then
      printTable(v, parent .. k)
    else
      print(k, v)
    end
  end
end

function discord.sendMsg(text)
  discord.ris.io.put("notify", {msg=text})
end

return discord
