const express = require('express');
const router = express.Router();
const driver = require('../services/neo4j');

router.get('/', async (req, res) => {
  const session = driver.session();
  try {
    const result = await session.run('MATCH (t:TIMER) RETURN t LIMIT 10');
    const timers = result.records.map(record => record.get('t').properties);
    res.json(timers);
  } catch (error) {
    res.status(500).json({ error: error.message });
  } finally {
    await session.close();
  }
});

module.exports = router;
