# Jalanin di PC (Windows)

Butuh: Python 3.11+, ffmpeg, API key Gemini (gratis di aistudio.google.com).

```bat
git clone <repo-lu> clipper-ai
cd clipper-ai
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
pip install torch --index-url https://download.pytorch.org/whl/cpu
pip install fastapi "uvicorn[standard]" python-multipart
set GOOGLE_API_KEY=isi_key_lu_disini
python -m uvicorn web.api.app:app --host 127.0.0.1 --port 8902
```

Buka http://127.0.0.1:8902/studio — paste link YouTube, atur jumlah klip, Mulai.

Catatan: pertama kali Whisper download model (~500MB), transcribe di CPU agak lama.
```

```powershell
# PowerShell:
$env:GOOGLE_API_KEY="isi_key_lu_disini"
```
