# Connect - Community Platform

A full-stack, production-ready community social platform built with React, Node.js, and MongoDB. Features real-time updates, user authentication, admin dashboard, and a modern elite design.

## 🎯 Features

✅ **User Authentication** - Secure JWT-based login/signup  
✅ **Real-Time Updates** - Socket.io for live interactions  
✅ **Post Management** - Create, edit, delete posts with images  
✅ **Social Features** - Like, comment, follow/unfollow users  
✅ **Admin Dashboard** - Manage users, view statistics  
✅ **Responsive Design** - Mobile-first, modern UI  
✅ **Elite Aesthetics** - Dark luxury theme with smooth animations  

## 📋 Tech Stack

**Frontend:**
- React 18
- React Router v6
- Axios for API calls
- Socket.io Client for real-time updates
- Vite for fast development

**Backend:**
- Node.js + Express
- MongoDB + Mongoose
- JWT for authentication
- Socket.io for real-time communication
- Multer for file uploads

## 🚀 Quick Start

### Prerequisites
- Node.js (v16+)
- MongoDB (local or cloud)
- npm or yarn

### Backend Setup

1. **Navigate to server directory:**
   ```bash
   cd server
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Create .env file:**
   ```bash
   cp .env.example .env
   ```
   Update with your MongoDB URI and JWT secret:
   ```
   MONGODB_URI=mongodb://localhost:27017/community-platform
   JWT_SECRET=your-super-secret-key-change-this
   PORT=5000
   CLIENT_URL=http://localhost:3000
   ```

4. **Start the server:**
   ```bash
   npm start
   # For development with auto-reload:
   npm run dev
   ```
   Server runs on `http://localhost:5000`

### Frontend Setup

1. **Navigate to client directory:**
   ```bash
   cd client
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Start development server:**
   ```bash
   npm run dev
   ```
   App runs on `http://localhost:3000`

## 📁 Project Structure

```
community-platform/
├── server/
│   ├── config/
│   │   └── db.js              # MongoDB connection
│   ├── models/
│   │   ├── User.js            # User schema
│   │   └── Post.js            # Post schema
│   ├── controllers/
│   │   ├── userController.js
│   │   ├── postController.js
│   │   └── adminController.js
│   ├── routes/
│   │   ├── userRoutes.js
│   │   ├── postRoutes.js
│   │   └── adminRoutes.js
│   ├── middleware/
│   │   └── auth.js            # JWT middleware
│   ├── index.js               # Main server file
│   ├── package.json
│   └── .env.example
│
└── client/
    ├── src/
    │   ├── components/
    │   │   ├── Navbar.jsx
    │   │   ├── CreatePost.jsx
    │   │   ├── PostCard.jsx
    │   │   └── ProtectedRoute.jsx
    │   ├── pages/
    │   │   ├── Home.jsx
    │   │   ├── Login.jsx
    │   │   ├── Register.jsx
    │   │   ├── Feed.jsx
    │   │   └── AdminDashboard.jsx
    │   ├── hooks/
    │   │   └── useAuth.js
    │   ├── context/
    │   │   └── AuthContext.jsx
    │   ├── utils/
    │   │   └── api.js
    │   ├── styles/
    │   │   ├── globals.css
    │   │   ├── navbar.css
    │   │   ├── auth.css
    │   │   ├── home.css
    │   │   ├── feed.css
    │   │   ├── post-card.css
    │   │   ├── create-post.css
    │   │   └── admin.css
    │   ├── App.jsx
    │   └── main.jsx
    ├── index.html
    ├── vite.config.js
    └── package.json
```

## 🔑 API Endpoints

### Authentication
- `POST /api/users/register` - Create new account
- `POST /api/users/login` - Login user
- `GET /api/users/profile` - Get current user
- `PUT /api/users/profile` - Update profile

### Posts
- `POST /api/posts` - Create post
- `GET /api/posts` - Get all posts
- `PUT /api/posts/:id` - Update post
- `DELETE /api/posts/:id` - Delete post
- `POST /api/posts/:id/like` - Like post
- `POST /api/posts/:id/unlike` - Unlike post
- `POST /api/posts/:id/comments` - Add comment
- `DELETE /api/posts/:postId/comments/:commentId` - Delete comment

### Admin
- `GET /api/admin/stats` - Dashboard statistics
- `GET /api/admin/users` - All users
- `DELETE /api/admin/users/:userId` - Delete user
- `PATCH /api/admin/users/:userId/status` - Toggle user status
- `PATCH /api/admin/users/:userId/promote` - Promote to admin

## 🎨 Design System

**Color Palette:**
- Primary Dark: `#0a0e27`
- Secondary Dark: `#141b3d`
- Accent Primary: `#00d9ff` (Cyan)
- Accent Secondary: `#ff006e` (Pink)
- Accent Tertiary: `#8b5cf6` (Purple)

**Typography:**
- Headings: Bold, -0.5px letter-spacing
- Body: Inter font, 1.6 line-height

**Animations:**
- Smooth transitions: 0.3s cubic-bezier
- Fade-in on load
- Hover scale effects
- Floating animations

## 🔐 Security Features

- JWT token-based authentication
- Password hashing with bcryptjs
- Protected routes with role-based access
- CORS enabled
- Environment variables for sensitive data

## 📱 Responsive Breakpoints

- Desktop: 1024px+
- Tablet: 768px - 1023px
- Mobile: < 768px

## 🚢 Deployment

### Frontend (Vercel/Netlify)
```bash
npm run build
# Deploy the dist/ folder
```

### Backend (Heroku/Railway)
1. Set environment variables
2. Deploy from GitHub
3. Ensure MongoDB Atlas connection

## 🔧 Environment Variables

**Server (.env):**
```
MONGODB_URI=your_mongodb_connection_string
JWT_SECRET=your_secret_key_min_32_chars
PORT=5000
CLIENT_URL=http://localhost:3000
```

## 📊 MongoDB Collections

**Users:**
```javascript
{
  username: String,
  email: String,
  password: String (hashed),
  profile: {
    avatar: String,
    bio: String,
    location: String,
    website: String
  },
  role: String (user|admin),
  followers: [ObjectId],
  following: [ObjectId],
  isActive: Boolean,
  createdAt: Date,
  updatedAt: Date
}
```

**Posts:**
```javascript
{
  author: ObjectId,
  content: String,
  image: String,
  likes: [ObjectId],
  comments: [
    {
      author: ObjectId,
      content: String,
      likes: [ObjectId],
      createdAt: Date
    }
  ],
  shares: Number,
  createdAt: Date,
  updatedAt: Date
}
```

## 🐛 Troubleshooting

**MongoDB Connection Error:**
- Ensure MongoDB is running
- Check connection string in .env
- Verify network access (Atlas)

**Socket.io Connection Error:**
- Check CORS settings
- Ensure server URL matches client
- Verify firewall settings

**JWT Errors:**
- Clear localStorage (authToken)
- Regenerate tokens
- Check JWT_SECRET in .env

## 📄 License

MIT License - feel free to use this project for personal and commercial use

## 🤝 Contributing

Contributions welcome! Please feel free to submit a Pull Request.

## 📞 Support

For issues and questions, please create a GitHub issue or contact the development team.

---

**Happy building! 🚀**
