
-- Не проверено
Macro
{
  --Key="AltF5"
  description="Copy to selected folders on passive panel";
  area="Shell";
action=function()
  if  APanel.Plugin  or  (PPanel.SelCount<1)  or  PPanel.Plugin then 
    Keys("F5")
    exit()
  end

  dest="";
  i=1;
  p=PPanel.Path.."\\";
  while  i<=PPanel.ItemCount do 
    if  Panel.Item(1,i,8)  and  (band(Panel.Item(1,i,2),16)) then 
      s=p+Panel.Item(1,i,0);
      if  mf.index(s,";")>=0  or  mf.index(s,",")>=0 then 
        s="\""..s.."\"";
      end
      dest=dest..s..";";
    end
    i=i+1;
  end

  Keys("F5")
  -- Far3 - w/o brackets
  if   not Area.Dialog  or  (Dlg.Id~="FCEF11C4-5490-451D-8B4A-62FA03F52759"  and  Dlg.Id~="{FCEF11C4-5490-451D-8B4A-62FA03F52759}") then 
    exit()
  end

  Keys("Del") print(dest)
  Keys("AltM") -- english interface!
  Keys("Add")
  Keys("AltO") -- english interface!
end;
}

Macro
{
  key="F5 F6";
  area="Shell";
  flags="NoPluginPanels";
  description="Autoappend single file name to the Copy/Move destination or Copy to selected folders on passive panel";
condition=function() return (APanel.SelCount <= 1) and not APanel.Empty end;
action=function()
  local ak = mf.akey(1)
  if  mf.key(ak)=="F5"  and   not APanel.Plugin  and  (PPanel.SelCount>=1)  and   not PPanel.Plugin then 
    dest="";
    i=1;
    p=PPanel.Path.."\\";
    while  i<=PPanel.ItemCount do 
      if  Panel.Item(1,i,8)  and  (band(Panel.Item(1,i,2),16)) then 
        s=p..Panel.Item(1,i,0);
        if  mf.index(s,";")>=0  or  mf.index(s,",")>=0 then 
          s="\""..s.."\"";
        end
        dest=dest..s..";";
      end
      i=i+1;
    end

    if  dest~="" then 
      Keys("F5")
      -- Far3 - w/o brackets
      if   not Area.Dialog  or  (Dlg.Id~="FCEF11C4-5490-451D-8B4A-62FA03F52759"  and  Dlg.Id~="{FCEF11C4-5490-451D-8B4A-62FA03F52759}") then 
        exit()
      end

      Keys("Del") print(dest)
      Keys("AltM") -- english interface!
      Keys("Add")
      Keys("AltO") -- english interface!

      exit()
    end
  end

  if   not PPanel.Plugin  and  APanel.SelCount<2  and  PPanel.Visible  and  APanel.Path~=PPanel.Path then 
    mf.clip(5,2) Keys("CtrlShiftIns") f=mf.replace(mf.clip(0),"\"","");
    if  (band(Panel.FAttr(0,f),0x10)) == 0 then 
      Keys(ak)
      Keys("End")
      print(f)
      Keys("Home ShiftEnd")
    else
      Keys(ak)
    end
  else
    Keys(ak)
  end

  -- Clear "Filter" checkbox
  -- Far3 - w/o brackets
  if  Area.Dialog  and  (Dlg.Id=="FCEF11C4-5490-451D-8B4A-62FA03F52759"  or  Dlg.Id=="{FCEF11C4-5490-451D-8B4A-62FA03F52759}") then 
    if  mf.env("FARLANG")=="English" then 
      Keys("AltU")
      if  Dlg.CurPos==15 then 
        Keys("Subtract AltO")
      end
    else
      for RCounter=5,1,-1 do  Keys("ShiftTab") end
      if  Dlg.CurPos==15 then 
        Keys("Subtract") for RCounter=5,1,-1 do  Keys("Tab") end
      end
    end
  end

  if  mf.key(ak)=="F5" then 
    Keys("AltM") -- english interface!
    Keys("Subtract")
    Keys("AltO") -- english interface!
  end
end;
}
