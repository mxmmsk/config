
Macro {
	area="Shell";
	key="RCtrl9";
	flags="";
	description="Screenshots folder";
action = function()
  dt = "\\"..mf.date("%Y-%m0")
  if mf.env("COMPUTERNAME")=="XXXX" then 
    d="C:\\DropBox\\Photos\\ShareX";
  else
    d=mf.env("USERPROFILE").."\\Documents\\ShareX\\Screenshots"
  end

  if mf.fexist(d..dt) then d = d..dt end

  Panel.SetPath(0, d)

  -- Включить сортировку по дате
  Keys("CtrlF3 CtrlF5 Down")
end;
}

Macro {
  area="Menu";
  key="Enter";
  description="Change Default sort mode after jump to a folder from Folders shortcuts";
condition=function()
  if Menu.Id=="601DD149-92FA-4601-B489-74C981BC8E38" then return true end
  return false
end;
action=function()
  Keys(akey(1))
  -- Re-sort
  Keys("CtrlF4 CtrlF3")
end;
}
