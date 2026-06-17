# LingoBreeze – Vocabulary Deck Feature

LingoBreeze is a language-learning companion application designed to help users systematically save, organize, and read custom vocabulary cards. This codebase represents a complete end-to-end slice implementation consisting of a Node.js REST API layer backed by Google Cloud Firestore and a modern Flutter client.

---

## 🏗️ Architecture & Technical Stack

The architecture focuses strictly on separation of concerns, high maintainability, and loose coupling between data streams and user views.

### Mobile Framework (Flutter)
* **Architecture Layering:** Domain (Pure business entities), Data (Models & HTTP Remote sources), Presentation (UI Layouts & Riverpod controllers).
* **State Management:** Asynchronous Notifier providers via **Riverpod** for robust reactive state mapping.
* **UI/UX Design Standard:** Material 3 implementation incorporating tailored Loading, Error, Empty, and Filled interaction flows.

### Backend Framework (Node.js)
* **API Runtime Engine:** Node.js paired with an Express routing framework.
* **Database Integration:** Document-oriented NoSQL persistence utilizing the official **Google Firebase Admin SDK**.
