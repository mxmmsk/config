
local EditFind   = "E4ABD267-C2F9-4158-818F-B0E040A2AB9F"
local FarColorer = "D2F36B62-A470-418D-83A3-ED7A3710E5B5"

-- Макросы для хождения по исходникам, открытия c[pp]<-->h[pp] файлов,
-- использования закладок, и пр.

-- !!Warning!! Многие макросы используют Colorer
-- Предполагается, что плагину Colorer назначена горячая клавиша 'o'

Macro {
	area="Editor";
	key="AltShift/";
	description="Jump to block start/end";
action=function()
  --F11 o 2
  Plugin.Menu(FarColorer)
  Keys("2")
end;
}

Macro {
	area="Editor";
	key="Alt/";
	description="Select block";
action=function()
  --F11 o 3
  Plugin.Menu(FarColorer)
  Keys("3")
end;
}

Macro {
	area="Editor";
	key="CtrlAltL";
	description="Show Far Colorer types";
action=function()
  --F11 o 1
  Plugin.Menu(FarColorer)
  Keys("1 CtrlAltF")
end;
}

Macro
{
  area="Editor";
  key="CtrlAltO";
  description="Enable/Disable Far Colorer";
action=function()
  --F11 o
  Plugin.Menu(FarColorer)
  Keys("C Space Enter")
end;
}

Macro {
    area="Editor";
    key="/[LR]Ctrl[0123456789]/";
    kescription="Extend std. bookmarks with stack bookmarks";
action = function()
  BM.Add()
  Keys(akey(1))
end;
}

Macro
{
    area="Editor";
    key="CtrlAltLeft";
    description="Previous 'stack' bookmark";
action = function()
  BM.Back()
end;
}

Macro
{
    area="Editor";
    key="CtrlAltRight";
    description="Next 'stack' bookmark";
action = function()
  BM.Next()
end;
}


Macro
{
    area="Editor";
    key="AltF7";
    description="Jump to function using Colorer Outliner";
action = function()
  BM.Add()
  --mmode(3,1)
  I = Plugin.Menu(FarColorer);
  if I then  Keys("5") end
end;
}


Macro
{
    area="Editor";
    key="CtrlAltUp";
    description="Jump to previous function using Colorer Outliner";
action = function()
  BM.Add()
  --F11 o 5 Up Enter
  if band(Editor.State, 0x30) ~= 0 then
    Keys("CtrlU")
  end
  Plugin.Menu(FarColorer,"45453CAC-499D-4B37-82B8-0A77F7BD087C")
  Keys("5 Up Enter")
end;
}

Macro
{
    area="Editor";
    key="CtrlAltDown";
    fescription="Jump to next function using Colorer Outliner";
action = function()
  BM.Add()
  --F11 o 5 Down Enter
  if band(Editor.State, 0x30) ~= 0 then
    Keys("CtrlU")
  end
  Plugin.Menu(FarColorer,"45453CAC-499D-4B37-82B8-0A77F7BD087C")
  Keys("5 Down Enter")
end;
}


Macro
{
    area="Editor";
    key="AltG";
    description="Jump to function body";
action = function()
  -- BM.add() F11 o 8
  BM.Add()
  --F11 o 8
  Plugin.Menu(FarColorer,"45453CAC-499D-4B37-82B8-0A77F7BD087C")
  Keys("8")
end;
}


Macro
{
    area="Editor";
    key="AltO";
    description="Switch between *.c[pp] and *.h[pp]";
action = function()
  cur=Editor.FileName; dpf=mf.fsplit(cur,7); ext=mf.ucase(mf.fsplit(cur,8));
  if  ext==".CPP"  or  ext==".C"  or  ext==".H"  or  ext==".HPP" then 
    if  ext==".CPP" then 
      new=dpf..".h";
      if not mf.fexist(new) then 
        new=dpf..".hpp";
      end
    else
      new=dpf..".cpp";
      if not mf.fexist(new) then 
        new=dpf..".c";
      end
    end
    if mf.fexist(new) then 
      if  APanel.Plugin  and  APanel.Prefix~="tmp" then 
        Panel.SetPath(0,mf.fsplit(cur,3),mf.fsplit(cur,12))
      end
      --TODO: Добавить поддержку ConEmu (FindEditor)
      Keys("ShiftF4") print(new) Keys("Enter")
      if  Area.Dialog then 
        if   not (Dlg.ItemCount == 7  and  Object.Title == "Editor"  and  Dlg.CurPos == 5  and  Dlg.ItemType == 7) then 
          msgbox("Dialog","Count="..Dlg.ItemCount.."; CurPos="..Dlg.CurPos.."; ItemType="..Dlg.ItemType)
        else
          Keys("Enter")
        end
      end
    end
  end
end;
}


Macro
{
    area="Editor";
    key="ShiftF7 F3";
    description="EditorFind: Продолжить последнее действие (поиск/замена)";
action = function()
  BM.Add()
  Plugin.Call(EditFind,5)
end;
}

Macro
{
    area="Editor";
    key="AltShiftF7";
    description="EditorFind: Продолжить назад последнее действие (поиск/замена)";
action = function()
  BM.Add()
  Plugin.Call(EditFind,6)
end;
}


Macro
{
    area="Editor";
    key="CtrlAltF8";
    description="Go to position";
action = function()
  -- AltF8
  Keys("AltF8")
end;
}


Macro
{
    area="Editor";
    key="CtrlAltShiftLeft";
    description="Scroll editor window leftward";
action = function()
  Editor.Pos(1,5,Editor.Pos(0,5)-1);
end;
}


Macro
{
    area="Editor";
    key="CtrlAltShiftRight";
    description="Scroll editor window rightward";
action = function()
  Editor.Pos(1,5,Editor.Pos(0,5)+1);
end;
}


Macro
{
    area="Editor";
    key="CtrlF1";
    description="Active Help";
action = function()
    Keys("F11")
    if  mf.lcase(mf.env("FARLANG"))=="english" then 
      pn="Active-Help";
    else
      pn="Активная-Помощь";
    end
    if  Menu.Select(pn,2)>0 then 
      Keys("Enter Multiply")
    else
      msgbox("Active-Help","Плагин не найден в списке")
    end
end;
}


Macro
{
    area="Editor";
    key="CtrlF7";
    description="EditorFind: Если есть выделение - 'Replace word...', иначе 'Replace...'";
action = function()
  -- %s=Selected;  F11  $if (menu.Select("Editor Find",2)<=0) MsgBox("Editor Find","Plugin was not found in list!",1) $Exit $end  Enter $if (%s) 4 $else 3 $end
  BM.Add()
  s=Object.Selected;
  I=Plugin.Call(EditFind,mf.iif(s,4,3));
  --F11
  --$if (menu.Select("Editor Find",2)<=0)
  --  MsgBox("Editor Find","Plugin was not found in list!",1) $Exit
  --$end
  --Enter
  --$if (%s)
  --  4
  --$else
  --  3
  --$end
end;
}


Macro
{
    area="Editor";
    key="F7";
    description="EditorFind: Если есть выделение - 'Find word...', иначе 'Find...'";
action = function()
  -- %s=Selected;  F11  $if (menu.Select("Editor Find",2)<=0) MsgBox("Editor Find","Plugin was not found in list!",1) $Exit $end  Enter $if (%s) 2 $else 1 $end
  BM.Add()
  s=Object.Selected;
  I=Plugin.Call(EditFind,mf.iif(s,2,1));
  --Plugin.Menu(#%EditFind,"C584AB47-B6EB-4B62-9F8C-AEF336FE4D65")
  --F11
  --$if (menu.Select("Editor Find",2)<=0)
  --  MsgBox("Editor Find","Plugin was not found in list!",1) $Exit
  --$end
  --Enter
  --$if (%s)
  --  2
  --$else
  --  1
  --$end
end;
}

Macro
{
    area="Editor";
    key="CtrlG";
    description="EditorFind: Искать конфликты git-merge";
action = function()
  BM.Add();
  Plugin.Call(EditFind, "WholeWords:0 RegExp:1 CaseSensitive:0 Entire:1 Find:\"^(<<<<<<<|=======|>>>>>>>)\"");
end;
}

Macro
{
    area="Editor";
    key="CtrlAltF7";
    description="EditorFind: Начать поиск по clip() или выделению";
action = function()
  BM.Add()
  s="";
  if  Editor.Sel(0,4)==1  and  Editor.SelValue~="" then 
    s=mf.trim(Editor.SelValue);
  end
  if  s=="" then 
    if  _G.EditClipboardMode==1  or  _G.EditClipboardMode==2 then  mf.clip(5,_G.EditClipboardMode) end
    s=mf.trim(mf.clip(0));
  end
  if  s=="" then 
    msgbox("CtrlAltF7","Текст не выделен, буфер обмена пуст\nИскать нечего")
    exit()
  end
  Plugin.Call(EditFind, "WholeWords:1 RegExp:0 CaseSensitive:1 Entire:1 Find:\""..mf.replace(s,"\"","\"\"").."\"");
end;
}

Macro
{
    area="Editor";
--    key="Home"
--    disableOutput=1
--    Condition="Selected:1"
action = function()
  -- Editor.Sel(4) $AKey
  Editor.Sel(4)
  Keys(akey(1))
end;
}


Macro
{
    description="Добавить закладку и перейти в начало файла";
    area="Editor";
    key="CtrlHome";
action = function()
  BM.Add() Keys("CtrlHome")
end;
}

Macro
{
    description="Добавить закладку и перейти в конец файла";
    area="Editor";
    key="CtrlEnd";
action = function()
  BM.Add() Keys("CtrlEnd")
end;
}

--Не срабатывает переход по RCtrlHome/End
--Macro
--    Area="Editor"
--    Key="CtrlHome CtrlEnd"
--    DisableOutput=1
--{{
--  BM.Add() Eval(Key(#AKey))
--}}


Macro
{
    area="Editor";
    key="Left";
    description="VStudio style: When block selected - unselect and move to block start";
    flags="EVSelection";
action = function()
  BM.Add() Editor.Sel(1,0) Editor.Sel(4)
end;
}


Macro
{
    area="Editor";
    key="Right";
    description="VStudio style: When block selected - unselect and move to block end";
    flags="EVSelection";
action = function()
  BM.Add() Editor.Sel(1,1) Editor.Sel(4)
end;
}


Macro
{
    area="Editor";
    key="ShiftEnter";
    description="Simple Enter";
condition = function(Key)
  return band(Editor.State,0x200) == 0;
end;
action = function()
  Keys("Enter")
end;
}


Macro
{
  area="Editor";
  key="CtrlShiftL";
  description="Make text lowercase'd";
  flags="EVSelection";
action = function()
  Editor.Undo(0)
  s = mf.lcase(Editor.SelValue)
  print(s)
  Editor.Undo(1)
end;
}
