
local EditorFind = "E4ABD267-C2F9-4158-818F-B0E040A2AB9F"

-- EditorFind: Если есть подсветка - сбросить, иначе закрыть редактор (Esc)
Macro
{
  area="Editor";
  key="Esc";
  description="EditorFind: сброс или Esc";
action=function()
  -- reset EditorFind Leap Search
  _G.EditFindLeap="";
  
  -- Call plugin menu
  Plugin.Menu(EditorFind)

  -- Check if menu item "8 Remove highlight" is enabled
  s=Menu.Select("8 ",1);
  if s==8 then 
    -- Yes, highlighting exists, remove it
    Keys("8") Editor.Sel(4)
    if Editor.Sel(0,4)~=0 then
      Editor.Sel(1,0)
      Editor.Sel(4)
    end
  else
    -- Nothing was highlighted, Process to Esc
    Keys("Esc")
    if Editor.Sel(0,4)~=0 then
      Editor.Sel(1,0)
      Editor.Sel(4)
    else
      Keys("Esc")
    end
  end
end;
}
