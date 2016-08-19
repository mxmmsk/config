
Macro
{
  area="Editor";
  key="CtrlH";
  description="Turn whitespace chars on/off";
action=function()
  i = 20;
  v = Editor.Set(i,-1);
  Editor.Set(i,mf.iif(v==0,1,mf.iif(v==1,2,0)))
end;
}

Macro
{
  area="Viewer";
  key="CtrlH";
  description="Turn whitespace chars on/off";
action=function()
  Keys("AltShiftF9 Alt0 Enter")
end;
}
