
Macro
{
  description="Поместить в буфер обмена список имен (без расширений) выделенных на панели файлов";
  area="Shell";
  key="CtrlShiftIns";
action=function()
  if  _G.EditClipboardMode==1  or  _G.EditClipboardMode==2 then  mf.clip(5,_G.EditClipboardMode) end
  a_ext = "Имена файлов с расширениями";
  a_noext = "Имена файлов БЕЗ расширений";
  a = Menu.Show(a_ext.."\r\n"..a_noext, "Копирование без кавычек");
  if  a==a_ext  or  a==a_noext then 
    if  a==a_ext then 
      iMode=12;
    else
      iMode=4;
    end
    if  APanel.SelCount>0 then 
      i=1;
      s="";
      while  i<=APanel.ItemCount do 
        if Panel.Item(0,i,8) then 
          s=s.."\r\n"..mf.fsplit(Panel.Item(0,i,0),iMode);
        end
        i=i+1;
      end
      mf.clip(1,mf.substr(s,2))
    else
      mf.clip(1,mf.fsplit(APanel.Current,iMode))
    end
  end
--[=[
$if (CmdLine.ItemCount>0)
  CtrlIns
$else
  clip(5) CtrlIns %s=clip ( 0, "" );
  %s=replace(%s,"\"", ""); %s1="";
  $While (%s!="")
    %i=index(%s,"\r\n"); 
    $if (%i==-1)
      %s0=%s; %s="";
    $else
      %s0=substr(%s,0,%i); %s=substr(%s,%i+2,-1);
    $end
    %s1=%s1+iif(%s1=="","","\r\n")+fsplit(%s0,4);
  $End
  clip(5) clip(1,%s1)
$end
]=]
end;
}

Macro
{
  description="Copy to clipboard filename.ext only";
  area="Shell";
  key="CtrlIns";
  flags="EmptyCommandLine";
action=function()
  if  _G.EditClipboardMode==1  or  _G.EditClipboardMode==2 then  mf.clip(5,_G.EditClipboardMode) end

  local a
  if  APanel.SelCount<1 then
    if mf.ucase(mf.fsplit(APanel.Current, 8)) == ".MD" then
      local a_html = "Copy "..mf.fsplit(APanel.Current,4)..".html"
      local a_ghub = "Copy conemu.github.io/...html"
      local a_md = "Copy "..APanel.Current
      a = Menu.Show(a_html.."\r\n"..a_ghub.."\r\n"..a_md, "Копирование без кавычек");
      if a==a_html then
        mf.clip(1,mf.fsplit(APanel.Current,4)..".html")
      elseif a==a_ghub then
        mf.clip(1,"https://conemu.github.io/en/"..mf.fsplit(APanel.Current,4)..".html")
      elseif a==a_md then
        mf.clip(1,mf.fsplit(APanel.Current,12))
      end
    else
      mf.clip(1,mf.fsplit(APanel.Current,12))
    end
    exit()
  end

  local a_cur = "Скопировать filename.ext текущего элемента";
  local a_sel = "Скопировать filename.ext выделенных элементов";
  a = Menu.Show(a_cur.."\r\n"..a_sel, "Копирование без кавычек");
  if  a==a_cur  or  a==a_sel then 
    if  a==a_cur then 
      mf.clip(1,mf.fsplit(APanel.Current,12))
    end
    if  a==a_sel then 
      i=1;
      s="";
      while  i<=APanel.ItemCount do 
        if Panel.Item(0,i,8) then 
          s=s.."\r\n"..mf.fsplit(Panel.Item(0,i,0),12);
        end
        i=i+1;
      end
      mf.clip(1,mf.substr(s,2))
    end
  end
end;
}

Macro
{
  description="Copy fullpath of current item. No quotas. Endslashed for folders.";
  area="Shell";
  key="CtrlC";
-- DisableOutput=1
action=function()
  -- Поскольку это предназначено для копирования во ВНЕШНИЕ приложения
  -- буфер используем ВСЕГДА системный
  mf.clip(5,1)
  -- Поехали
  -- msgbox("APanel.Current",APanel.Current)
  if  APanel.Current==".." then 
    if  mf.substr(APanel.Path,mf.len(APanel.Path)-1,1)=="\\" then 
      s = APanel.Path;
    else
      s = APanel.Path .. "\\";
    end
  else if  mf.index(APanel.Current,"\\")==-1 then 
    if  mf.substr(APanel.Path,mf.len(APanel.Path)-1,1)=="\\" then 
      s = APanel.Path + APanel.Current;
    else
      s = APanel.Path .. "\\" .. APanel.Current;
    end
    if band(mf.fattr(s),0x10)~=0 then 
      s = s .. "\\";
    end
  else
    s = APanel.Current;
  end end
  mf.clip(1,s)
end;
}

Macro
{
  description="Shell Copy";
  area="Shell";
  key="CtrlShiftC";
action=function()
  Keys("CtrlC")
end;
}

Macro
{
  description="Shell Paste";
  area="Shell";
  key="CtrlShiftV";
action=function()
  if  APanel.Plugin then 
    msgbox("Macro: CtrlShiftV", "Вставка на плагиновые панели не поддерживается")
    exit()
  end

  if   not CmdLine.Empty then 
    -- Save command line
    Flg_Cmd=1; CmdCurPos=CmdLine.ItemCount-CmdLine.CurPos+1; CmdVal=CmdLine.Value; Keys("Esc")
  else
    Flg_Cmd=0;
  end
  
  -- Execute EMenu 'Paste' command
  print("rclk_cmd:Paste \""..APanel.Path.."\"") Keys("Enter")
  -- Reload panel (Far may skip this)
  Keys("CtrlR")
  
  -- Restore command line
  if  Flg_Cmd==1 then  print(CmdVal) Flg_Cmd=0; Num=CmdCurPos; 
  while  Num~=0 do  Num=Num-1; Keys("CtrlS") end end
end;
}
