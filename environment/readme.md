## Some aliases and env vars for git

~~~
set HOME=C:\Users\XXXX
set "PATH=%ConEmuBaseDir%\Scripts;%PATH%;C:\Program Files (x86)\Git\bin"

alias ant=C:\Java\apache-ant-1.9.7\bin\ant.bat

set TERM=msys
set LANG=ru_RU.utf8
set ConEmuGitPath=C:\PROGRA~2\Git\bin\git.exe
set "gitbranch=>"

alias "gst=git status & GitShowBranch"
alias gls=git ls-files
alias gl=git log --oneline --decorate=short --graph
alias gl10=git log --oneline --decorate=short --graph -10
alias gln=git log --oneline --decorate=short --graph --name-status
alias glb=git log --oneline --decorate=short --graph --branches --date-order
alias glbr=git log --oneline --decorate=short --graph --branches --date-order --remotes
alias gld=git log --date=short --graph "--pretty=format:%C(auto)%h %C(bold blue)%an %Cgreen%cd  %Creset%s"
alias glu=git log --date=short --graph "--pretty=format:%h %an %cd  %s"
alias "gci=git commit $* & GitShowBranch"
alias "gco=git checkout $* & GitShowBranch"
alias gbr=git branch
alias grmt=git remote
alias gd=git diff --ignore-space-at-eol
alias gdc=git diff --cached
alias gsh=git show
alias ga=git add
alias gap=git add -p
alias grbc=git rebase --continue
alias gcp=git cherry-pick
~~~
