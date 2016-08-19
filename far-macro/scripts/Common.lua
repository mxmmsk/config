
local function ToStr(bval)
  if APanel.Plugin then s = "true" else s = "false" end;
  return s
end

-- Для упрощения разработки макросов
Macro
{ description="Информация по Macro.Area/Диалогу"; key="CtrlAltF12"; area="Common";
action=function()
  wt = far.AdvControl(far.Flags.ACTL_GETWINDOWTYPE)
  --(wt==nil and wt.Type or "<nil>")
  --wr = far.AdvControl(far.Flags.ACTL_GETFARRECT);
  --far.Show(wr.Left,wr.Top,wr.Right,wr.Bottom);
  s = "Area.Current="..Area.Current.."; WindowType="..((wt~=nil) and wt.Type or "nil").."\n".."Object.Title=\""..Object.Title.."\"";
  if  Area.Dialog then
    s = s .. "\nDlg.Id==\""..Dlg.Id.."\"";
    s = s .. "\nDlg.ItemCount="..Dlg.ItemCount.."; .CurPos="..Dlg.CurPos.."; .ItemType="..Dlg.ItemType;
	s = s .. "\nGetValue(-1)=\""..Dlg.GetValue(-1).."\", \""..Dlg.GetValue().."\"";
    s = s .. "\nY1="..Dlg.GetValue(0,3)..", X1="..Dlg.GetValue(0,2)..", Y2="..Dlg.GetValue(0,5)..", X2="..Dlg.GetValue(0,4);
    s = s .. "\nEditor.sel(0,4)="..Editor.Sel(0,4).."; Editor.sel(0,1)="..Editor.Sel(0,1).."; Editor.sel(0,3)="..Editor.Sel(0,3);
  end
  if  Area.Menu or Area.MainMenu or Area.UserMenu or Area.Disks then
    s = s .. "\nMenu.Id=\""..Menu.Id.."\"";
    s = s .. "\nObject.ItemCount="..Object.ItemCount.."; .CurPos="..Object.CurPos;
    s = s .. "\nMenu.GetValue()=\""..Menu.GetValue().."\"";
    s = s .. "\nMenu.Value=\""..Menu.Value.."\"";
  end
  if  Area.Shell then
    s = s .. "\nAPanel.FilePanel="..ToStr(APanel.FilePanel).."; .Plugin=" .. ToStr(APanel.Plugin) .. "; .CurPos="..APanel.CurPos.."; .ItemCount="..APanel.ItemCount.."; .SelCount="..APanel.SelCount;
    s = s .. "; .Filter="..ToStr(APanel.Filter);
    s = s .. "\nAPanel.Current=\""..APanel.Current.."\""; --; .FAttr=0x"..mf.itoa(APanel.FAttr,16);
    s = s .. "\n.Path=\""..APanel.Path.."\"\n.Path0=\""..APanel.Path0.."\"";
    s = s .. "\nCmdLine.CurPos="..CmdLine.CurPos..", .ItemCount="..CmdLine.ItemCount..", .Selected="..ToStr(CmdLine.Selected);
    if  APanel.Plugin then
      s = s .. "\nAPanel.Prefix=\""..APanel.Prefix.."\"; .Format=\""..APanel.Format.."\"\n.HostFile=\""..(APanel.HostFile or "nil").."\"";
    end
  end
  if  Area.Help then
    s = s .. "\nHelp.FileName=\""..Help.FileName.."\"\n.Topic=\""..Help.Topic.."\"\n.SelTopic=\""..Help.SelTopic.."\"";
  end
  if  Area.Editor then
    s = s .. "\nEditor.FileName=\""..Editor.FileName.."\"";
    s = s .. "\nEditor.CurLine="..Editor.CurLine.."; .CurPos="..Editor.CurPos.."; .RealPos="..Editor.RealPos.."; .State=0x"..mf.itoa(Editor.State,16);
    s = s .. "\nEditor.Sel(0,0)="..Editor.Sel(0,0).."; .Sel(0,1)="..Editor.Sel(0,1).."; .Sel(0,2)="..Editor.Sel(0,2).."; .Sel(0,3)="..Editor.Sel(0,3).."; .Sel(0,4)="..Editor.Sel(0,4);
    s = s .. "\nEditor.Pos(0,1)="..Editor.Pos(0,1).."; .Pos(0,2)="..Editor.Pos(0,2).."; .Pos(0,3)="..Editor.Pos(0,3).."; .Pos(0,4)="..Editor.Pos(0,4).."; .Pos(0,5)="..Editor.Pos(0,5).."; .Pos(0,6)="..Editor.Pos(0,6);
    s = s .. "\nEditor.Value=\""..Editor.Value.."\"";
    s = s .. "\nEditor.SelValue=\""..Editor.SelValue.."\"";
  end
  if  Area.Viewer then
    s = s .. "\nViewer.State=0x"..mf.itoa(Viewer.State,16);
  end
  msgbox("Current info",s)
end;
}

-- Для упрощения разработки макросов
Macro
{
  description="Информация по Меню";
  --key="Ctrl`";
  area="Common";
condition=function(Key) return (Area.Menu or Area.MainMenu or Area.UserMenu or Area.Disks); end;
action=function()
  s = "Menu.Id=\""..Menu.Id.."\"";
  s = s .. "\nObject.ItemCount="..Object.ItemCount.."; .CurPos="..Object.CurPos;
  s = s .. "\nMenu.Value=\""..Menu.Value.."\"";
  s = s .. "\nMenu.Filter(0)=\""..Menu.Filter(0).."\"";
  s = s .. "\nMenu.GetValue(0,1)/TopPos="..Menu.GetValue(0,1);
  s = s .. "\nY1="..Menu.GetValue(0,3)..", X1="..Menu.GetValue(0,2)..", Y2="..Menu.GetValue(0,5)..", X2="..Menu.GetValue(0,4);

  i = 1;
  while  i <= mf.min(Object.ItemCount,6) do
    n=mf.itoa(i); f=mf.itoa(Menu.ItemStatus(i),16);
    s = s .. "\n"..n.."(0x"..f.."): \""..Menu.GetValue(i).."\"";
    if  Object.CurPos==i then  s = s .. " <<-- current"; end
    i = i + 1;
  end

  msgbox(Area.Current.." info",s,8)
end;
}

-- Калькуляторы, Resolve, и пр.
Macro
{ desciprion="Resolve"; key="CtrlAlt="; area="Common";
action=function()
  if Area.Menu then
    exit()
  end
  Keys("F11")
  if not Area.Menu then
    exit()
  end
  if Menu.Select("Resolve",2) > 0 then
    Keys("Enter")
  else
    Keys("Esc")
  end
end;
}

Macro
{ desciprion="Calculator"; key="Ctrl="; area="Common";
action=function()
  if Plugin.Menu("894EAABB-C57F-4549-95FC-4AC6F3102A36") then
    Keys("Enter")
  end
end;
}

Macro
{ desciprion="Window Spy"; key="AltShift="; area="Common";
action=function()
  Plugin.Menu("A8FD32E2-81B3-43FD-90B5-5EB71DE51595","A8FD32E2-81B3-43FD-90B5-5EB71DE51595")
  --$if (Macro.Area=="Menu" && Menu.Info.Id=="9844046F-0ED0-43B9-BD0C-51BBD68795DB")
  --  2
  --$end
end;
}
