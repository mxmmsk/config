@echo off

set "ce_ssh_bin=C:\Program Files\Git\usr\bin"
set ce_ssh_pvt=/c/Users/maximus/.ssh

if NOT defined SSH_AGENT_PID goto do_run

rem ssh-agent.exe may be already started, check if its PID equals to %SSH_AGENT_PID%
tasklist /FI "IMAGENAME eq ssh-agent.exe" 2>NUL | find /I /N " %SSH_AGENT_PID% ">NUL
if "%ERRORLEVEL%"=="0" (
  echo ssh-agent PID=%SSH_AGENT_PID% is running
  rem timeout /t 10
  goto fin
) else (
  call cecho "ssh-agent PID=%SSH_AGENT_PID% was terminated"
)

:do_run
rem We suppose our batch is located in write-enabled folder
set "SSH_AGENT_INFO=%~dp0ssh-agent-%ConEmuServerPID%"
"%ce_ssh_bin%\ssh-agent.exe" -c > "%SSH_AGENT_INFO%"
if errorlevel 1 (
  call cecho "ssh-agent failed"
  goto fin
)
FOR /F "eol=; tokens=2,3*" %%i in (%SSH_AGENT_INFO%) do (
  @rem echo `%%i` `%%j` `%%k`
  if "%%i" == "SSH_AUTH_SOCK" set "SSH_AUTH_SOCK=%%j"
  if "%%i" == "SSH_AGENT_PID" set "SSH_AGENT_PID=%%j"
)
set "SSH_AUTH_SOCK=%SSH_AUTH_SOCK:~0,-1%"
set "SSH_AGENT_PID=%SSH_AGENT_PID:~0,-1%"
del "%SSH_AGENT_INFO%"
set SSH_AGENT_INFO=
set SSH_
ConEmuC -export=ALL SSH_*

setlocal
rem ### Adding keys begin ###
set was_errors=


rem ### Key1 ###
call "%~dp0ssh-key-pwd.cmd"
ConEmuC -GuiMacro print("%TEMP_SSH_KEY%\n")
"%ce_ssh_bin%\ssh-add.exe" %ce_ssh_pvt%/id_rsa
if errorlevel 1 set was_errors=1


rem ### Adding keys end ###
if defined was_errors (
  ConEmuC -export=ALL SSH_*
  cmd /k
)
endlocal

if "%~1" == "--no-pause" goto do_export
timeout /T 5

:do_export
ConEmuC -export=ALL SSH_*
:fin
