FROM node:20
WORKDIR /
COPY . .
RUN npm install
CMD ["node", "src/app.js"]
