# 🚀 Hosting & Deployment Guide

## Overview

This guide covers deploying your community platform to production. You'll deploy:
- **Frontend** (React) → Vercel, Netlify, or similar
- **Backend** (Node.js) → Heroku, Railway, Render, or similar
- **Database** (MongoDB) → MongoDB Atlas (cloud)

---

## Part 1: Database Setup (MongoDB Atlas)

### Step 1: Create MongoDB Atlas Account
1. Go to [mongodb.com/cloud/atlas](https://mongodb.com/cloud/atlas)
2. Click "Start Free"
3. Create account with email

### Step 2: Create a Cluster
1. Click "Create Deployment"
2. Choose "Free" tier
3. Select cloud provider (AWS recommended)
4. Choose region closest to you
5. Click "Create Deployment"
6. Wait 5-10 minutes for setup

### Step 3: Create Database User
1. Click "Security" → "Database Access"
2. Click "Add New Database User"
3. Username: `admin`
4. Password: Generate secure password (save this!)
5. Click "Add User"

### Step 4: Get Connection String
1. Click "Deployment" → "Databases"
2. Click "Connect"
3. Choose "Drivers"
4. Copy connection string
5. Replace `<username>` and `<password>` with your credentials
6. Save this string!

Example:
```
mongodb+srv://admin:PASSWORD@cluster.mongodb.net/community-platform
```

### Step 5: Whitelist IP
1. Click "Security" → "Network Access"
2. Click "Add IP Address"
3. Click "Allow Access from Anywhere" (for development)
4. Click "Confirm"

---

## Part 2: Deploy Backend

### Option A: Deploy on Railway (Easiest) ⭐ Recommended

#### Step 1: Setup Railway Account
1. Go to [railway.app](https://railway.app)
2. Click "Start Free"
3. Sign up with GitHub

#### Step 2: Create New Project
1. Click "New Project"
2. Click "Deploy from GitHub"
3. Select your repository
4. Click "Deploy"

#### Step 3: Add Environment Variables
1. Click on your project
2. Go to "Variables"
3. Add these variables:
```
MONGODB_URI=mongodb+srv://admin:PASSWORD@cluster.mongodb.net/community-platform
JWT_SECRET=generate-random-32-character-string-here
NODE_ENV=production
CLIENT_URL=https://your-frontend-domain.com
PORT=5000
```

#### Step 4: Deploy
1. Click "Deploy"
2. Wait for build to complete
3. Get your backend URL from the "Deployments" tab

✅ Backend is now live!

---

### Option B: Deploy on Heroku

#### Step 1: Create Heroku Account
1. Go to [heroku.com](https://heroku.com)
2. Sign up for free account

#### Step 2: Install Heroku CLI
```bash
# macOS
brew install heroku

# Windows
# Download from heroku.com/downloads

# Linux
curl https://cli-assets.heroku.com/install.sh | sh
```

#### Step 3: Login to Heroku
```bash
heroku login
```

#### Step 4: Create App
```bash
cd server
heroku create your-app-name
```

#### Step 5: Add Environment Variables
```bash
heroku config:set MONGODB_URI="mongodb+srv://admin:PASSWORD@cluster.mongodb.net/community-platform"
heroku config:set JWT_SECRET="random-32-character-string"
heroku config:set CLIENT_URL="https://your-frontend-domain.com"
heroku config:set NODE_ENV="production"
```

#### Step 6: Deploy
```bash
git push heroku main
```

Monitor with:
```bash
heroku logs --tail
```

✅ Backend is now live!

---

### Option C: Deploy on Render

#### Step 1: Create Render Account
1. Go to [render.com](https://render.com)
2. Sign up

#### Step 2: Create Web Service
1. Click "New Web Service"
2. Connect GitHub repository
3. Select `server` directory as root

#### Step 3: Configure
- Runtime: Node
- Build Command: `npm install`
- Start Command: `npm start`

#### Step 4: Add Environment Variables
```
MONGODB_URI=mongodb+srv://admin:PASSWORD@cluster.mongodb.net/community-platform
JWT_SECRET=random-32-character-string
CLIENT_URL=https://your-frontend-domain.com
NODE_ENV=production
```

#### Step 5: Deploy
Click "Deploy"

✅ Backend is now live!

---

## Part 3: Deploy Frontend

### Option A: Deploy on Vercel (Easiest) ⭐ Recommended

#### Step 1: Create Vercel Account
1. Go to [vercel.com](https://vercel.com)
2. Sign up with GitHub

#### Step 2: Import Project
1. Click "New Project"
2. Select your GitHub repository
3. Set "Root Directory" to `client`
4. Click "Deploy"

#### Step 3: Add Environment Variables
1. Go to "Settings" → "Environment Variables"
2. Add variable:
```
VITE_API_URL=https://your-backend-domain.com
```

#### Step 4: Deploy
Click "Deploy"

✅ Frontend is now live!

---

### Option B: Deploy on Netlify

#### Step 1: Create Netlify Account
1. Go to [netlify.com](https://netlify.com)
2. Sign up with GitHub

#### Step 2: Deploy
1. Click "New site from Git"
2. Select repository
3. Set build command: `npm run build`
4. Set publish directory: `dist`
5. Click "Deploy"

#### Step 3: Add Environment Variables
1. Go to "Site settings" → "Build & deploy" → "Environment"
2. Add:
```
VITE_API_URL=https://your-backend-domain.com
```

#### Step 4: Trigger Redeploy
1. Go to "Deploys"
2. Click "Trigger deploy"

✅ Frontend is now live!

---

## Part 4: Connect Frontend to Backend

### Update API URL

Edit `client/src/utils/api.js`:

```javascript
const API_URL = process.env.VITE_API_URL || 'http://localhost:5000/api';
```

Your frontend will now use the backend URL from environment variables.

---

## Part 5: Testing Your Deployment

### Test Backend
```bash
curl https://your-backend-domain.com/api/health
```

Should return:
```json
{"status": "Server is running"}
```

### Test Frontend
1. Visit `https://your-frontend-domain.com`
2. Sign up for account
3. Create a post
4. Test all features

---

## Troubleshooting

### Backend won't start
- Check environment variables are set
- Check MongoDB connection string is correct
- Check logs: `heroku logs --tail` (Heroku) or platform logs

### Frontend shows blank page
- Check console for errors (F12)
- Check VITE_API_URL is correct
- Check backend is running

### CORS errors
- Check CLIENT_URL in backend matches frontend URL
- Ensure backend CORS is enabled for your frontend domain

### Database connection fails
- Check MONGODB_URI is correct
- Check IP whitelist includes your deployment IP
- Check database user exists with correct password

### Stuck on loading
- Check network tab in browser (F12)
- Ensure backend is responding
- Check Socket.io connection in browser console

---

## Monitoring & Logs

### Railway
- Click project → "Deployments" → View logs

### Heroku
```bash
heroku logs --tail
```

### Render
- Click service → "Logs" tab

### Netlify
- Site → "Deploys" → Click deploy → "Deploy log"

### Vercel
- Click deployment → "Logs"

---

## Scaling & Performance

### Add Database Index
```javascript
// In MongoDB Atlas
db.posts.createIndex({ author: 1 })
db.posts.createIndex({ createdAt: -1 })
```

### Enable Caching
- Vercel/Netlify automatically cache static files
- CDN is included

### Monitor Performance
- Check your hosting dashboard
- Use browser DevTools (F12)
- Monitor database queries

---

## Update & Redeploy

### Update Frontend
```bash
git push origin main
# Vercel/Netlify auto-deploy
```

### Update Backend
```bash
git push origin main
# Auto-deploys on Railway/Heroku/Render
```

---

## Production Checklist

Before going live:

- [ ] MongoDB Atlas cluster created
- [ ] Database user created with strong password
- [ ] IP whitelist configured
- [ ] Backend deployed (test with curl)
- [ ] Frontend deployed (test in browser)
- [ ] Environment variables all set
- [ ] JWT_SECRET is random 32+ characters
- [ ] CLIENT_URL points to frontend domain
- [ ] MONGODB_URI includes credentials
- [ ] All features tested on production
- [ ] Custom domain set up (optional)
- [ ] SSL/HTTPS enabled (automatic on Vercel/Netlify)

---

## Custom Domain (Optional)

### For Frontend (Vercel)
1. Go to "Settings" → "Domains"
2. Add custom domain
3. Follow DNS instructions

### For Backend (Railway)
1. Go to "Settings" → "Domains"
2. Add custom domain
3. Follow CNAME instructions

---

## Cost Estimate

| Service | Cost |
|---------|------|
| MongoDB Atlas | Free (5GB) |
| Vercel Frontend | Free |
| Railway Backend | Free ($5/month credit) |
| **Total** | **~$0-5/month** |

---

## Support

If deployment fails:
1. Check all environment variables
2. Check logs on hosting platform
3. Ensure MongoDB connection works
4. Test backend with curl
5. Check browser console for errors

---

**You're ready to launch! 🚀**
