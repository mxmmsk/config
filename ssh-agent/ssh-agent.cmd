@echo off

if NOT defined SSH_AGENT_PID goto do_run

tasklist /FI "IMAGENAME eq ssh-agent.exe" 2>NUL | find /I /N " %SSH_AGENT_PID% ">NUL
if "%ERRORLEVEL%"=="0" (
  echo ssh-agent PID=%SSH_AGENT_PID% is running
  goto fin
) else (
  call cecho "ssh-agent PID=%SSH_AGENT_PID% was terminated"
)

:do_run
set "SSH_AGENT_INFO=%~dp0ssh-agent-%ConEmuServerPID%"
"C:\Program Files (x86)\Git\bin\ssh-agent.exe" -c > "%SSH_AGENT_INFO%"
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
"C:\Program Files (x86)\Git\bin\ssh-add.exe"
timeout /T 5
ConEmuC -export=ALL SSH_*
:fin
