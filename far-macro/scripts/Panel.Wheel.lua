
Macro
{
	description="Прокрутка панелей или UserScreen";
	area="Shell";
	key="MsWheelUp";
action=function()
  if  Area.Shell  and  (APanel.Visible  or  PPanel.Visible) then  Keys("MsWheelUp") else Far.Window_Scroll(-3) end
end;
}

Macro
{
	description="Прокрутка панелей или UserScreen";
	area="Shell";
	key="MsWheelDown";
action=function()
  if  Area.Shell  and  (APanel.Visible  or  PPanel.Visible) then  Keys("MsWheelDown") else Far.Window_Scroll(3) end
end;
}
