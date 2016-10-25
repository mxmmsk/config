
Macro
{
  key="F4";
  area="Shell Search";
  flags="EnableOutput";
  description="Auto lock editor to read-only on some locations";
  condition=function(key) return not APanel.Plugin end;
action=function()
  Keys("F4")
  if Editor then
    if (mf.substr(Editor.FileName,0,2)=="P:") then
      Keys("CtrlL")
    end
  end
end;
}
