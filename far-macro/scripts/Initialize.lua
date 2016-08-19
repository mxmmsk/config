Macro
{
  description="Initialize environment, startup script";
  --key="CtrlAltF12";
  area="Shell";
  flags="RunAfterFARStart";
action=function()
  mf.env("gitbranch",1,">")
end;
}
