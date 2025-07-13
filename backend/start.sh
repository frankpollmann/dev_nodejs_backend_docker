#!/bin/sh

ENTRYPOINT_FILE="/app/src/index.js"

# Funktion zum Starten des Servers
start_server() {
  echo "✅ Datei gefunden: $ENTRYPOINT_FILE"
  echo "🚀 Starte Node-Server..."
  exec node "$ENTRYPOINT_FILE"
}

# Prüfen ob Datei bereits existiert
if [ -f "$ENTRYPOINT_FILE" ]; then
  start_server
else
  echo "🕵️  Warte auf $ENTRYPOINT_FILE ..."

  # Warte auf das Erscheinen der Datei mit inotifywait
  apk add --no-cache inotify-tools >/dev/null 2>&1 || apt-get update && apt-get install -y inotify-tools

  # Überwacht das Verzeichnis, bis index.js auftaucht
  while true; do
    inotifywait -e create /app/src >/dev/null 2>&1
    if [ -f "$ENTRYPOINT_FILE" ]; then
      start_server
    fi
  done
fi
