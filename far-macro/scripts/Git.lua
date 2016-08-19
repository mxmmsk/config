
local GitMacros = require("Git")

local far3bis = false

local function SendGitToEditor()
  -- Must be executed in the Shell with non empty command line
  Keys("CtrlHome") print("edit:<") Keys("Enter")
  -- The log is ANSI codepage but not a UTF-8
  if Area.Dialog then
    if Dlg.Id=="4811039D-03A3-4F15-8D7A-8EBC4BCC97F9" then
      Keys"CtrlDown Home Down Down Enter Enter"
    end
  end
  -- Заблокировать от изменений
  if Area.Editor then
    Keys("CtrlL")
  end
end

local function SelectGitAction()
  local l = Editor.Value
  if l ~= "" and mf.index(" #",mf.substr(l,0,1)) == -1 then
    local i = mf.index(l," ")
    if i > 0 and i <= 5 then
      --msgbox("Test","i="..i)
      Editor.Pos(1,2,i+1)
      Editor.Sel(2,0)
      Editor.Pos(1,2,1)
      Editor.Sel(2,1)
    end
  end
end

Macro
{
  area="Shell";
  --key="Enter";
  description="Execute git command and redirect output to Editor";
  flags="NotEmptyCommandLine|EnableOutput";
condition=function(key)
  return GitMacros.KnownGitAlias(CmdLine.Value)
end;
action = function()
  -- send git output to editor
  SendGitToEditor()
end;
}

Macro
{
  area="Shell";
  key="Enter";
  description="Translit git commands";
  flags="NotEmptyCommandLine|EnableOutput";
condition=function(key)
  return GitMacros.KnownGitAliasXlat(CmdLine.Value)
end;
action = function()
  -- translit
  Keys("XLat")
  -- and send git output to editor
  -- SendGitToEditor()
end;
}

Macro
{
  area="Editor";
  key="Q";
  description="Close editor with git output by 'Q' key";
condition=function(Key)
  if mf.ucase(mf.fsplit(Editor.FileName, 8)) ~= ".TMP" then return false end
  if band(Editor.State,8) ~= 0 then return false end
  if band(Editor.State,0x200) == 0 then return false end
  return true
end;
action=function()
  Keys("F10")
  --msgbox("State","0x"..mf.itoa(Editor.State,16):upper())
end;
}

local function GitShowCommit(names_only)
  local fn = Editor.FileName
  local cmt = Editor.SelValue
  if cmt == "" then
    cmt = Editor.Value:match("%s[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]+%s")
    if cmt == nil then
      msgbox("GitShowCommit","commit ish was not found, select it manually first")
      exit()
    end
    cmt = cmt:match("%w+")
  end
  local old_menu = ""
  local new_menu = ""
  if not far3bis then
    Keys("F12")
    if Area.Menu and Menu.Id=="72EB948A-5F1D-4481-9A91-A4BFD869D127" then
      old_menu = mf.substr(Menu.Value,0,2)
      Keys("1") -- Goto panels
    else
      exit()
    end
  end

  Plugin.Command("3A2AF458-43E2-4715-AFEA-93D33D56C0C2", "edit:<git show "..(names_only and "--stat " or "")..cmt)

  --Plugin.Command("4B675D80-1D4A-4EA9-8436-FDC23F2FC14B", "run:%ConEmuDrive%\\Far30.Latest\\far-bis\\Far.exe /ma /w /x /p%ConEmuDir%\\Plugins\\ConEmu;%ConEmuDrive%\\Far30.Latest\\far-bis\\Plugins;%ConEmuDrive%\\Far30.Latest\\Plugins;%ConEmuDrive%\\Far30.Latest\\Plugins.My \"edit:<git show "..cmt.."\"")
  if Area.Editor and (Editor.FileName~=fn) then
    Keys("CtrlL")
    if not far3bis and old_menu ~= "" then
      Keys("F12")
      new_menu = mf.substr(Menu.Value,0,2)
      if Menu.Select(old_menu,1) > 0 then
        Keys("Enter F12")
        if Menu.Select(new_menu,1) > 0 then
          Keys("Enter")
        end
      end
    end
  else
    Keys("CtrlTab")
  end
end;

Macro
{
  area="Editor";
  description="Git show selected commit contents";
  key="AltF3 AltF2";
action=function() GitShowCommit(akey(1,1)=="AltF2") end;
}

Macro
{
  area="Editor";
  description="Git show selected commit contents";
  key="Enter ShiftEnter";
condition=function(Key)
  if mf.ucase(mf.fsplit(Editor.FileName, 8)) ~= ".TMP" then return false end
  if band(Editor.State,8) ~= 0 then return false end
  if band(Editor.State,0x200) == 0 then return false end
  return true
end;
action=function() GitShowCommit(akey(1,1)~="Enter") end;
}

Macro
{
  area="Editor";
  description="Change git rebase keywords: pick -> reword/edit/squash/fixup";
  key="r e s f p";
  --flags="NoEVSelection";
condition=function(Key)
  local s = Editor.Sel(0,4);
  if s ~= 0 then
    if s == 1 then
      if Editor.Sel(0,1)==1 and Editor.Sel(0,3)<=7 and Editor.Sel(0,0)==Editor.Sel(0,2) then
        s = 0
      end
    end
    if s ~= 0 then
      return false
    end
  end
  if Editor.CurPos > 7 then return false end
  if mf.lcase(mf.fsplit(Editor.FileName, 12)) ~= "git-rebase-todo" then return false end
  --if mf.substr(Editor.Value,0,5) ~= "pick " then return false end
  return true
end;
action=function()
  local k = mf.lcase(akey(1,1))
  local w = k
  Keys("CtrlU Home CtrlShiftRight")
  if k == "r" then w = "reword"
  elseif k == "e" then w = "edit"
  elseif k == "s" then w = "squash"
  elseif k == "f" then w = "fixup"
  else w = "pick" end
  print(w)
  Keys("ShiftHome")
end;
}

Macro
{
  area="Editor";
  description="Change git rebase keywords: pick -> reword/edit/squash/fixup";
  key="Up Down";
condition=function(Key)
  if Editor.CurPos > 5 then return false end
  if mf.lcase(mf.fsplit(Editor.FileName, 12)) ~= "git-rebase-todo" then return false end
  return true
end;
action=function()
  local k = akey(1,1)
  Keys(k)
  SelectGitAction()
end;
}
