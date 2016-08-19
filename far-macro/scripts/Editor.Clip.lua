
-- Файлик предназначен для переключения режима буфера обмена для редактора.
-- AltShiftIns - выбрать используемый буфер обмена
-- Обрабатываются: CtrlIns/CtrlC, ShiftIns/CtrlV, ShiftDel/CtrlX

--Macro
--    Area="Editor"
--    Key="AltShiftIns"
--    Description="Switch of use OS/internal clipboard buffer"
--{{
--    %os = "Use &OS clipboard";
--    %int = "Use &Far internal clipboard";
--    $if (%%EditClipboardMode!=1 && %%EditClipboardMode!=2) %%EditClipboardMode=1; $end
--	%s=Menu.Show(%os+"\r\n"+%int,"AltShiftIns",0,%%EditClipboardMode);
--	$if (%s==%os)
--	  %%EditClipboardMode=1;
--	$end
--	$if (%s==%int)
--	  %%EditClipboardMode=2;
--	$end
--}}
--
--
--Macro
--    Area="Editor"
--    Key="CtrlC CtrlIns"
--    Description="Copy to active clipboard"
--{{
--  $if (%%EditClipboardMode==1 || %%EditClipboardMode==2) clip(5,%%EditClipboardMode) $end
--  CtrlIns
--}}
--
--Macro
--    Area="Editor"
--    Key="CtrlX ShiftDel"
--    Description="Cut to active clipboard"
--{{
--  $if (%%EditClipboardMode==1 || %%EditClipboardMode==2) clip(5,%%EditClipboardMode) $end
--  ShiftDel
--}}
--
--Macro
--    Area="Editor"
--    Key="CtrlV ShiftIns"
--    Description="Paste from active clipboard"
--{{
--  $if (%%EditClipboardMode==1 || %%EditClipboardMode==2)
--    clip(5,%%EditClipboardMode)
--    $if (%%EditClipboardMode==1)
--      // Коррекция поломанного русского текста (ClipFixer)
--      callplugin(0x436C4678,0)
--    $end
--  $end
--  ShiftIns
--}}


Macro
{
    area="Editor";
--    Key="MsRClick"
    description="Copy selected text of paste in clicked position when no selection present";
action=function()
  -- $if (Selected) CtrlIns $else MsLClick ShiftIns $end
  if  Object.Selected then 
    Keys("CtrlIns")
  else
    Keys("MsLClick ShiftIns")
  end
end;
}


Macro
{
  area="Editor";
  key="F5";
  description="*.l10n: Duplicate (copy) current line or lines from selection";
  flags="NoSendKeysToPlugins";
condition = function()
  local s = mf.ucase(mf.fsplit(Editor.FileName, 8));
  if s ~= ".L10N" then return false end
  return (mf.substr(mf.trim(Editor.Value),0,5)=="\"en\":")
end;
action=function()
  Editor.Undo(0)
  mf.clip(5,2) -- внутренний буфер
  pos = Editor.Pos(0,2);
  Keys("CtrlU Home ShiftDown CtrlIns CtrlU ShiftIns Up")
  -- Copying "en" line in the *.l10n
  if mf.substr(mf.trim(Editor.Value),0,5)=="\"en\":" then
    Keys("Home CtrlRight Right CtrlShiftRight")
    print("ru")
    Keys("CtrlRight Right")
  end
  Editor.Undo(1)
end;
}

Macro
{
  area="Editor";
  key="F5";
  description="Duplicate (copy) current line or lines from selection";
  flags="NoSendKeysToPlugins";
condition = function() return (mf.ucase(mf.fsplit(Editor.FileName, 8)) ~= ".L10N") end;
action=function()
  mf.clip(5,2) -- внутренний буфер
  pos = Editor.Pos(0,2);
  if Object.Selected then 
    -- sel(0,0)=30; sel(0,1)=1; sel(0,2)=31; sel(0,3)=0; sel(0,4)=1
    if  Editor.Sel(0,4)==1 then 
      -- обычный блок
      l1 = Editor.Sel(0,0);
      l2 = Editor.Sel(0,2);
      if  Editor.Sel(0,3)>0 then  l2=l2+1; end
    else
      -- вертикальный блок
      l1 = Editor.Sel(0,0);
      l2 = Editor.Sel(0,2);
    end
    -- Пометить строки целиком
    Editor.Sel(4)
    Editor.Pos(1,1,l1) Editor.Pos(1,2,1) Editor.Sel(2,0)
    Editor.Pos(1,1,l2) Editor.Pos(1,2,1) Editor.Sel(2,1)
    Keys("CtrlIns")
    Editor.Sel(1,1) Editor.Sel(4)
    Keys("ShiftIns")
  else
    Keys("CtrlU Home ShiftDown CtrlIns CtrlU ShiftIns Up")
  end
  Editor.Pos(1,2,pos)
end;
}

Macro  
{
  description="Editor: Move selected lines, or just the current line, one line up (c) vsg";
--  Key="CtrlShiftUp"
  area="Editor";
action=function()
  y=Editor.Pos(0, 1); x=Editor.Pos(0, 2); y1=Editor.Sel(0, 0); x1=Editor.Sel(0, 1); y2=Editor.Sel(0, 2); x2=Editor.Sel(0, 3)+1; if  Object.Selected  and  (y >= y1  and  y <= y2) then    if  y1 == 1 then  exit() end   Keys("CtrlU") mf.clip(5, 0)   Editor.Pos(1, 1, y1) Editor.Pos(1, 2, 1) Keys("ShiftUp CtrlX")   if  x2 > 1 then  Editor.Pos(1, 1, y2-1) else Editor.Pos(1, 1, y2-2) end   Keys("End Enter") Editor.Pos(1, 2, 1) Keys("CtrlV CtrlU BS")   Editor.Pos(1, 1, y1-1) Editor.Pos(1, 2, x1) Editor.Sel(2, 0)   Editor.Pos(1, 1, y2-1) Editor.Pos(1, 2, x2) Editor.Sel(2, 1)   Editor.Pos(1, 1, y-1) Editor.Pos(1, 2, x) else   if  y == 1 then  exit() end   Keys("CtrlU") mf.clip(5, 0)   Editor.Pos(1, 2, 1) Keys("ShiftUp CtrlX   End Enter") Editor.Pos(1, 2, 1) Keys("CtrlV CtrlU BS   Up") Editor.Pos(1, 2, x) end  
end;
}

Macro
{
  description="Editor: Move selected lines, or just the current line, one line down (c) vsg";
--  Key="CtrlShiftDown"
  area="Editor";
action=function()
  y=Editor.Pos(0, 1); x=Editor.Pos(0, 2); y1=Editor.Sel(0, 0); x1=Editor.Sel(0, 1); y2=Editor.Sel(0, 2); x2=Editor.Sel(0, 3)+1; if  Object.Selected  and  (y >= y1  and  y <= y2) then    if  x2 > 1  and  y2 == Editor.Lines then  exit() end   Keys("CtrlU") mf.clip(5, 0)   if  x2 > 1 then  Editor.Pos(1, 1, y2+1) else Editor.Pos(1, 1, y2) end   Editor.Pos(1, 2, 1) Keys("ShiftEnd CtrlX BS")   Editor.Pos(1, 1, y1) Editor.Pos(1, 2, 1) Keys("Enter Up") Editor.Pos(1, 2, 1)   Keys("CtrlV CtrlU")   Editor.Pos(1, 1, y1+1) Editor.Pos(1, 2, x1) Editor.Sel(2, 0)   if  x2 <= 1  and  y2 == Editor.Lines then       Editor.Pos(1, 1, y2) Keys("End") Editor.Sel(2, 1)   else     Editor.Pos(1, 1, y2+1) Editor.Pos(1, 2, x2) Editor.Sel(2, 1)   end   Editor.Pos(1, 1, y+1) Editor.Pos(1, 2, x) else   if  y == Editor.Lines then  exit() end   Keys("CtrlU") mf.clip(5, 0)   Editor.Pos(1, 2, 1) Keys("ShiftDown CtrlX   End Enter") Editor.Pos(1, 2, 1) Keys("CtrlV CtrlU BS")   Editor.Pos(1, 2, x) end
end;
}
