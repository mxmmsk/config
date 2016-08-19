
-- XLat
Macro
{ desciprion="XLat"; key="CtrlShiftX"; area="Common"; -- DisableOutput=0
action=function()
  Keys("XLat")
end;
}

-- Ввод с клавиатуры символов
Macro
{ desciprion="Medium Dash (–)"; key="Alt-"; area="Common";
action=function()
  print("–")
end;
}

Macro
{ desciprion="Long Dash (—)"; key="Ctrl-"; area="Common";
action=function()
  print("—")
end;
}

Macro
{ desciprion="Ellipses (…)"; key="Alt."; area="Common";
action=function()
  print("…")
end;
}

Macro
{ desciprion="NonBreaking space"; key="AltSpace"; area="Common";
action=function()
  print(" ")
end;
}

Macro
{ desciprion="Esc code ()"; key="AltShiftE"; area="Common";
action=function()
  print("")
end;
}

Macro
{ desciprion="Left quote («)"; key="AltShift,"; area="Common";
action=function()
  print("«")
end;
}

Macro
{ desciprion="Right quote (»)"; key="AltShift."; area="Common";
action=function()
  print("»")
end;
}

Macro
{ desciprion="Left quote (‘)"; key="AltShift9"; area="Common";
action=function()
  print("‘")
end;
}

Macro
{ desciprion="Right quote (’)"; key="AltShift0"; area="Common";
action=function()
  print("’")
end;
}

Macro
{ desciprion="Insert Tab symbol"; key="AltT"; area="Editor";
action=function()
  -- TODO: Тут бы получить то, что сейчас в настройке...
  editor.SetParam(-1,1,0)
  print("\t")
  editor.SetParam(-1,1,2)
end;
}

-- Ввод Unicode символа по его hex или dec номеру
Macro
{ desciprion="Ввод Unicode символа (hex/dec)"; key="AltShiftAdd"; area="Common";
action=function()
  h=prompt("Input hex unicode char ('0x' prefix is optional)","Use ‘d’ suffix for decimal values",0x10,"0x0000");
  if h=="" then
    exit()
  end
  n=0;
  if mf.substr(h,0,2):lower()=="0x" then
    n=mf.atoi(mf.substr(h,2),16)
  elseif mf.substr(h,-1):lower()=="d" then
    n=mf.atoi(h,10)
  else
    n=mf.atoi(h,16)
  end
  if n~=0 then
    print(mf.chr(n))
  end
end;
}
