#!/bin/sh

ENTRYPOINT_FILE="/app/src/index.js"

if [ -f "$ENTRYPOINT_FILE" ]; then
  echo "✅ Datei gefunden: $ENTRYPOINT_FILE"
  echo "🚀 Starte Node-Server..."
  exec node "$ENTRYPOINT_FILE"
else
  echo "⚠️  Datei fehlt: $ENTRYPOINT_FILE"
  echo "⏳ Warte auf Datei – Container bleibt aktiv..."
  tail -f /dev/null
fi
