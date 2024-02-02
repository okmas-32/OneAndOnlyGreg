local component = require("component")

local me = component.me_interface

for k, v in pairs(me:itemsIterator()) do
  print(k, v)
end


