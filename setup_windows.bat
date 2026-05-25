@echo off
chcp 65001 > nul
echo ============================================================
echo  TMS - Timetable Management System - Windows Setup
echo ============================================================
echo.

REM ── Step 1: Check Python ──────────────────────────────────────
python --version > nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found. Install from https://python.org/downloads/
    echo         Make sure to check "Add Python to PATH" during install.
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('python --version') do echo [OK] Found %%i

REM ── Step 2: Upgrade pip ──────────────────────────────────────
echo.
echo [1/7] Upgrading pip...
python -m pip install --upgrade pip --quiet

REM ── Step 3: Install dependencies ──────────────────────────────
echo [2/7] Installing required packages...
pip install -r requirements.txt --quiet
if errorlevel 1 (
    echo [ERROR] Failed to install packages. Check requirements.txt
    pause
    exit /b 1
)
echo [OK] All packages installed.

REM ── Step 4: Run database migrations ──────────────────────────
echo.
echo [3/7] Running database migrations...
python manage.py migrate --run-syncdb
if errorlevel 1 (
    echo [ERROR] Migration failed.
    pause
    exit /b 1
)
echo [OK] Database ready.

REM ── Step 5: Collect static files ──────────────────────────────
echo.
echo [4/7] Collecting static files...
python manage.py collectstatic --noinput --quiet
echo [OK] Static files collected.

REM ── Step 6: Create admin account ──────────────────────────────
echo.
echo [5/7] Creating system admin account...
python manage.py seed_admin --username admin --password admin123
echo [OK] Admin account: admin / admin123

REM ── Step 7: Seed test data ────────────────────────────────────
echo.
echo [6/7] Seeding rich test data (universities, colleges, departments,
echo       professors, students, schedules, notifications)...
python manage.py seed_data
echo [OK] Test data created.

REM ── Step 8: Start server ──────────────────────────────────────
echo.
echo [7/7] Starting development server on http://127.0.0.1:8000
echo.
echo ============================================================
echo  LOGIN CREDENTIALS
echo ============================================================
echo  System Manager : admin        / admin123
echo  College Mgr    : mgr_eng      / mgr123
echo  College Mgr    : mgr_cs       / mgr123
echo  College Mgr    : mgr_sci      / mgr123
echo  Dept Head      : dh_cs        / dh123
echo  Dept Head      : dh_it        / dh123
echo  Dept Head      : dh_elec      / dh123
echo  Professor      : prof_ahmed   / prof123
echo  Professor      : prof_sara    / prof123
echo  Student        : std_ali      / std123
echo  Student        : std_maryam   / std123
echo ============================================================
echo.
echo  Press Ctrl+C to stop the server.
echo.
python manage.py runserver 8000
pause
