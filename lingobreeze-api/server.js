const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 3000;

// Placeholder GET API for vocabulary words
app.get('/api/words', (req, res) => {
    res.json([
        { id: "1", word: "Bonjour", meaning: "Hello", translation: "French" },
        { id: "2", word: "Amigo", meaning: "Friend", translation: "Spanish" }
    ]);
});

app.listen(PORT, () => {
    console.log(`LingoBreeze API server running on port ${PORT}`);
});