-- This macro may pastes into your editor or dialog newly generated GUI
-- It adds two menu items to the F11 plugin menu
--   Paste GUID: simple format
--   Paste GUID: struct format

--local ffi=require("ffi")
--local function safe_cdef(name,def)
--if not pcall(ffi.sizeof,name) then ffi.cdef(def) end
--end
--safe_cdef("GUID",[[
--typedef struct _GUID {
--  unsigned long  Data1;
--  unsigned short Data2;
--  unsigned short Data3;
--  unsigned char  Data4[8];
--} GUID;
--]])
--ffi.cdef[[
--long UuidCreate(GUID* guid);
--long UuidToStringA(GUID* guid, void** StringUuid);
--]]

--local function CreateGuid()
--  --local Rpcrt4=ffi.load("Rpcrt4")
--  --local guid=ffi.new("GUID")
--  --Rpcrt4.UuidCreate(guid)
--  --local gsp=ffi.new("void*[1]")
--  --Rpcrt4.UuidToStringA(guid,gsp)
--  --str = ffi.string(gsp[0],38)
--  --return str
--
--  u = win.Uuid()
--  str = string.format("%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
--    string.byte(u,1),string.byte(u,2),string.byte(u,3),string.byte(u,4),string.byte(u,5),string.byte(u,6),string.byte(u,7),string.byte(u,8),
--    string.byte(u,9),string.byte(u,10),string.byte(u,11),string.byte(u,12),string.byte(u,13),string.byte(u,14),string.byte(u,15),string.byte(u,16))
--  return str
--end;

--Example
--F40F2EB8-246C-4F25-817D-57A093094B2C

MenuItem {
  text=function(menu,area) return "Paste GUID: simple format" end;
  area="Editor Dialog";
  menu="Plugins";
  guid="0A28B8CB-6DC4-4D8E-A8D8-A2FC713567F6";
action=function(OpenFrom,Item)
  guid = win.Uuid(win.Uuid()):upper() --mf.ucase(CreateGuid())
  mf.postmacro(mf.print,guid)
end;
}

--Example
--// {F40F2EB8-246C-4F25-817D-57A093094B2C}
--static GUID guid_PluginC0 = 
--{ 0xf40f2eb8, 0x246c, 0x4f25, { 0x81, 0x7d, 0x57, 0xa0, 0x93, 0x9, 0x4b, 0x2c } };

MenuItem {
  text=function(menu,area) return "Paste GUID: struct format" end;
  area="Editor";
  menu="Plugins";
  guid="089E91B2-D9BD-4A88-B8FD-472799F40156";
action=function(OpenFrom,Item)
  guid = win.Uuid(win.Uuid()) --CreateGuid()
  cstr = "// {"..mf.ucase(guid).."}\n"
  cstr = cstr.."static GUID <<name>> =\n"
  cstr = cstr.."{ 0x"..mf.substr(guid,0,8)..", 0x"..mf.substr(guid,9,4)..", 0x"..mf.substr(guid,14,4)
  cstr = cstr..", { 0x"..mf.substr(guid,19,2)..", 0x"..mf.substr(guid,21,2)..", 0x"..mf.substr(guid,24,2)..", 0x"..mf.substr(guid,26,2)
  cstr = cstr..", 0x"..mf.substr(guid,28,2)..", 0x"..mf.substr(guid,30,2)..", 0x"..mf.substr(guid,32,2)..", 0x"..mf.substr(guid,34,2).." } };"
  mf.postmacro(mf.print,cstr)
end;
}
