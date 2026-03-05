@echo off
REM Truco para que la ventana NUNCA se cierre sola
IF NOT "%KEEPOPEN%"=="1" (
    SET KEEPOPEN=1
    cmd /k "%~f0" %*
    exit /b
)
cd /d "%~dp0"
title RAG Agent - Asistente Local IA
color 0A
cls

echo.
echo  ======================================================
echo   RAG AGENT - Asistente Local de Inteligencia Artificial
echo   100%% Privado y Seguro - Sin conexion a Internet
echo  ======================================================
echo.

REM PASO 1: VERIFICAR DOCKER
echo  [1/5] Verificando Docker Desktop...
docker --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo  [ERROR] Docker Desktop no encontrado.
    echo  https://www.docker.com/products/docker-desktop/
    echo.
    pause
    start https://www.docker.com/products/docker-desktop/
    exit /b 1
)
echo  [OK] Docker Desktop detectado.

REM PASO 2: VERIFICAR OLLAMA
echo  [2/5] Verificando Ollama...
where ollama >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo  [ERROR] Ollama no encontrado.
    echo  https://ollama.com
    echo.
    pause
    start https://ollama.com
    exit /b 1
)
echo  [OK] Ollama detectado.

REM PASO 3: DESCARGAR MODELOS IA
echo  [3/5] Descargando modelos de IA (solo la primera vez, puede tardar)...

REM Deteccion GPU NVIDIA (una sola vez)
nvidia-smi >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    set HAS_NVIDIA=1
) ELSE (
    set HAS_NVIDIA=0
)

REM Seleccionar modelo segun GPU disponible
IF "%HAS_NVIDIA%"=="1" (
    echo  [GPU] GPU NVIDIA detectada - usando modelo completo llama3.1:8b...
    set OLLAMA_CHAT_MODEL=llama3.1:8b
) ELSE (
    echo  [CPU] Sin GPU NVIDIA - usando modelo optimizado para CPU llama3.2:3b...
    set OLLAMA_CHAT_MODEL=llama3.2:3b
)

ollama pull %OLLAMA_CHAT_MODEL%
ollama pull nomic-embed-text
echo  [OK] Modelos de IA listos.

REM PASO 4: DESCARGAR IMAGEN DOCKER
echo  [4/5] Descargando aplicacion desde Docker Hub...
docker pull kabots/rag-mvp:latest
IF %ERRORLEVEL% NEQ 0 (
    echo  [ERROR] No se pudo descargar la imagen. Verifica tu conexion a Internet.
    pause
    exit /b 1
)
echo  [OK] Imagen descargada correctamente.

REM PASO 5: INICIAR SERVICIOS
echo  [5/5] Iniciando servicios...

REM Ollama corre en el host y detecta GPU automaticamente
REM El contenedor app usa PyTorch CPU - no necesita override GPU
IF "%HAS_NVIDIA%"=="1" (
    echo  [GPU] Ollama usara GPU automaticamente.
) ELSE (
    echo  [CPU] Usando CPU.
)

REM Detener contenedores previos para liberar puertos
docker compose -f docker-compose.yml down >nul 2>&1

docker compose -f docker-compose.yml up -d
IF %ERRORLEVEL% NEQ 0 (
    echo  [ERROR] No se pudieron iniciar los servicios.
    echo  Asegurate de que Docker Desktop este abierto.
    pause
    exit /b 1
)
echo  [OK] Servicios iniciados correctamente.

echo.
echo  ======================================================
echo   APLICACION LISTA - Abre tu navegador en:
echo   http://localhost:8000
echo   No cierres esta ventana mientras uses la app.
echo  ======================================================
echo.
timeout /t 3 /nobreak >nul
start http://localhost:8000