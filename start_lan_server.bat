@echo off
title SECS - Local School Network Server
echo ========================================================
echo SECS Local School Network Server (Optional LAN Host)
echo ========================================================
echo.
echo Checking for Python...
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Python detected. Launching local web server on port 8080...
    echo.
    echo Teachers on the same school Wi-Fi can connect via:
    echo http://localhost:8080
    echo.
    python -m http.server 8080
    goto end
)

echo Python not found. Starting native Windows PowerShell HTTP server on port 8080...
powershell -ExecutionPolicy Bypass -Command "$port = 8080; $listener = New-Object System.Net.HttpListener; $listener.Prefixes.Add('http://*:' + $port + '/'); $listener.Start(); Write-Host 'SECS Server listening on http://localhost:' $port; start ('http://localhost:' + $port); while($listener.IsListening){ $ctx = $listener.GetContext(); $req = $ctx.Request; $res = $ctx.Response; $urlPath = $req.Url.LocalPath.TrimStart('/'); if([string]::IsNullOrEmpty($urlPath)){ $urlPath = 'index.html' }; $filePath = Join-Path $PSScriptRoot $urlPath; if(Test-Path $filePath){ $bytes = [System.IO.File]::ReadAllBytes($filePath); $res.ContentLength64 = $bytes.Length; $res.OutputStream.Write($bytes, 0, $bytes.Length) } else { $res.StatusCode = 404 }; $res.OutputStream.Close() }"

:end
pause
