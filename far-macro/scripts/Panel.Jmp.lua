
-- Support .jmp files (just a path)

Macro
{
  area="Shell";
  description="Process .jmp files";
  key="Enter";
  flags="EmptyCommandLine|NoPluginPanels|NoFolders";
condition=function()
  if APanel.Empty then return false end
  return mf.lcase(mf.fsplit(APanel.Current,8))==".jmp"
end;
action=function()
  src = APanel.Path.."\\"..APanel.Current;
  local f = io.open(src)
  if not (f) then
    msgbox("Can't find file",src)
    return
  end
  local text = assert(f:read("*a"))
  f:close()
  if mf.asc(text)==65279 then text = mf.substr(text,1) end
  --msgbox(APanel.Current,"'"..text.."'\n".."Asc="..mf.asc(text))
  Panel.SetPath(0,text)
end;
}
