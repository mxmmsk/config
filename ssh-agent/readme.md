## Task `ssh-agent`

~~~
"%USERPROFILE%\Tools\ssh-agent.cmd" -cur_console:n
~~~

## Task `Startup`

~~~
> {ssh-agent}
{Far}
~~~

## Settings/Startup

Task: `{Startup}`
Delay between consoles initialization: `2500`

**BUGBUG**. 2.5sec is required, otherwise environment variables are not injected properly in started Far tab.
