
Macro
{
  description="Copy file from FarDroid panel";
  area="Shell";
  --key="F5";
condition=function() return APanel.FilePanel and APanel.Plugin and APanel.Format=="FARdroid" and PPanel.FilePanel and not PPanel.Plugin end;
action=function()
  fn = PPanel.Path.."\\"..APanel.Current
  --msgbox("copying",fn.."\n"..PPanel.Path)
  Keys("Esc")
  print("%FARTOOLS%\\ADB\\get_file_adb.cmd \""..APanel.Path.."\" \""..APanel.Current.."\" \""..fn.."\"")
  Keys("Enter")
end;
}

Macro
{
  description="arclite: F5 - NoSeparate";
  area="Shell";
  key="F5";
condition=function() return APanel.FilePanel and APanel.Plugin and APanel.Prefix == "arc" and PPanel.FilePanel and not PPanel.Plugin end;
action=function()
  Keys("F5")
  if  Area.Current=="Dialog"  and  Dlg.Id=="97877FD0-78E6-4169-B4FB-D76746249F4D" then
    hotkey = "";
    if  mf.env("FARLANG")=="English" then
      hotkey = "t";
    else if  mf.env("FARLANG")=="Russian" then
      hotkey = "о";
    end end

    i = Object.CheckHotkey(hotkey);
    if  hotkey~=""  and  i>0 then
      --  Снять флажок «[ ] Extract archive into separate directory»
      if  mf.env("FARLANG")=="English" then  Keys("AltT") else Keys("AltJ") end Keys("Subtract")
      --  Вернуться в поле пути
      Keys("Home")
      --  Выделить весь текст в поле пути
      Keys("Home ShiftEnd")
    else
      msgbox("CheckHotkey(hotkey)","hotkey="..hotkey.."\n"..Object.CheckHotkey(hotkey))
    end
  else
    msgbox("Arc_NoSeparate.macro","Invalid macro area: "..Area.Current.."\nDlg.Info.Id: "..Dlg.Id)
  end
end;
}

Macro
{
  description="arclite: ShiftF2 - NoSeparate";
  area="Shell";
  key="ShiftF2";
  flags="NoPluginPanels";
action=function()
  Keys("ShiftF2")
  if Area.Dialog and Dlg.Id=="97877FD0-78E6-4169-B4FB-D76746249F4D" then
    if  mf.env("FARLANG")=="English" then
      Keys("AltT Subtract AltE")
    end
  end
end;
}
