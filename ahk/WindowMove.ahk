;Moves the active window from one monitor to the other. Similar to JumpWin.exe, but that stopped working for me for some reason.
;Based on Thalon's code at http://www.autohotkey.com/forum/topic19440.html  [Jon Aquino 2008-09-17]

leftMonitorWidth = 1920
leftMonitorHeight = 1080
rightMonitorWidth = 1920
rightMonitorHeight = 1080

^!q::    ;Default hotkey is Ctrl+Alt+Q
activeWindow := WinActive("A")
if activeWindow = 0
{
    return
}
WinGet, minMax, MinMax, ahk_id %activeWindow%
if minMax = 1
{
    WinRestore, ahk_id %activeWindow%
}
WinGetPos, x, y, width, height, ahk_id %activeWindow%
if (x < leftMonitorWidth)
{
    xScale := rightMonitorWidth / leftMonitorWidth
    yScale := rightMonitorHeight / leftMonitorHeight
    newX := leftMonitorWidth + x * xScale
    newY := y * yScale
    newWidth := width * xScale
    newHeight := height * yScale
}
else
{
    xScale := leftMonitorWidth / rightMonitorWidth
    yScale := leftMonitorHeight / rightMonitorHeight
    x := x - leftMonitorWidth
    newX := x * xScale
    newY := y * yScale
    newWidth := width * xScale
    newHeight := height * yScale
}
WinMove, ahk_id %activeWindow%, , %newX%, %newY%, %newWidth%, %newHeight%
if minMax = 1
{
    WinMaximize, ahk_id %activeWindow%
}
WinActivate ahk_id %activeWindow%   ;Needed - otherwise another window may overlap it
return
