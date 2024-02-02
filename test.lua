package.loaded["lib.json"] = nil

package.loaded["ris"] = nil
package.loaded["ris.io"] = nil
package.loaded["ris.ui.battery"] = nil
package.loaded["ris.ui.switch"] = nil

local ris = require("ris")


local bat = ris.ui.battery.new("basePower")
bat:update(100000, 750)

--[[
local switch = ris.ui.switch.new("switch1")
print(switch:getValue())
]]
