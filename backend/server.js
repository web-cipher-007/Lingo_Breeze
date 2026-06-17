const express = require('express');
const cors = require('cors');
const admin = require('firebase-admin');
require('dotenv').config();

// Init Firebase Admin SDK
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();
const app = express();

// Middleware
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 3000;
const COLLECTION_NAME = 'vocabulary';

/**
 * @route   GET /api/words
 * @desc    Retrieve all vocabulary words from Firestore
 */
app.get('/api/words', async (req, res) => {
  try {
    const snapshot = await db.collection(COLLECTION_NAME).orderBy('createdAt', 'desc').get();
    
    const words = [];
    snapshot.forEach(doc => {
      const data = doc.data();
      words.push({
        id: doc.id,
        word: data.word,
        meaning: data.meaning,
        translation: data.translation,
        createdAt: data.createdAt ? data.createdAt.toDate().toISOString() : null
      });
    });

    return res.status(200).json(words);
  } catch (error) {
    console.error('Error fetching words:', error);
    return res.status(500).json({ error: 'Failed to retrieve vocabulary words.' });
  }
});

/**
 * @route   POST /api/words
 * @desc    Create/Save a new vocabulary word to Firestore
 */
app.post('/api/words', async (req, res) => {
  try {
    const { word, meaning, translation } = req.body;

    // Validation (Matching requirements: Word, Meaning, Translation)
    if (!word || !meaning || !translation) {
      return res.status(400).json({ 
        error: 'Missing required fields. Word, meaning, and translation are all required.' 
      });
    }

    const newWordData = {
      word: word.trim(),
      meaning: meaning.trim(),
      translation: translation.trim(),
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    };

    // Save to Firestore
    const docRef = await db.collection(COLLECTION_NAME).add(newWordData);
    
    // Return the newly created object along with its generated ID
    return res.status(201).json({
      id: docRef.id,
      ...newWordData,
      createdAt: new Date().toISOString() // Approximate timestamp for immediate response client-side
    });
  } catch (error) {
    console.error('Error saving word:', error);
    return res.status(500).json({ error: 'Failed to save vocabulary word.' });
  }
});

// start server
app.listen(PORT, () => {
  console.log(` LingoBreeze API server is running on http://localhost:${PORT}`);
});