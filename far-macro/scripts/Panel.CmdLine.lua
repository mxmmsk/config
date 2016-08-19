
Macro
{
  description="Jump Home/End if cmdline is not empty";
  area="Shell";
  key="Home End";
  flags="NotEmptyCommandLine";
action=function()
  Keys("Ctrl"..akey(1,1))
end;
}

Macro
{
  description="Left/Right if cmdline is not empty";
  area="Shell";
  key="Left Right";
  flags="NotEmptyCommandLine";
action=function()
  Keys((akey(1,1) == "Left") and "CtrlS" or "CtrlD")
end;
}
