
local ffi=require("ffi")
local function safe_cdef(name,def)
if not pcall(ffi.sizeof,name) then ffi.cdef(def) end
end

ffi.cdef[[
BOOL SystemParametersInfoW(UINT act, UINT prm, UINT* pVal, UINT ini);
]]


Macro
{
  area="Editor Viewer";
  key="MsWheelDown MsWheelUp";
  description="Wheel x3 in editor";
action=function()
  local user32=ffi.load("User32")
  local icnt
  local ui=ffi.new("UINT[1]")
  if user32.SystemParametersInfoW(0x0068, 0, ui, 0) ~= 0 then
    icnt = ui[0]
  else
    icnt = 3
  end
  for i=1,icnt,1 do Keys(akey(1)) end
end;
}
