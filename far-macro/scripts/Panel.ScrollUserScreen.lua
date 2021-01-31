
Macro
{
  description="UserScreen: Scroll PgUp";
  area="Shell";
  key="CtrlPgUp";
condition=function(Key)
  return not(APanel.Visible or PPanel.Visible)
end;
action=function()
  MsgBox("","Scroll-1")
  Plugin.SyncCall("4b675d80-1d4a-4ea9-8436-fdc23f2fc14b","Scroll(1,-1)")
end;
}

Macro
{
  description="UserScreen: Scroll PgDn";
  area="Shell";
  key="CtrlPgDn";
condition=function(Key)
  return not(APanel.Visible or PPanel.Visible)
end;
action=function()
  MsgBox("","Scroll+1")
  Plugin.SyncCall("4b675d80-1d4a-4ea9-8436-fdc23f2fc14b","Scroll(1,+1)")
end;
}
