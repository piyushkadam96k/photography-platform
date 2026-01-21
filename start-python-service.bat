@echo off
cd /d "%~dp0python-service"
echo Starting Python Face Recognition Service...
uvicorn main:app --reload --host 0.0.0.0 --port 8000
pause
