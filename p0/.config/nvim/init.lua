local v = vim
local g = v.g

-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded = 1
g.loaded_netrwPlugin = 1

-- Config Helpers
-------------------------------------------------
require('xinze.plugins')
require('xinze.keybinds')
require('xinze.settings')

-- Configure Plugins
-------------------------------------------------

-- empty setup using defaults
require("nvim-tree").setup()

---Pretty print lua table
function _G.dump(...)
    local objects = v.tbl_map(v.inspect, { ... })
    print(unpack(objects))
end
