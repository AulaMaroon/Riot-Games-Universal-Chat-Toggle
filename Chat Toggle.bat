echo off & cls
setlocal enableDelayedExpansion
set /a size=120=1 & rem screen size minus one

net session >nul 2>&1
if %errorlevel% NEQ 0 (
  call:question
  echo.
  echo.
  echo Program Require Admin Rights Please Run as Administrator.
  for /l %%x in (1,1,23) do echo.
  timeout /t 3
  exit
)

:onoroffq
call:question
echo.
echo Appear Offline or Online :
echo.
echo 1. Offline
echo 2. Online
set /p oforon=
if %oforon%==1 goto Offline
if %oforon%==2 goto Online

:Online
netsh advfirewall firewall delete rule name="riotgameschat"
call:question
echo.
echo You Will Appear Online
echo.
timeout /t 5
exit

:Offline
netsh advfirewall firewall add rule name="riotgameschat" dir=out remoteport=5223 protocol=TCP action=block
call:question
echo.
echo You will appear offline.
echo.
timeout /t 5
exit

:question
cls
echo.
echo.
set s=Riot Games Universal Chat Toggle By AulaMaroon
for /L %%# in (1,2,!size!) do if "!s:~%size%,1!" == "" set "s= !s! "
set s=!s:~1,%size%!& echo(!s!
