
-- Place this file into your %FARPROFILE%\Macros\scripts


-- Show all windows list from all consoles

local MacroBrowser     = "4EBBEFC8-2084-4B7F-94C0-692CE136894D"
local MacroBrowserMenu = "EF6D67A2-59F7-4DF3-952E-F9049877B492"

Macro {
  area="Common"; key="CtrlAltF11"; flags=""; description="Show list of macroses"; action = function()
    if Plugin.Menu(MacroBrowser, MacroBrowserMenu) then
      Keys("CtrlAltF")
    else
      msgbox("Failed","MacroBrowser failed with call by Plugin.Menu")
      --Keys("F11")
      --if Menu.Select("Macro Browser",2) > 0 then
      --  Keys("Enter")
      --end
    end
  end
}
