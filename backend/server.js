const express = require('express');
const neo4j = require('neo4j-driver');

const app = express();
const port = 3000;

const driver = neo4j.driver(
  process.env.NEO4J_URI,
  neo4j.auth.basic(process.env.NEO4J_USER, process.env.NEO4J_PASSWORD)
);

app.get('/', async (req, res) => {
  const session = driver.session();
  try {
    const result = await session.run('RETURN "Neo4j ist verbunden!" AS message');
    res.send(result.records[0].get('message'));
  } catch (err) {
    res.status(500).send('Neo4j-Fehler: ' + err.message);
  } finally {
    await session.close();
  }
});

app.listen(port, () => {
  console.log(`Timer-Backend läuft auf http://localhost:${port}`);
});
