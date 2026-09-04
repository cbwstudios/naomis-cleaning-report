@echo off
setlocal
cd /d "%~dp0"
echo.
echo  Naomi's Cleaning Report: publish to GitHub Pages
echo  ------------------------------------------------
where git >nul 2>nul
if errorlevel 1 (
  echo  Git is not installed. Install it from https://git-scm.com/download/win then run this again.
  goto :end
)
if not exist ".git" (
  echo  First run: connecting this folder to GitHub...
  git init
  git checkout -b main >nul 2>nul
  git remote add origin https://github.com/cbwstudios/naomis-cleaning-report.git
)
git config user.name >nul 2>nul || git config user.name "Christian Wert"
git config user.email >nul 2>nul || git config user.email "christian@cbwstudios.me"
echo.
echo  Staging files...
git add -A
git status --short
echo.
git diff --cached --quiet
if not errorlevel 1 (
  echo  Nothing changed since the last publish.
  goto :done
)
echo  Committing...
git commit -m "Report update %date% %time:~0,5%"
if errorlevel 1 (
  echo.
  echo  Commit failed. See the message above.
  goto :end
)
echo.
echo  Pushing to GitHub (a sign-in window may open the first time)...
git push -u origin main
if errorlevel 1 (
  echo.
  echo  Push failed. See the message above. If you were asked to sign in, sign in and run this again.
  goto :end
)
echo.
echo  Pushed. GitHub Pages will update in about a minute.
:done
echo  https://cbwstudios.github.io/naomis-cleaning-report/
:end
echo.
pause
