#!/bin/sh

ENTRYPOINT_FILE="/app/src/index.js"

# Funktion zum Starten des Servers
start_server() {
  echo "✅ Datei gefunden: $ENTRYPOINT_FILE"

 
  echo "🚀 Starte mit nodemon..."
  exec npx nodemon "$ENTRYPOINT_FILE"
}

# Sicherstellen, dass inotify-tools installiert sind
if command -v apk >/dev/null 2>&1; then
  apk add --no-cache inotify-tools
elif command -v apt-get >/dev/null 2>&1; then
  apt-get update && apt-get install -y inotify-tools
fi

# Haupt-Loop: entweder direkt starten oder auf Datei warten
while true; do
  if [ -f "$ENTRYPOINT_FILE" ]; then
    start_server
  fi

  echo "🕵️  Datei noch nicht da: $ENTRYPOINT_FILE – warte..."
  inotifywait -e create -e moved_to -e modify /app/src >/dev/null 2>&1
done
