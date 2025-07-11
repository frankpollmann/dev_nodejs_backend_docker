const express = require('express');
const cors = require('cors');
require('dotenv').config();

const timers = require('./routes/timers');
const app = express();

app.use(cors());
app.use(express.json());
app.use('/timers', timers);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`API läuft auf http://localhost:${PORT}`);
});
