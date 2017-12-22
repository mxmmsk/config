
local GitMacros = require("Git")

Macro {
  area="Shell QView";
  key="AltEnter";
  flags="NotEmptyCommandLine";
  description="Execute command and send output to Editor";
action = function()
  local cmdLine = CmdLine.Value
  if mf.substr(cmdLine,0,6):lower()~="edit:<" then
    Keys('CtrlHome')
    print("edit:<")
    cmdLine = "edit:<"..cmdLine
  end
  Keys("Enter")
  if not Area.Editor then
    return
  end
  -- Plugin.SyncCall("4b675d80-1d4a-4ea9-8436-fdc23f2fc14b","Rename 0 \""..cmdLine.."\"")
  Editor.SetTitle(cmdLine)
  if GitMacros.KnownGitAlias(cmdLine) then
    Keys("CtrlL")
  end
end;
}
