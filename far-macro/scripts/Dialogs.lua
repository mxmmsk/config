
--Macro
--{ area="Shell"; key="ShiftF4";
--  description="UTF-8 в диалоге ShiftF4";
--action=function()
--  p = mf.ucase(APanel.Path);
--  b = 0;
--  if  Panel.FExist(0,".utf8")>0 then 
--    b = 1;
--  end
--  if  b==0  and   not APanel.Plugin then 
--    b = mf.fexist(p .. "\\.utf8");
--  end
--  if  b==0 then 
--    i = mf.index(mf.ucase(p).."\\","\\DROPBOX\\");
--    if  i>0 then 
--      b = 1;
--    end
--  end
--  --%i = index(%p,"\\VIDEO");
--  --MsgBox("","APanel.Plugin="+APanel.Plugin+"; i="+%i)
--  --$if (!APanel.Plugin && (%i>0))
--  if  b==0 then 
--    Keys("ShiftF4")
--  else
--    Keys("ShiftF4 Down CtrlDown 5 Up")
--  end
--end;
--}

--Macro
--{ area="Dialog"; key="BS";
--  description="Снять выделение со строки ввода перед удалением последнего символа";
--action=function()
--  if  Dlg.ItemType==4  and  Editor.Sel(0,4)==1 then 
--    if  Editor.Sel(0,1)==1  and  Editor.Sel(0,3)==mf.len(Dlg.GetValue(Dlg.CurPos,0)) then 
--      Keys("CtrlU")
--    end
--  end
--  Keys("BS")
--end;
--}

--Macro Description="DialogTools: Edit long text in the FAR modal editor"
--  Area="Dialog" Key="F4" DisableOutput=1
--action=function()
--  if  Dlg.ItemType==4  and  Object.Title~="Visual renaming files" then  Keys("F11 e") else Keys("F4") end
--end;}

--Macro Description="DialogTools: Undo last input"
--  Area="Dialog" Key="CtrlZ" DisableOutput=1
--action=function()
--  if  Dlg.ItemType==4  and  Object.Title~="Visual renaming files" then  Keys("F11 Z U") else Keys("CtrlZ") end
--end;}

--Macro Description="DialogTools: Redo last input"
--  Area="Dialog" Key="CtrlShiftZ" DisableOutput=1
--action=function()
--  if  Dlg.ItemType==4  and  Object.Title~="Visual renaming files" then  Keys("F11 Z R") else Keys("CtrlZ") end
--end;}
--
--Macro Description="DialogTools: Open file selection dialog for pasting fullpath into edit field"
--  Area="Dialog" Key="CtrlO" DisableOutput=1
--action=function()
--  if  Dlg.ItemType==4  and  Object.Title~="Visual renaming files" then  Keys("F11 o") else Keys("CtrlO") end
--end;}


-- Dialogs: Show DD in filter mode, Unicode CharMap: Listing fonts with CtrlUp/CtrlDown
Macro
{ description="QuickFilter or UCharMap font select"; key="CtrlDown"; area="Dialog";
action=function()
  if  Object.Title=="Unicode CharMap" then 
    Keys("CtrlF Down Enter")
  else
    Keys("CtrlDown")
    if  Menu.Filter(0)==0 then 
      Menu.Filter(0,1) Menu.Filter(4)
    end
  end
end;
}

Macro
{ description="QuickFilter debug"; area="Dialog";
--  Key="AltDown"
action=function()
  Keys("CtrlDown")
  --MsgBox("",Menu.GetValue())
  msgbox("",Menu.FilterStr())
  msgbox("",Menu.Filter(0))
  --%i=Menu.Filter(0);
  --$if (%i==0)
  --  Menu.Filter(5,"650") Menu.Filter(6)
  --$end
  --MsgBox("","Menu.Filter(0)="+%i)
end;
}

-- Unicode CharMap: Listing fonts with CtrlUp/CtrlDown
--Macro
--{ description="UCharMap font select"; key="CtrlUp"; area="Dialog";
--action=function()
--  if  Object.Title=="Unicode CharMap" then  Keys("CtrlF Up Enter") else Keys("CtrlUp") end
--end;}
--
--Macro
--{ description="Turn On/Off filter mode";
--  area="Dialog Menu UserMenu";
--  key="RAlt";
--  RunOnRelease=1
--  DisableOutput=1
--action=function()
--  Keys("CtrlAltF")
--end;}


--const SizeManager="Size Manager"
--const SizeManager1="{5431982E-24CA-4BAC-8831-177300C2405C}"
--const SizeManager2="{E41F6EFF-49DA-40D8-BB50-37D355D812CC}"
--macro
--  description="Size manager helper";
--  key="Enter Home End Up Down PgUp PgDn Left Right CtrlPgUp CtrlPgDn Tab";
--  area="Dialog.SizeManager1";
--  area="Dialog.SizeManager2";
--action=function()
--  key=mf.key(#AKey);
--  if  mf.substr(key,0,5)=="RCtrl" then  key=mf.substr(key,1); end
--  Keys("Esc")
--  eval(key)
--  Keys("F11")
--  if  Menu.Select(#%SizeManager,2) > 0 then 
--    Keys("Enter")
--  else
--    msgbox(#%SizeManager,"Plugin was not found in list!",1)
--    Keys("Esc")
--  end
--end;}

Macro
{
  description="Открыть на редактирование 'Info.txt'";
  key="AltI";
  area="Dialog.{1D07CEE2-8F4F-480A-BE93-069B4FF59A2B}";
  --area="DlgACompl";
action=function()
  if  Area.Current=="Dialog.AutoCompletion" then 
    Keys("Esc")
  end
  if  Area.Dialog  and  Dlg.Id=="1D07CEE2-8F4F-480A-BE93-069B4FF59A2B" then 
    Keys("End ShiftHome Del") print("Info.txt") Keys("Enter")
  end
end;}

Macro
{
  description="Дописать расширение .txt и открыть редактор";
  key="AltT";
  area="Dialog.{1D07CEE2-8F4F-480A-BE93-069B4FF59A2B}";
  area="DlgACompl";
action=function()
  if  Area.Current=="Dialog.AutoCompletion" then 
    Keys("Esc")
  end
  if  Area.Dialog  and  Dlg.Id=="1D07CEE2-8F4F-480A-BE93-069B4FF59A2B" then 
    clip = mf.trim(mf.clip(0)); -- Get text from clipboard, trim leading/trailing spaces
    s = mf.replace(clip,"\npic","\n"); -- Remove unwanted "pic" (Firefox)
    if  Dlg.GetValue()=="" then 
      -- ShiftF4 dialog is empty, paste "Film name"
      brk = ":([/\\\r\n";
      m = mf.len(s); b = 0;
      while  b < mf.len(brk) do 
        i = mf.index(s,mf.substr(brk,b,1));
        if  i>0  and  i<m then  m=i; end
        b = b+1;
      end
      t = mf.trim(mf.substr(s,0,m));
      if  t~="" then  print(t) end
    end
    if  mf.index(mf.lcase(Dlg.GetValue()),".txt")<0 then 
      Keys("End") print(".txt")
    end
    Keys("Enter")
    if  Area.Editor then 
      Keys("CtrlEnd") BM.Add()
      print(s) --ShiftIns
      BM.Back()
      Keys("CtrlShiftEnd")
      Editor.Sel(1,0)
    end
  end
end;}

Macro
{
  description="Создать папку для фильма и открыть .txt";
  key="AltT";
  area="Dialog.{FAD00DBE-3FFF-4095-9232-E1CC70C67737}";
action=function()
  s = mf.trim(Dlg.GetValue(Dlg.CurPos,0));
  i = mf.index(s, "/");
  if  i > 0 then 
    s = mf.trim(mf.substr(s,0,i));
    Keys("Home ShiftEnd") print(s)
  end
  Keys("Enter")
  if  Area.Shell then 
    Keys("Enter")
    Keys("ShiftF4")
    print(s..".txt")
    Keys("Enter")
    if  Area.Editor then 
      Keys("ShiftIns")
      Keys("CtrlHome")
    end
  end
end;}


--http://r.office.microsoft.com/r/rlidMSAddinPDFXPS
Macro
{
  description="Дописать расширение .url, редактор и создать шаблон для ярлыка Internet";
  key="AltU";
  area="Dialog";
condition=function(Key)
  if Dlg.Id~="1D07CEE2-8F4F-480A-BE93-069B4FF59A2B" then return false end
  url=mf.clip(0);
  iPos = mf.index(url,"://")
  if (iPos >= 2 and iPos <= 7) then return true end
  --if (mf.lcase(mf.substr(url,0,4))=="http"  or  mf.lcase(mf.substr(url,0,3))=="ftp") then return true end
  return false
end;
action=function()
  url=mf.clip(0);
  if  Area.Current=="Dialog.AutoCompletion" then 
    Keys("Esc")
  end
  if  Area.Dialog  and  Dlg.Id=="1D07CEE2-8F4F-480A-BE93-069B4FF59A2B" then 
    if mf.substr(Dlg.GetValue(-1),-4)~=".url" then
      Keys("End") print(".url")
    end
    Keys("Tab CtrlDown 1 Enter")
    if  Area.Editor then 
      Keys("CtrlA Del")
      print("[InternetShortcut]\nURL="..url.."\n")
    end
  end
end;}

Macro
{
  description="Выбрать CP 1251 в диалоге с ошибкой автоопределения кодовой страницы";
  key="ShiftEnter";
  area="Dialog";
condition=function(Key) return Dlg.Id=="4811039D-03A3-4F15-8D7A-8EBC4BCC97F9" end;
action=function()
  if Dlg.ItemCount==9 and Dlg.CurPos==6 and Dlg.ItemType==10 then
    Keys("CtrlDown")
    if Menu.Select("1251",1) > 0 then
      Keys("Enter Enter")
    end
  else
    msgbox("","Wrong dialog")
  end
end;
}
