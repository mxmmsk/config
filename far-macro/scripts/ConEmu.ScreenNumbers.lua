
-- Place this file into your %FARPROFILE%\Macros\scripts


-- Show all windows list from all consoles
-- May be useful when you want to copy a file(s) from one Far panel
-- to another folder from another Far instance

local ConEmu   = "4b675d80-1d4a-4ea9-8436-fdc23f2fc14b"

Macro
{
  area="Shell Editor Viewer Other";
  key="/[LR]Alt[0-9]/";
  description="ConEmu: Show all panels/dirs from all consoles";
action = function()
  local iWnd = mf.atoi(akey(1):sub(-1),10)+101;
  Plugin.SyncCall(ConEmu,iWnd);
  Plugin.SyncCall(ConEmu,100);
end
}
