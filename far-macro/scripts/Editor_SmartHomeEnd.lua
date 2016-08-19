﻿-------------------------------------------------------------------------------
-- Умные Home & End. © SimSU
-------------------------------------------------------------------------------

---- Настройки
local function Settings()
-- Начало файла Profile\SimSU\Editor_SmartHomeEnd.cfg
return{
  KeyHome="Home"; --PriorHome=50;
  KeyEnd="End"; --PriorEnd=50;
  KeyShiftHome="ShiftHome"; --PriorShiftHome=50;
  KeyAltHome="AltHome AltShiftHome"; --PriorAltHome=50;
  KeyShiftEnd="ShiftEnd"; --PriorShiftEnd=50;
  KeyAltEnd="AltEnd AltShiftEnd"; --PriorAltEnd=50;
}
-- Конец файла Profile\SimSU\Editor_SmartHomeEnd.cfg
end

---- Локализация
_G.far.lang=far.lang or win.GetEnv("farlang")
-- Встроенные языки / Buildin laguages
local function Messages()
if far.lang=="Russian" then
-- Начало файла Profile\SimSU\Editor_SmartHomeEndRussian.lng
return{
  DescrHome="В начало строки или на первую букву. © SimSU";
  DescrEnd="В конец строки или за последнюю букву. © SimSU";
  DescrShiftHome="В начало строки или на первую букву с выделением строчного блока. © SimSU";
  DescrAltHome="В начало строки или на первую букву с выделением вертикального блока. © SimSU";
  DescrShiftEnd="В конец строки или за последнюю букву с выделением строчного блока. © SimSU";
  DescrAltEnd="В конец строки или за последнюю букву с выделением вертикального блока. © SimSU";
}
-- Конец файла Profile\SimSU\Editor_SmartHomeEndRussian.lng
else--if far.lang=="English" then
-- Begin of file Profile\SimSU\Editor_SmartHomeEndEnglish.lng
return{
  DescrHome="В начало строки или на первую букву.";
  DescrEnd="В конец строки или за последнюю букву.";
  DescrShiftHome="В начало строки или на первую букву с выделением строчного блока. © SimSU";
  DescrAltHome="В начало строки или на первую букву с выделением вертикального блока. © SimSU";
  DescrShiftEnd="В конец строки или за последнюю букву с выделением строчного блока. © SimSU";
  DescrAltEnd="В конец строки или за последнюю букву с выделением вертикального блока. © SimSU";
}
-- End of file Profile\SimSU\Editor_SmartHomeEndEnglish.lng
end end

local M=(loadfile(win.GetEnv("FARPROFILE").."\\SimSU\\Editor_SmartHomeEnd"..far.lang..".lng") or Messages)()
local S=(loadfile(win.GetEnv("FARLOCALPROFILE").."\\SimSU\\Editor_SmartHomeEnd.cfg") or loadfile(win.GetEnv("FARPROFILE").."\\SimSU\\Editor_SmartHomeEnd.cfg") or Settings)()

local SimSU=SimSU or {}
SimSU.Editor_SmartHomeEnd={}
-------------------------------------------------------------------------------
function SimSU.Editor_SmartHomeEnd.Home()
  Editor.Pos(1,5,1); if Editor.Set(2,-1)==0 and band(Editor.State, 0x30) ~= 0 then Editor.Sel(4) end
  -- Пропустить "-/+" в дифах гита
  local From = 1
  if (".TMP|.DIFF"):find(mf.ucase(mf.fsplit(Editor.FileName, 8)))~=nil then
    if mf.index("-+",mf.substr(Editor.Value,1,1))>=0 then
      From = 2
    end
  end
  --local First=(Editor.Value):cfind("%S")
  local First=(Editor.Value):cfind("%S",From)
  --Editor.Pos(1,2,Editor.RealPos~=First and First or 1)
  if From == 1 or First == nil then
    Editor.Pos(1,2,Editor.RealPos~=First and First or 1)
  else
    Editor.Pos(1,2,Editor.RealPos>=First and 1 or First)
  end
end

function SimSU.Editor_SmartHomeEnd.End()
  if Editor.Set(2,-1)==0 and band(Editor.State, 0x30) ~= 0 then Editor.Sel(4) end
  local Last=(Editor.Value):cfind("%s+$")
  --Editor.Pos(1,2,Editor.RealPos~=Last and Last or (Editor.Value):len()+1)
  Editor.Pos(1,2,(Last~=nil and Editor.RealPos==((Editor.Value):len()+1)) and Last or (Editor.Value):len()+1)
end

function SimSU.Editor_SmartHomeEnd.Select(HomeOrEnd,BlockType)
  local BlockType= BlockType or 1
  local Line=Editor.CurLine; local Pos=Editor.RealPos; local Pos2= BlockType==2 and Editor.CurPos or nil
  local Sel=editor.GetSelection()
  if HomeOrEnd then SimSU.Editor_SmartHomeEnd.Home() else SimSU.Editor_SmartHomeEnd.End() end
  local NewPos=Editor.RealPos; local NewPos2= BlockType==2 and Editor.CurPos or nil
  if Sel and BlockType==2 then Sel.StartPos2=editor.RealToTab(nil,Sel.StartLine,Sel.StartPos); Sel.EndPos2=editor.RealToTab(nil,Sel.EndLine,Sel.EndPos) end
  if not Sel or BlockType~=Sel.BlockType or -- Нет выделения или другой тип блока или
    not ((BlockType==1 and ((Line==Sel.StartLine and Pos==Sel.StartPos) or (Line==Sel.EndLine and Pos==Sel.EndPos+1  or (Sel.EndPos==-1 and Pos==1)))) or (BlockType==2 and (Line==Sel.StartLine or Line==Sel.EndLine) and (Pos==Sel.StartPos or Pos==Sel.EndPos+1))) -- не продолжение (курсос не в углах).
    and not BlockType==2
  then -- Новое выделение.
    editor.Select(nil,BlockType,Line,NewPos>Pos and (Pos2 or Pos) or (NewPos2 or NewPos),NewPos>Pos and (NewPos2 and NewPos2-Pos2 or NewPos-Pos) or (NewPos2 and Pos2-NewPos2 or Pos-NewPos),1)
  elseif Line==Sel.StartLine and Sel.StartLine==Sel.EndLine and Pos==Sel.StartPos then -- Корректируем начало в однострочном блоке.
    editor.Select(nil,BlockType,Sel.StartLine,NewPos2 or NewPos,NewPos2 and Sel.EndPos2-NewPos2+1 or Sel.EndPos-NewPos+1,1)
  elseif (Line==Sel.StartLine and Pos==Sel.StartPos) then                              -- Корректируем начало в многострочном блоке.
    editor.Select(nil,BlockType,Sel.StartLine,NewPos2 or NewPos,NewPos2 and Sel.EndPos2-NewPos2+1 or Sel.EndPos-NewPos+1,Sel.EndLine-Sel.StartLine+1)
  elseif Line==Sel.EndLine and Sel.StartLine==Sel.EndLine then                         -- Корректируем конец в однострочном блоке.
    editor.Select(nil,BlockType,Sel.StartLine,Pos2 and Sel.StartPos2 or Sel.StartPos,NewPos2 and NewPos2-Sel.StartPos2 or NewPos-Sel.StartPos,1)
  elseif BlockType==2 and Line==Sel.EndLine and Pos~=Sel.EndPos+1 then                 -- Дополнительные приседания с вертикальным блоком, когда начало блока невозможно правильно опредлить (начало может попасть на середину табуляции...).
    editor.Select(nil,2,Sel.StartLine,NewPos2,Sel.EndPos2-NewPos2+1,Sel.EndLine-Sel.StartLine+1)
  else                                                                                 -- Корректируем конец в многострочном блоке.
    editor.Select(nil,BlockType,Sel.StartLine,Pos2 and Sel.StartPos2 or Sel.StartPos,NewPos2 and NewPos2-Sel.StartPos2 or NewPos-Sel.StartPos,Sel.EndLine-Sel.StartLine+1+(Sel.EndPos==-1 and Pos==1 and 1 or 0))
  end
end

-------------------------------------------------------------------------------
if not Macro then return {Editor_SmartHomeEnd=SimSU.Editor_SmartHomeEnd} end

local ok, mod = pcall(require,"SimSU.Editor_SmartHomeEnd"); if ok then SimSU=mod else _G.SimSU=SimSU end
-------------------------------------------------------------------------------

Macro {area="Editor"; key=S.KeyHome; priority=S.PriorHome; description=M.DescrHome;
  action=SimSU.Editor_SmartHomeEnd.Home;
}
Macro {area="Editor"; key=S.KeyEnd; priority=S.PriorEnd; description=M.DescrEnd;
  action=SimSU.Editor_SmartHomeEnd.End;
}
Macro {area="Editor"; key=S.KeyShiftHome; priority=S.PriorShiftHome; description=M.DescrShiftHome;
  action=function() SimSU.Editor_SmartHomeEnd.Select(true,1) end;
}
Macro {area="Editor"; key=S.KeyAltHome; priority=S.PriorAltHome; description=M.DescrAltHome;
  action=function() SimSU.Editor_SmartHomeEnd.Select(true,2) end;
}
Macro {area="Editor"; key=S.KeyShiftEnd; priority=S.PriorShiftEnd; description=M.DescrShiftEnd;
  action=function() SimSU.Editor_SmartHomeEnd.Select(false,1) end;
}
Macro {area="Editor"; key=S.KeyAltEnd; priority=S.PriorAltEnd; description=M.DescrAltEnd;
  action=function() SimSU.Editor_SmartHomeEnd.Select(false,2) end;
}
