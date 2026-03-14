import './config/env.js';
import express from 'express';
import { createServer } from 'http';
import { Server } from 'socket.io';
import cors from 'cors';
import dotenv from 'dotenv';

import { connectDB } from './config/db.js';
import userRoutes from './routes/userRoutes.js';
import postRoutes from './routes/postRoutes.js';
import adminRoutes from './routes/adminRoutes.js';

const app = express();
const httpServer = createServer(app);
const io = new Server(httpServer, {
  cors: {
    origin: process.env.CLIENT_URL || 'http://localhost:3000',
    credentials: true,
  },
});

// Middleware
app.use(cors());
app.use(express.json());

// Database
connectDB();

// Routes
app.use('/api/users', userRoutes);
app.use('/api/posts', postRoutes);
app.use('/api/admin', adminRoutes);

app.get('/api/health', (req, res) => {
  res.json({ status: 'Server is running' });
});

// Socket.io for real-time updates
io.on('connection', (socket) => {
  console.log('User connected:', socket.id);

  socket.on('post-created', (post) => {
    // Sanitize anonymous post before broadcasting
    let sanitizedPost = { ...post };
    if (sanitizedPost.isAnonymous) {
      delete sanitizedPost.author;
    }
    socket.broadcast.emit('new-post', sanitizedPost);
  });

  socket.on('post-liked', (postId) => {
    io.emit('post-updated', { postId, action: 'liked' });
  });

  socket.on('comment-added', (data) => {
    io.emit('post-updated', { postId: data.postId, action: 'commented' });
  });

  socket.on('user-online', (userId) => {
    io.emit('user-status', { userId, status: 'online' });
  });

  socket.on('disconnect', () => {
    console.log('User disconnected:', socket.id);
  });
});

const PORT = process.env.PORT || 5000;
httpServer.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
