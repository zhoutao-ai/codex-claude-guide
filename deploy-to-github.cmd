@echo off
chcp 65001 >nul 2>&1

echo ==========================================
echo  Codex & Claude Guide - Deploy to GitHub
echo ==========================================
echo.

REM Step 1: Check GitHub CLI
git --version >nul 2>&1
if %errorlevel% neq 0 (
  echo ERROR: Git is not installed. Please install Git first.
  pause
  exit /b 1
)

gh --version >nul 2>&1
if %errorlevel% neq 0 (
  echo ERROR: GitHub CLI (gh) is not installed.
  echo Download from: https://cli.github.com/
  pause
  exit /b 1
)

REM Step 2: Check login status
git config --get remote.origin.url >nul 2>&1
if %errorlevel% neq 0 (
  echo ERROR: Git remote is not configured.
  pause
  exit /b 1
)

git remote -v

echo.
echo Step 1: Login to GitHub (if not already logged in)
gh auth status >nul 2>&1
if %errorlevel% neq 0 (
  echo You need to login to GitHub first.
  gh auth login
)

echo.
echo Step 2: Create repository and push code
ghecho gh repo create zhoutao-ai/codex-claude-guide --public --source=. --push
gh repo create zhoutao-ai/codex-claude-guide --public --source=. --push
if %errorlevel% neq 0 (
  echo.
  echo Repository may already exist. Trying push only...
  git push -u origin main
)

echo.
echo Step 3: Done! Open Vercel to import your repository:
echo https://vercel.com/new/import?repository-url=https://github.com/zhoutao-ai/codex-claude-guide
echo.
pause
