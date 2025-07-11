# Basis-Image mit Node.js
FROM node:18

# Arbeitsverzeichnis im Container
WORKDIR /app

# package.json und package-lock.json reinziehen
COPY package*.json ./

# Dependencies installieren
RUN npm install

# Projektdateien reinkopieren
COPY . .

# Expose – nur informativ (Port wird durch compose geregelt)
EXPOSE 3000

# Default-Befehl wird durch docker-compose überschrieben
CMD ["npm", "run", "dev"]
