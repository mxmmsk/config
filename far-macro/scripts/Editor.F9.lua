
Macro {
  area="Editor";
  key="F9 F2";
  description="Reload colorer schemas";
condition = function() local s = mf.ucase(mf.fsplit(Editor.FileName, 8)); return (s == ".HRC" or s == ".HRD") end;
action = function()
  -- Если изменен - сохранить
  if band(Editor.State,8) then
    Keys("F2")
  end
  --
  Plugin.Menu("D2F36B62-A470-418D-83A3-ED7A3710E5B5","45453CAC-499D-4B37-82B8-0A77F7BD087C")
  if Area.Menu and Menu.Id=="45453CAC-499D-4B37-82B8-0A77F7BD087C" then
    Keys("R")
    --Не требуется, раскраска обновится после переключения в следующий редактор
    --Plugin.Menu("D2F36B62-A470-418D-83A3-ED7A3710E5B5","45453CAC-499D-4B37-82B8-0A77F7BD087C")
    --if Area.Menu and Menu.Id=="45453CAC-499D-4B37-82B8-0A77F7BD087C" then
    --  Keys("9")
    --end
  end
end;
}

Macro {
  area="Editor";
  key="F2 F9";
  description="Save and reload lua macros";
condition = function() return mf.ucase(mf.fsplit(Editor.FileName, 8)) == ".LUA" end;
action = function()
  -- Save file, if it was modified
  if band(Editor.State,8) then
    Keys("F2")
  end
  --
  far.MacroLoadAll()
end;
}

-- Данный макрос сначала сохраняет содержимое редактора (если оно не было сохранено),
-- затем исполняет редактируемый файл как Lua-скрипт.
Macro {
  description="Save and run lua-script from editor";
  area="Editor"; key="CtrlF9";
condition=function(Key) return mf.ucase(mf.fsplit(Editor.FileName, 8))==".LUA" end;
action=function()
  for k=1,2 do
    local info=editor.GetInfo()
    if bit64.band(info.CurState, far.Flags.ECSTATE_SAVED)~=0 then
      far.MacroPost('@"' .. info.FileName .. '"')
      break
    end
    if k==1 then editor.SaveFile(); end
  end
end;
}
