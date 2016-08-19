
-- Навигация по панели

Macro {
area="Shell"; key="AltDown"; flags=""; description="Перейти в следующую папку на верхнем уровне на обеих панелях"; action = function()
  Keys("CtrlPgUp Down CtrlPgDn")
  Keys("Tab")
  Keys("CtrlPgUp Down CtrlPgDn")
  Keys("Tab")
end;
}

Macro {
area="Shell"; key="AltUp"; flags=""; description="Перейти в предыдущую папку на верхнем уровне на обеих панелях"; action = function()
  Keys("CtrlPgUp Up CtrlPgDn")
  Keys("Tab")
  Keys("CtrlPgUp Up CtrlPgDn")
  Keys("Tab")
end;
}

Macro {
area="Shell"; key="ShiftDown"; flags=""; description="Перейти в следующую папку на верхнем уровне на текущей панели"; action = function()
  Keys("CtrlPgUp Down CtrlPgDn")
end;
}

Macro {
area="Shell"; key="ShiftUp"; flags=""; description="Перейти в предыдущую папку на верхнем уровне на текущей панели"; action = function()
  Keys("CtrlPgUp Up CtrlPgDn")
end;
}

Macro {
area="Shell"; key="CtrlShiftLeft"; flags="EmptyCommandLine"; description="Предыдущий диск на текущей панели"; action = function()
  Keys("F9 Enter Up Enter")
  Keys("Up Enter")
end;
}

Macro {
area="Shell"; key="CtrlShiftRight"; flags="EmptyCommandLine"; description="Следующий диск на текущей панели"; action = function()
  Keys("F9 Enter Up Enter")
  Keys("Down Enter")
end;
}

Macro {
area="Shell"; key="RAltDown"; flags=""; description="На следующий выделенный"; action = function()
  _G.FastFilterWait = -1;
  if  Panel.Item(0, 0, 8) then 
    Panel.SetPosIdx(0, Panel.SetPosIdx(0, 0, 1) + 1, 1)
  else
    c = APanel.CurPos;
    s = Panel.SetPosIdx(0, 1, 1);
    i = APanel.CurPos;
    while  (i < c)  and  s < APanel.SelCount do 
      s = Panel.SetPosIdx(0, s + 1, 1);
      i = APanel.CurPos;
    end
  end
end;
}

Macro {
area="Shell"; key="RAltUp"; flags=""; description="На предыдущий выделенный"; action = function()
  _G.FastFilterWait = -1;
  if  Panel.Item(0, 0, 8) then 
    Panel.SetPosIdx(0, Panel.SetPosIdx(0, 0, 1) - 1, 1)
  else
    c = APanel.CurPos;
    s = Panel.SetPosIdx(0, APanel.SelCount, 1);
    i = APanel.CurPos;
    while  (i > c)  and  s > 1 do 
      s = Panel.SetPosIdx(0, s - 1, 1);
      i = APanel.CurPos;
    end
  end
end;
}

Macro {
area="Shell"; key=""; flags=""; description="На первый выделенный"; action = function()
  _G.FastFilterWait = -1;
  Panel.SetPosIdx(0, 1, 1)
end;
}

Macro {
area="Shell"; key=""; flags=""; description="На последний выделенный"; action = function()
  _G.FastFilterWait = -1;
  Panel.SetPosIdx(0, APanel.SelCount, 1)
end;
}

Macro {
area="Shell"; key="AltShiftDown"; flags=""; description="Перейти к следующему элементу на обеих панелях"; action = function()
  Keys("Down Tab Down Tab")
end;
}

Macro {
area="Shell"; key="AltShiftUp"; flags=""; description="Перейти к предыдущему элементу на обеих панелях"; action = function()
  Keys("Up Tab Up Tab")
end;
}

Macro {
area="Shell"; key="AltLeft"; flags=""; description="Открыть на левой панели папку под курсором правой панели"; action = function()
  _G.FastFilterWait = -1;
  OldCount=CmdLine.ItemCount;
  OldPos=CmdLine.CurPos;
  OldCmd=CmdLine.Value;
  IsLeft=APanel.Left;
  if not IsLeft then 
    if  APanel.Current==".." then 
      Item=APanel.Path;
    else
      Item=APanel.Path.."\\"..APanel.Current;
      A=mf.fattr(Item);
      if  (A==-1)  or  ((band(A,0x10))==0) then 
        Item=APanel.Path;
      end
    end
  else
    if  PPanel.Current==".." then 
      Item=PPanel.Path;
    else
      Item=PPanel.Path.."\\"..PPanel.Current;
      A=mf.fattr(Item);
      if  (A==-1)  or  ((band(A,0x10))==0) then 
        Item=PPanel.Path;
      end
    end
  end
  Keys("Esc")
  if not IsLeft then 
    Keys("Tab")
  end
  print("cd "..Item)
  Keys("Enter")
  if not IsLeft then 
    Keys("Tab")
  end
  if  OldCount>0 then 
    print(OldCmd)
  end
end;
}

Macro {
area="Shell"; key="AltRight"; flags=""; description="Открыть на правой панели папку под курсором левой панели"; action = function()
  _G.FastFilterWait = -1;
  OldCount=CmdLine.ItemCount;
  OldPos=CmdLine.CurPos;
  OldCmd=CmdLine.Value;
  IsLeft=APanel.Left;
  if IsLeft then 
    if  APanel.Current==".." then 
      Item=APanel.Path;
    else Item=APanel.Path.."\\"..APanel.Current;
      A=mf.fattr(Item);
      if  (A==-1)  or  ((band(A,0x10))==0) then 
        Item=APanel.Path;
      end 
    end 
  else 
    if  PPanel.Current==".." then 
      Item=PPanel.Path;
    else 
      Item=PPanel.Path.."\\"..PPanel.Current;
      A=mf.fattr(Item);
      if  (A==-1)  or  ((band(A,0x10))==0) then 
        Item=PPanel.Path;
      end
    end
  end
  Keys("Esc")
  if  IsLeft then 
    Keys("Tab")
  end
  print("cd "..Item)
  Keys("Enter")
  if  IsLeft then 
    Keys("Tab")
  end
  if  OldCount>0 then 
    print(OldCmd)
  end
end;
}

Macro {
  area="Shell";
  key="ShiftLeft ShiftRight";
  flags="EmptyCommandLine";
  description="Выделить на соседней панели одноименный файл с активной панели";
condition=function(key)
  if not CmdLine.Empty or not APanel.Visible or not PPanel.Visible or APanel.Empty or APanel.Current==".." then return false end
  return true
end;
action = function()
  s=Panel.SetPos(1,APanel.Current);
end;
}

Macro {
area="Shell"; key="BS"; flags="EmptyCommandLine"; description="На уровень вверх"; action = function()
  Keys("CtrlPgUp")
end;
}
Macro {
area="Shell"; key="AltBS AltShiftPgUp AltShiftBS"; flags="EmptyCommandLine"; description="На уровень вверх на обеих панелях"; action = function()
  Keys("CtrlPgUp Tab CtrlPgUp Tab")
end;
}

Macro {
area="Shell"; key="AltShiftPgDn"; flags=""; description="Войти в каталог на обеих панелях"; action = function()
  Keys("CtrlPgDn Tab CtrlPgDn Tab")
end;
}

Macro {
area="Shell"; key="MsM2Click"; flags=""; description="На уровень вверх"; action = function()
  Keys("CtrlPgUp")
end;
}

Macro {
area="Shell"; key="MsM3Click"; flags=""; description="Войти в папку"; action = function()
  Keys("CtrlPgDn")
end;
}

Macro {
area="Shell"; key="AltShiftEnter"; flags=""; description="Execute 'goto:' on command line or path in the clipboard"; action = function()
  if  CmdLine.Empty then
    print(mf.clip(0))
  end
  if  CmdLine.Empty then
    exit()
  end
  Keys("CtrlHome")
  print("goto:")
  Keys("Enter")
end;
}

Macro {
  area="Shell";
  key="AltF4";
  description="Execute CmdLine and redirect output to Editor";
  flags="NotEmptyCommandLine";
action = function()
  Keys("CtrlHome") print("edit:<") Keys("Enter")
end;
}

Macro {
area="Shell"; key="CtrlClear"; flags=""; description="Панели по центру на весь экран"; action = function()
  Keys("CtrlClear") for RCounter= Far.Height,1,-1 do  Keys("CtrlDown") end
end;
}

--Macro
--  Area="Shell"
--  Key="CtrlF3"
--  Description="Если при нажатии CtrlF3 курсор стоял на папке и папка на панели первая - дожимается Home"
--  DisableOutput=1
--  Condition="PanelItem:1"
Macro {
area="Shell"; key="CtrlF3"; flags=""; description="Если при нажатии CtrlF3 курсор стоял на папке и папка на панели первая - дожимается Home"; action = function()
  n=APanel.CurPos; Keys("CtrlF3")
  --%v=waitkey(0,1);
  if  (n==1) --[=[&& (%v!="Shift")]=] then  Keys("Home") end
end;
}

--Macro
--  Area="Shell"
--  Key="CtrlF5"
--  Description="После нажатия CtrlF5 курсор помещается на верхний ФАЙЛ"
--  DisableOutput=1
Macro {
area="Shell"; key="CtrlF5"; flags=""; description="После нажатия CtrlF5 курсор помещается на верхний ФАЙЛ"; action = function()
  Keys("CtrlF5 Home")
  -- Не прыгать на файл для плагиновых панелей
  if APanel.Plugin and APanel.Format=="FARdroid" then
    exit()
  end
  -- В некоторых папках позиционирование на файл только мешает
  list_dir = {"\\ConEmu-ToDo\\html"}
  for i,v in ipairs(list_dir) do
    if mf.substr(APanel.Path,-mf.len(v)) == v then
      exit()
    end
  end
  -- прыгнуть на файл
  n = 1;
  while n <= APanel.ItemCount do
    if (band(Panel.Item(0,n,2),0x12)) == 0 then
      Panel.SetPosIdx(0,n)
      exit()
    else
      n = n + 1;
    end
  end
end;
}

Macro {
area="Shell"; key="AltF5"; flags=""; description="Перейти к первому файлу на панели"; action = function()
  n = 1; while  n <= APanel.ItemCount do  if  (band(Panel.Item(0,n,2),0x10)) == 0 then  Panel.SetPosIdx(0,n) n = APanel.ItemCount + 1; else n = n + 1; end end
end;
}

--Macro
--  Descr="Открыть QSearch с введенным *"
--  Area="Shell"
--  --Key="RAlt:Release"
--  DisableOutput=1
Macro {
  area="Shell";
  key="RAlt";
  flags="";
  description="Открыть QSearch с введенным *";
action = function()
  Keys("Alt?")
  if  Area.Search then 
    Keys("BS") print("*")
  end
end;
}

--Macro Descr="Открыть пустой QSearch" Area="Shell"
--  --Key="RAlt:Hold" RunOnRelease=1
--  DisableOutput=1
Macro {
area="Shell"; key=""; flags=""; description="Открыть пустой QSearch"; action = function()
  Keys("Alt|")
  if  Area.Search then 
    Keys("BS")
  end
end;
}

Macro {
area="Shell"; key="RAltBackSlash"; flags=""; description="Перейти в один из родительских каталогов"; action = function()
  if  _G.FastFilterWait==mf.iif(APanel.Left,1,2) then 
    exit()
  else
    _G.FastFilterWait = -1;
  end
  
  Path = APanel.Path;
  if  Path=="" then 
    -- Делать нечего, отдадим кнопку в Far
    Keys("CtrlBackSlash")
    exit()
  end

  -- Поехали, формируем меню
  Items = "";
  while  Path~="" do 
    i = mf.rindex(Path,"\\");
    if  i<0 then 
      Path = "";
    else
      Path = mf.substr(Path, 0, i);
      if  Path=="\\\\" then 
        Path = "";
      else
        if  Items ~= "" then  Items = Items.."\r\n"; end
        Items = Items..Path.."\\";
      end
    end
  end

  if  Items=="" then 
    -- Пунктов нет, отдадим кнопку в Far
    Keys("CtrlBackSlash")
    exit()
  end

  dir = Menu.Show(Items,"Jump to");
  if  dir~=""  and  dir~=0 then 
    Keys("Esc") --TODO: сохранить ком.строку
    print("cd "..dir)
    Keys("Enter") -- goto
  end
end;
}
