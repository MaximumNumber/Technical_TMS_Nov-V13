#!/usr/bin/env bash
# ============================================================
#  TMS — Timetable Management System
#  Windows Setup Script (run with Git Bash or WSL)
# ============================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()  { echo -e "${GREEN}[OK]${NC} $1"; }
warn()  { echo -e "${YELLOW}[NOTE]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
step()  { echo -e "\n${YELLOW}>>> $1${NC}"; }

echo "============================================================"
echo "  TMS - Timetable Management System - Windows Setup"
echo "============================================================"
echo ""

# ── Check Python ──────────────────────────────────────────────
step "Step 1/7: Checking Python installation"
if ! command -v python &>/dev/null && ! command -v python3 &>/dev/null; then
    error "Python not found. Install from https://python.org/downloads/ and check 'Add Python to PATH'."
fi

PY=python
if ! command -v python &>/dev/null; then PY=python3; fi
info "Found: $($PY --version)"

# ── Optional virtual environment ──────────────────────────────
step "Step 2/7: Virtual environment"
if [ ! -d "venv" ]; then
    $PY -m venv venv
    info "Virtual environment created."
else
    info "Virtual environment already exists — reusing."
fi

# Activate (works in Git Bash)
if [ -f "venv/Scripts/activate" ]; then
    source venv/Scripts/activate
elif [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
fi
info "Virtual environment activated."

# ── Install dependencies ──────────────────────────────────────
step "Step 3/7: Installing Python packages"
$PY -m pip install --upgrade pip --quiet
$PY -m pip install -r requirements.txt --quiet
info "All packages installed."

# ── Migrations ────────────────────────────────────────────────
step "Step 4/7: Setting up database (migrations)"
$PY manage.py migrate --noinput
info "Database ready."

# ── Static files ──────────────────────────────────────────────
step "Step 5/7: Collecting static files"
$PY manage.py collectstatic --noinput --quiet
info "Static files collected."

# ── Admin account ─────────────────────────────────────────────
step "Step 6/7: Creating System Manager account"
$PY manage.py seed_admin --username admin --password admin123
info "Admin account: admin / admin123"

# ── Seed test data ────────────────────────────────────────────
step "Step 7/7: Seeding test data"
echo "    Seeding universities, colleges, departments, professors,"
echo "    students, schedules, notifications, change requests..."
$PY manage.py seed_data
info "Test data created."

# ── Print credentials ─────────────────────────────────────────
echo ""
echo "============================================================"
echo "  LOGIN CREDENTIALS"
echo "============================================================"
echo "  System Manager : admin        / admin123"
echo "  College Mgr    : mgr_eng      / mgr123"
echo "  College Mgr    : mgr_cs       / mgr123"
echo "  College Mgr    : mgr_sci      / mgr123"
echo "  Dept Head      : dh_cs        / dh123"
echo "  Dept Head      : dh_it        / dh123"
echo "  Dept Head      : dh_elec      / dh123"
echo "  Professor      : prof_ahmed   / prof123"
echo "  Professor      : prof_sara    / prof123"
echo "  Professor      : prof_khalid  / prof123"
echo "  Professor      : prof_fatima  / prof123"
echo "  Student        : std_ali      / std123"
echo "  Student        : std_maryam   / std123"
echo "  Student        : std_ibrahim  / std123"
echo "  Student        : std_salma    / std123"
echo "============================================================"
echo ""
echo "  URL:  http://127.0.0.1:8000"
echo "  Press Ctrl+C to stop the server."
echo "============================================================"
echo ""

# ── Start server ──────────────────────────────────────────────
$PY manage.py runserver 8000
