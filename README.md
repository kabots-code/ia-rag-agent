# RAG Agent - Asistent Local d'Intel·ligència Artificial

## 📋 Descripció

RAG Agent és un asistent d'intel·ligència artificial local i privat que funciona completament sense connexió a Internet. Utilitza tecnologia de **Retrieval-Augmented Generation (RAG)** per proporcionar respostes basades en documents i contextuals.

## ✨ Característiques Principals

- **100% Privat i Segur**: Tota la informació es processa localment, sense enviar dades a servidors externs
- **Sense Connexió a Internet**: Funciona completament offline (excepte la descàrrega inicial de models)
- **Suport per GPU**: Acceleració automàtica per tarjetes gràfiques NVIDIA
- **Fallback a CPU**: Mode optimitzat per ordinadors sense GPU
- **Interfície Web**: Accés fàcil a través del navegador en `http://localhost:8000`
- **Base de Dades Vectorial**: Utilitza Qdrant per a cerques semàntiques eficients
- **Models IA Moderns**: Integra Ollama amb els millors models locals (Llama 3.1/3.2)

## 🚀 Requisits Previs

Abans de poder executar el projecte, necessites instal·lar:

1. **Docker Desktop**
   - Descarrega: https://www.docker.com/products/docker-desktop/
   - Assegura't que s'executa en background

2. **Ollama**
   - Descarrega: https://ollama.com
   - Necessari per executar els models de llenguatge

## ⚙️ Instal·lació i Execució

1. Obri la carpeta del projecte en l'explorador de fitxers

2. Feu doble clic a **`iniciar.bat`**

3. El script verificarà automàticament:
   - ✅ Docker Desktop instal·lat i funcionant
   - ✅ Ollama disponible
   - ✅ Descarregarà els models d'IA necessaris (primera vegada)
   - ✅ Iniciarà els serveis (Qdrant i aplicació RAG)

4. Una vegada completat, s'obrirà automàticament el navegador a:
   ```
   http://localhost:8000
   ```

## 🔍 Solució de Problemes

### Docker Desktop no es va trobar
- Instal·la Docker Desktop des de: https://www.docker.com/products/docker-desktop/
- Assegura't que s'executa (hauria d'estar en la barra de tasques)

### Ollama no es va trobar
- Instal·la Ollama des de: https://ollama.com
- Reinicia la terminal si acabes d'instal·lar-lo

### Els models tarden molt a descarregar
- La primera vegada pot tardar entre 10-30 minuts depenent de la connexió
- Els models es guarden en cache, els pròxims inicis seran més ràpids

### La web no s'obri automàticament
- Intenta accedir manualment a `http://localhost:8000`
- Verifica que Docker Desktop estigui en execució

## 📁 Estructura del Projecte

```
ia-rag-agent/
├── docker-compose.yml       # Configuració de serveis Docker
├── iniciar.bat              # Script principal d'execució
├── shared/                  # Carpeta compartida per a documents
│   ├── manual_teletreballl.txt
│   ├── onboarding.md
│   └── politica_vacances.md
└── README.md                # Aquest fitxer
```

## 🛑 Aturar els Serveis

Per aturar l'aplicació:
- Obri una terminal a la carpeta del projecte i executeu:
  ```bash
  docker compose down
  ```

## 📞 Notes Addicionals

- La primera execució tardarà més temps mentre descarrega i processa els models
- Els models es guarden en local per a futures execucions més ràpides
- La carpeta `shared/` és accessible a l'aplicació per afegir documents
