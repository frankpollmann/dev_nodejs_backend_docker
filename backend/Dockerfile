FROM node:22.17.0

WORKDIR /app

COPY package*.json ./
RUN npm install
RUN apt-get update && apt-get install -y inotify-tools
RUN npm install swagger-jsdoc swagger-ui-express

COPY . .

EXPOSE 3000

# CMD ["npm", "run", "dev"]
COPY start.sh ./start.sh
RUN chmod +x start.sh
CMD ["./start.sh"]

