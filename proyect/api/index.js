const express = require('express');
const cors = require('cors');
const routes = require('./routes/userRoutes');

const app = express();

// ✅ Necesario para que Flutter pueda conectarse
app.use(cors());

// ✅ Necesario para que Express lea JSON
app.use(express.json());

app.use('/api/users', routes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server corriendo en http://localhost:${PORT}`);
});
