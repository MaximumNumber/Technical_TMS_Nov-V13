# نظام إدارة الجداول الدراسية (TMS)
## Timetable Management System — Sudan University of Science and Technology

A full **Django 5.2** web application for managing university timetables with an Arabic RTL interface.
Supports **5 user roles**: System Manager, College Manager, Department Head, Professor, Student.

---

## Features

- Full timetable management (Lectures + Labs)
- Real-time conflict detection with alternative suggestions
- Change log with one-click restore
- Real-time notifications with badge counter
- Export / Import (CSV, Excel, PDF)
- Analytics dashboard (room usage, professor workload)
- Full Arabic RTL interface
- Role-based access control with bcrypt password hashing
- Professor change-request workflow (submit → approve/reject → notify)
- Public schedule viewable without login

---

## Running on Windows from Scratch

### What you need

| Requirement | Minimum | Download |
|---|---|---|
| Python | 3.11+ | https://python.org/downloads/ |
| Git (optional) | Any | https://git-scm.com/downloads |

> **During Python installation:** check **"Add Python to PATH"** before clicking Install.

---

### Option A — One-Click Setup (Recommended)

Double-click **`setup_windows.bat`** in the project folder.

It will automatically:
1. Check Python is installed
2. Install all Python packages from `requirements.txt`
3. Create the SQLite database and run migrations
4. Collect static files (CSS, JS, fonts)
5. Create the System Manager account (`admin` / `admin123`)
6. Seed rich test data (universities, colleges, departments, professors, students, schedules, 60+ notifications, 14 change requests)
7. Start the server at **http://127.0.0.1:8000**

---

### Option B — Git Bash / WSL (setup_windows.sh)

If you have Git for Windows installed, open **Git Bash** in the project folder and run:

```bash
bash setup_windows.sh
```

---

### Option C — Manual Step-by-Step (Command Prompt)

Open **Command Prompt** inside the project folder:

```cmd
REM 1. (Optional but recommended) Create a virtual environment
python -m venv venv
venv\Scripts\activate

REM 2. Install all required packages
pip install -r requirements.txt

REM 3. Create and migrate the database
python manage.py migrate

REM 4. Collect static files
python manage.py collectstatic --noinput

REM 5. Create the System Manager (admin) account
python manage.py seed_admin --username admin --password admin123

REM 6. Seed test data (universities, colleges, professors, students, schedules)
python manage.py seed_data

REM 7. Start the development server
python manage.py runserver 8000
```

Open your browser at **http://127.0.0.1:8000**

---

### Daily Start (after first-time setup)

```cmd
venv\Scripts\activate
python manage.py runserver 8000
```

Then open: **http://127.0.0.1:8000**

---

## Login Credentials (All Test Accounts)

| Role | Username | Password | College / Scope |
|---|---|---|---|
| System Manager | `admin` | `admin123` | Full system |
| College Manager | `mgr_eng` | `mgr123` | College of Engineering |
| College Manager | `mgr_cs` | `mgr123` | College of Computer Science |
| College Manager | `mgr_sci` | `mgr123` | College of Science |
| Department Head | `dh_cs` | `dh123` | CS Department |
| Department Head | `dh_it` | `dh123` | IT Department |
| Department Head | `dh_elec` | `dh123` | Electronics Department |
| Professor | `prof_ahmed` | `prof123` | Engineering |
| Professor | `prof_sara` | `prof123` | CS |
| Professor | `prof_khalid` | `prof123` | CS |
| Professor | `prof_fatima` | `prof123` | Science |
| Professor | `prof_omar` | `prof123` | Engineering |
| Professor | `prof_rana` | `prof123` | IT |
| Professor | `prof_yousuf` | `prof123` | Engineering |
| Professor | `prof_najla` | `prof123` | Science |
| Professor | `prof_bakr` | `prof123` | CS |
| Professor | `prof_huda` | `prof123` | IT |
| Student | `std_ali` | `std123` | CS Year 1 |
| Student | `std_maryam` | `std123` | CS Year 1 |
| Student | `std_ibrahim` | `std123` | CS Year 2 |
| Student | `std_salma` | `std123` | Engineering |
| Student | `std_osama` | `std123` | Science |

---

## All Pages & URLs

| Page | URL | Access |
|---|---|---|
| Login | `/login/` | Public |
| Public Timetable | `/schedule/` | Public (no login) |
| System Manager Dashboard | `/admin-dashboard/` | System Manager |
| Universities | `/universities/` | System Manager |
| Branches | `/branches/` | System Manager |
| Colleges | `/colleges/` | System Manager |
| Rooms (admin) | `/admin/rooms/` | System Manager |
| Halls (admin) | `/admin/halls/` | System Manager |
| Users (admin) | `/admin/users/` | System Manager |
| All Schedules | `/admin/all-schedules/` | System Manager |
| Change Log | `/changelog/` | Manager+ |
| Analytics | `/analytics/` | Manager+ |
| Export / Import | `/export-import/` | Manager+ |
| Notifications Center | `/notifications/` | System Manager |
| College Manager Dashboard | `/cm/dashboard/` | CM / Dept Head |
| Departments | `/cm/departments/` | CM |
| Academic Periods | `/cm/academic-periods/` | CM |
| Courses | `/cm/courses/` | CM |
| Specializations | `/cm/specializations/` | CM |
| Instructors | `/cm/instructors/` | CM |
| Rooms (CM) | `/cm/rooms/` | CM |
| Halls (CM) | `/cm/halls/` | CM |
| Students | `/cm/students/` | CM |
| Lecture Schedule | `/cm/schedule/lectures/` | CM / DH |
| Lab Schedule | `/cm/schedule/labs/` | CM / DH |
| Change Requests | `/cm/requests/` | CM / DH |
| Professor Report | `/cm/reports/professor/` | CM |
| Room Report | `/cm/reports/room/` | CM |
| Submission Deadline | `/cm/deadline/` | CM |
| CM Notifications | `/cm/notifications/` | CM / DH |
| Department Heads | `/cm/dept-heads/` | CM |
| Professor Schedule | `/professor/schedule/` | Professor |
| My Change Requests | `/professor/requests/` | Professor |
| Professor Notifications | `/professor/notifications/` | Professor |
| Student Schedule | `/student/schedule/` | Student |
| Download Schedule PDF | `/student/schedule/pdf/` | Student |
| Account Settings | `/account/settings/` | All |
| Change Password | `/change-password/` | All |

---

## Management Commands

```bash
# Create/ensure the System Manager account exists
python manage.py seed_admin --username admin --password admin123

# Seed all test data from scratch
# (Universities, Colleges, Departments, Academic Periods, Courses,
#  Professors, Students, Lecture/Lab Schedules, Notifications, Change Requests)
python manage.py seed_data
```

---

## Tech Stack

| Component | Technology |
|---|---|
| Backend | Django 5.2.14 |
| Database | SQLite (default) / PostgreSQL (production) |
| Password hashing | bcrypt 5.0.0 |
| Static files | WhiteNoise 6.12.0 |
| Forms | django-crispy-forms + crispy-bootstrap5 |
| Frontend | Bootstrap 5 (Arabic RTL) |
| PDF export | ReportLab + arabic-reshaper + python-bidi |
| Excel export | openpyxl |
| Production server | Gunicorn |
| Language | Arabic (ar) |
| Timezone | Africa/Khartoum |

---

## Database (PostgreSQL for Production)

The project uses **SQLite** by default (no setup needed).

To switch to PostgreSQL, edit `tms/settings.py`:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'tms_db',
        'USER': 'tms_user',
        'PASSWORD': 'YourPassword',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}
```

Then create the database:
```sql
CREATE DATABASE tms_db;
CREATE USER tms_user WITH PASSWORD 'YourPassword';
GRANT ALL PRIVILEGES ON DATABASE tms_db TO tms_user;
```

And run:
```bash
pip install psycopg2-binary
python manage.py migrate
```

---

## Common Problems on Windows

| Problem | Solution |
|---|---|
| `python` not recognized | Re-install Python, check "Add Python to PATH". Or use `py` instead of `python`. |
| `pip` not recognized | Use `python -m pip install -r requirements.txt` |
| `No module named 'django'` | Virtual environment not active — run `venv\Scripts\activate` |
| `No module named 'bcrypt'` | Run `pip install bcrypt` |
| `No module named 'reportlab'` | Run `pip install reportlab` |
| `No module named 'arabic_reshaper'` | Run `pip install arabic-reshaper python-bidi` |
| Static files / CSS not loading | Run `python manage.py collectstatic --noinput` |
| Login page keeps redirecting | Clear browser cookies for `127.0.0.1` |
| PDF export fails | Check `static/fonts/Amiri-Regular.ttf` exists |
| Port already in use | Use `python manage.py runserver 8080` and open http://127.0.0.1:8080 |
| `relation does not exist` | Run `python manage.py migrate` |

---

## Project Structure

```
tms/                        Django project settings & URL config
timetable/                  Main application
  models.py                 All database models (25+ models)
  views.py                  All views for all roles
  views_extras.py           Analytics, exports, changelog, notifications
  forms.py                  All Django forms
  urls.py                   All URL patterns (50+ routes)
  backends.py               Custom bcrypt authentication backend
  templatetags/             Custom template filters
  management/
    commands/
      seed_admin.py         Creates the System Manager account
      seed_data.py          Seeds all test data
  migrations/               Database schema migrations
templates/
  base.html                 Base layout (sidebar, topbar, notification badge)
  login.html                Login page
  timetable/                All 40+ page templates
static/
  css/                      Main stylesheet (tms-premium.css)
  fonts/                    Arabic fonts (Amiri) for PDF export
staticfiles/                Collected static files (auto-generated, do not edit)
requirements.txt            All Python dependencies
setup_windows.bat           Windows one-click setup & run script
setup_windows.sh            Git Bash / WSL setup script
README.md                   This file
```
