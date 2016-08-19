
Macro {
  area = "Editor";
  --key = "AltF7";
  description = "Colorer: Outliner";
action = function()
  Plugin.Menu("D2F36B62-A470-418D-83A3-ED7A3710E5B5")
  Keys("5")
end;
}

Macro {
  area = "Editor";
  key = "F3";
  description = "Continue search";
action = function()
  BM.Add()
  Keys("ShiftF7")
end;
}

Macro {
  area = "Editor";
  key = "F7 ShiftF7";
  description = "Editor find + Bookmarks";
action = function()
  BM.Add()
  Keys(akey(1))
end;
}
