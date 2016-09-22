
Macro {
  area="Shell";
  key="Tab";
  description="CmdLine: Tab completion if panels are off";
  flags="NotEmptyCommandLine";
condition=function()
  return not(APanel.Visible or PPanel.Visible)
end; 
action=function()
  Keys("CtrlSpace")
end;
}
