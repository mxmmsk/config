
Macro
{
  description="CmdLine: Switch active panel when panels are hidden";
  area="Shell";
  key="Tab";
  flags="EmptyCommandLine";
condition=function(Key)
  return not(APanel.Visible or PPanel.Visible)
end;
action=function()
  Keys("CtrlO Tab CtrlO")
end;
}
