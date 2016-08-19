
local GitMacros = require("Git")

Macro {
  area="Shell QView";
  key="AltEnter";
  flags="NotEmptyCommandLine";
  description="Execute command and send output to Editor";
action = function()
  local cmdLine = CmdLine.Value
  Keys('CtrlHome')
  print("edit:<")
  Keys("Enter")
  if GitMacros.KnownGitAlias(cmdLine) then
    Keys("CtrlL")
  end
end;
}
