
Macro {
  area="Shell";
  key="Tab";
  description="CmdLine: Tab completion if panels are off";
condition=function()
  return not(APanel.Visible or PPanel.Visible)
end; 
action=function()
  Keys("CtrlSpace")
end;
}
