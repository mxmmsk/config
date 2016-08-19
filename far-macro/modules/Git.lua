
local M = {}

local aliases    = "|gd|gdc|gsh|gl|gln|glb|glbr|gl5|gl10|gbr|gst|"

function KnownGitAlias(cmdline)
  local i = mf.index(cmdline," ")
  if i > 4 or (i ~= -1 and i < 2) then return false end
  local cmd = mf.lcase(mf.trim(mf.substr(cmdline,0,i)))
  if i > 0 then cmd = mf.lcase(mf.trim(mf.substr(cmdline,0,i))) else cmd = mf.lcase(mf.trim(cmdline)) end
  i = mf.index(aliases, "|"..cmd.."|")
  if i >= 0 then return true end
  return false
end
M.KnownGitAlias = KnownGitAlias

local function KnownGitAliasXlat(cmdline)
  local i = mf.index(cmdline," ")
  if i > 4 or (i ~= -1 and i < 2) then return false end
  local cmd = mf.lcase(mf.trim(mf.substr(cmdline,0,i)))
  if i > 0 then cmd = mf.lcase(mf.trim(mf.substr(cmdline,0,i))) else cmd = mf.lcase(mf.trim(cmdline)) end
  i = mf.index(far.XLat(aliases), "|"..cmd.."|")
  if i >= 0 then return true end
  return false
end
M.KnownGitAliasXlat = KnownGitAliasXlat
 
return M
