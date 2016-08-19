
Macro
{
  key="AltF7";
  area="Shell";
  description="Стандартный поиск файлов, From the current folder";
  condition=function(key) return not APanel.Plugin end;
--  Cond="PanelType:0"
action=function()
  Keys("AltF7")
  if  Area.Dialog  and  Dlg.Id=="8C9EAD29-910F-4B24-A669-EDAFBA6ED964" then 
    if  mf.env("FARLANG")=="English" then 
      Keys("AltA n") -- Установить режим «From the current folder»
      Keys("AltU Subtract") -- Убрать флажок «Use filter»
      Keys("AltM") -- вернуться в поле с маской
    else if  mf.env("FARLANG")=="Russian" then 
    end end
  end
end;
}
