// scripts/generate-swagger.js
const fs = require('fs');
const swaggerSpec = require('../src/swagger'); // oder wo du swagger.js hast

fs.writeFileSync('./swagger-output.json', JSON.stringify(swaggerSpec, null, 2));
console.log('📄 Swagger-Doku wurde generiert: swagger-output.json');
