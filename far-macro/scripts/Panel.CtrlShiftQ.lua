
Macro
{
  key="CtrlShiftQ";
  area="Shell Search";
  flags="EnableOutput";
  description="Open note txt-file";
  condition=function(key) return not APanel.Plugin end;
action=function()
  Keys("ShiftF4")
  print(mf.env("USERPROFILE")..[[\Documents\Notes\]]..mf.date("%Y-%m0-%d-%H-%M-%S.txt"))
  Keys("Enter")
end;
}
