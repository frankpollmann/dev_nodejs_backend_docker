#!/bin/sh

ENTRYPOINT_FILE="/app/src/index.js"

# Funktion: Server mit nodemon starten
start_server() {
  echo "✅ Datei gefunden: $ENTRYPOINT_FILE"
  echo "🚀 Starte mit nodemon..."
  exec npx nodemon "$ENTRYPOINT_FILE"
}

# Falls Datei direkt vorhanden ist → starten
if [ -f "$ENTRYPOINT_FILE" ]; then
  start_server
else
  echo "🕵️  Warte auf $ENTRYPOINT_FILE ..."

  # Stelle sicher, dass inotify-tools installiert ist (für Linux-Dateiwatching)
  if command -v apk >/dev/null 2>&1; then
    apk add --no-cache inotify-tools
  elif command -v apt-get >/dev/null 2>&1; then
    apt-get update && apt-get install -y inotify-tools
  else
    echo "❌ Kein unterstützter Paketmanager gefunden – inotify-tools nicht installiert"
    tail -f /dev/null
    exit 1
  fi

  # Überwache das Verzeichnis, bis index.js erstellt wird
  while true; do
    inotifywait -e create /app/src >/dev/null 2>&1
    if [ -f "$ENTRYPOINT_FILE" ]; then
      start_server
    fi
  done
fi
