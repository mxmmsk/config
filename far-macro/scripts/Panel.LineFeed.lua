Macro
{
  description="Line feed via Enter in Userscreen";
  area="Shell Tree Info QView";
  key="Enter";
  uid="3A6A0C4A-BBC8-4751-922D-09B59084DC5A";
  flags="EmptyCommandLine";
condition=function()
  return not APanel.Visible and CmdLine.Empty
end;
action=function()
  panel.GetUserScreen()
  io.write("\n"..Object.Title..">")
  panel.SetUserScreen()
end;
}
