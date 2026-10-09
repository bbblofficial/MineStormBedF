@echo off
setlocal
cd /d "%~dp0"
if not exist ".git" (
  git init
  git branch -M main
)
git remote get-url origin >nul 2>&1
if errorlevel 1 goto askurl
goto commit
:askurl
set /p URL=GitHub repo URL (https://github.com/USER/REPO.git): 
git remote add origin %URL%
:commit
git add -A
git commit -m "Update BedFight"
for /f "delims=" %%i in ('git rev-parse --abbrev-ref HEAD') do set BR=%%i
git push -u origin %BR%
if errorlevel 1 (
  echo.
  echo Push rejected - retrying with --force-with-lease ...
  git push -u --force-with-lease origin %BR%
)
echo.
echo Done. Open the Actions tab on GitHub and wait for the green check.
pause
