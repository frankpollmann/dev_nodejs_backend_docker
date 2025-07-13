#!/bin/sh

ENTRYPOINT_FILE="/app/src/index.js"

if [ -f "$ENTRYPOINT_FILE" ]; then
  echo "✅ Datei gefunden: $ENTRYPOINT_FILE"
  echo "🚀 Starte Node-Server..."
  node "$ENTRYPOINT_FILE"
else
  echo "⚠️  Datei fehlt: $ENTRYPOINT_FILE"
  echo "🧘 Container läuft weiter im Standby – du kannst die Datei nachreichen."
  
  # Halte den Container "am Leben"
  tail -f /dev/null
fi
