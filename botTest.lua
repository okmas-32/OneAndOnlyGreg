package.loaded["lib.json"] = nil

package.loaded["ris"] = nil
package.loaded["ris.io"] = nil
package.loaded["ris.ui.battery"] = nil
package.loaded["ris.ui.switch"] = nil
package.loaded["ris.discord"] = nil

local ris = require("ris")
local msg = table.concat({...}, " ") -- spoj vsetky argumenty do stringu
ris.discord.sendMsg(msg)
