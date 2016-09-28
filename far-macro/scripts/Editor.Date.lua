
-- Вставка в текст даты
Macro
{
  description="Insert User Comment";
  area="Editor";
  key="CtrlShiftC";
action=function()
  print("// "..mf.date("%d.%m0.%Y").." "..mf.env("Username").." - ")
end
}
