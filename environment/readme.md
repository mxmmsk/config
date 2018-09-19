## Some aliases and env vars for git

~~~
set "PATH=%ConEmuBaseDir%\Scripts;C:\Tools\Exe;C:\Projects\tools\arcanist\bin;C:\Projects\tools\php;%PATH%"
set EDITOR=farrun -e1:1
set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_162
 
alias rar="C:\Program Files\WinRAR\Rar.exe" $*
alias python=C:\Tools\Anaconda3\python.exe $*
alias pwsh=C:\Tools\PowerShell\PowerShell-6.0.2-win-x64\pwsh.exe $*
# alias tig=set "PATH=C:\Program Files\Git\usr\bin;%PATH%" & "C:\Program Files\Git\git-cmd.exe" --no-cd --command=%ConEmuBaseDirShort%\conemu-msys2-64.exe /usr/bin/tig.exe -new_console:nh0
 
# set ConEmuPromptNames=NO
# set ConEmuPromptNL=NO
set CSudoSplitMode=VERT
rem set ConEmuReportExe=AnsiDbg.exe
set TERM=msys
set LANG=ru_RU.utf8
rem set LANG=ru_RU.CP1251
set ConEmuGitPath=C:\PROGRA~1\Git\bin\git.exe
set "gitbranch=>"
 
alias cdc=cd /d "%ConEmuDir%"
alias cd~=cd /d "%UserProfile%"
 
alias "gst=git status & GitShowBranch"
alias gls=git ls-files
alias gl=git-log
alias gl1=git-log -1
alias gl10=git-log -10
alias gln=git-log --name-status
alias glb=git-log --branches --date-order
alias glbr=git-log --branches --date-order --remotes
alias gld=git log --date=short --graph "--pretty=format:%C(auto)%h %C(bold blue)%an %Cgreen%cd  %Creset%s"
alias glu=git log --date=short --graph "--pretty=format:%h %an %cd  %s"
alias "gci=git commit $* & GitShowBranch"
alias "gco=git checkout $* & GitShowBranch"
alias gbr=git branch $*
alias grmt=git remote -v $*
alias gd=git diff --ignore-space-at-eol $*
alias gdc=git diff --cached $*
alias gsh=git show $*
alias ga=git add $*
alias gap=git add -p $*
alias grbc=git rebase --continue
alias gcp=git cherry-pick $* & GitShowBranch
alias gf=git fetch $*  & GitShowBranch
alias ssh-add="C:\Program Files\Git\usr\bin\ssh-add.exe" $*
alias rm="C:\Program Files\Git\usr\bin\rm.exe" $*
~~~
