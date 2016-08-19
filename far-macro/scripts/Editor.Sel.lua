
Macro
{
  area="Editor";
  description="Editor Turbo-like block selection";
  key="CtrlK";
action=function()
  k=mf.waitkey(0,0);
  if k=="B"  or  k=="b"  or  k=="CtrlB"  or  k=="RCtrlB" then 
    Editor.Sel(2,0)
  else
    if k=="K"  or  k=="k"  or  k=="CtrlK"  or  k=="RCtrlK" then 
      Editor.Sel(2,1)
    else
      if (k=="C"  or  k=="c"  or  k=="CtrlC"  or  k=="RCtrlC")  and  Object.Selected then 
        Keys("CtrlC")
      else
        if (k=="Y"  or  k=="y"  or  k=="CtrlY"  or  k=="RCtrlY")  and  Object.Selected then 
          Keys("CtrlD")
        else
          if k=="U"  or  k=="u"  or  k=="CtrlU"  or  k=="RCtrlU" then 
            Keys("CtrlU")
          else
            eval("F1")
          end
        end
      end
    end
  end
end;
}
