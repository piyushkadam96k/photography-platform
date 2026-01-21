# 📸 Professional Photography Platform

<div align="center">

**A production-ready photography platform with AI-powered face recognition, client galleries, semantic search, and integrated e-commerce.**

[![Next.js](https://img.shields.io/badge/Next.js-16-black?style=flat-square&logo=next.js)](https://nextjs.org/)
[![React](https://img.shields.io/badge/React-19-blue?style=flat-square&logo=react)](https://react.dev/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?style=flat-square&logo=postgresql)](https://www.postgresql.org/)
[![Python](https://img.shields.io/badge/Python-3.x-3776ab?style=flat-square&logo=python)](https://python.org/)
[![Stripe](https://img.shields.io/badge/Stripe-Integrated-5469d4?style=flat-square&logo=stripe)](https://stripe.com/)
[![AWS S3](https://img.shields.io/badge/AWS%20S3-Storage-FF9900?style=flat-square&logo=amazonaws)](https://aws.amazon.com/s3/)

[Live Demo](#) • [Documentation](#tech-stack) • [Setup Guide](#setup-instructions) • [Features](#-features)

</div>

---

## ✨ Features

### 🎨 Frontend & UX
- **Responsive Portfolio** - Stunning Next.js 15 frontend with Tailwind CSS and Framer Motion animations
- **Password-Protected Galleries** - Secure client galleries optimized for large photo sets
- **Modern Admin Dashboard** - Manage galleries, orders, orders, and revenue metrics
- **Mobile-Optimized** - Fully responsive design for all devices

### 🤖 AI Integration
- **Face Detection & Recognition** - Advanced face detection using face-api.js on Node.js/Canvas
- **Semantic Search** - AI-powered photo search using Xenova transformers + Pinecone vector database
- **Face Embedding** - Generate and store face embeddings for similarity matching
- **Privacy-Focused** - HttpOnly cookies for secure face recognition results

### 🛍️ E-Commerce
- **Stripe Integration** - Seamless checkout for Digital Downloads and Physical Prints
- **Order Management** - Track and manage customer orders
- **Payment Processing** - Secure payment handling with Stripe webhooks
- **Invoice Generation** - Automated order confirmations

### 🔐 Security & Performance
- **NextAuth Integration** - Secure authentication with role-based access control
- **Environment Variable Protection** - Secure credential management
- **Optimized Images** - Image optimization with Sharp and AWS S3
- **Database Encryption** - PostgreSQL with Prisma ORM

---

## 🛠️ Tech Stack

### Frontend
- **Framework**: Next.js 15 (App Router)
- **UI Library**: React 19
- **Styling**: Tailwind CSS 4 with custom animations
- **Icons**: Lucide React
- **Animations**: Framer Motion
- **State Management**: React Context/Hooks

### Backend
- **Runtime**: Next.js Server Actions & API Routes
- **Database**: PostgreSQL 16 with Prisma ORM
- **Authentication**: NextAuth v5
- **ORM**: Prisma Client

### AI & ML Services
- **Face Detection**: face-api.js (SSD MobileNet)
- **Face Recognition**: InsightFace (Python Service)
- **Semantic Search**: Xenova Transformers
- **Vector Database**: Pinecone
- **Embeddings**: FAISS (similarity matching)

### Cloud & Storage
- **Cloud Storage**: AWS S3 / Cloudflare R2
- **Email Service**: Resend
- **Payment Processing**: Stripe
- **Deployment**: Vercel

### Development Tools
- **Code Quality**: ESLint 9
- **Build Tool**: Next.js Build
- **Package Manager**: npm
- **Type Safety**: TypeScript

---

## 🚀 Quick Start

### Prerequisites
- **Node.js** 18+ and npm
- **Python** 3.9+
- **PostgreSQL** 14+
- AWS S3 / Cloudflare R2 credentials
- Stripe API keys
- Pinecone API key

### 1️⃣ Clone & Install Dependencies

```bash
# Clone the repository
git clone https://github.com/yourusername/photography-platform.git
cd photography-platform

# Install Node dependencies
npm install

# Install Python dependencies
cd python-service
pip install -r requirements.txt
cd ..
```

### 2️⃣ Configure Environment Variables

Create `.env.local` in the root directory:

```bash
# Database
DATABASE_URL="postgresql://user:password@localhost:5432/photography_db"

# AWS S3 / Cloudflare R2
AWS_ACCESS_KEY_ID="your_access_key"
AWS_SECRET_ACCESS_KEY="your_secret_key"
AWS_REGION="us-east-1"
AWS_S3_BUCKET="your-bucket-name"

# Authentication
NEXTAUTH_SECRET="generate-with: openssl rand -base64 32"
NEXTAUTH_URL="http://localhost:3000"

# Stripe
STRIPE_PUBLIC_KEY="pk_live_..."
STRIPE_SECRET_KEY="sk_live_..."
STRIPE_WEBHOOK_SECRET="whsec_..."

# Pinecone Vector DB
PINECONE_API_KEY="your_pinecone_key"
PINECONE_INDEX="photography-index"

# Python Service
PYTHON_SERVICE_URL="http://localhost:8000"

# Email Service
RESEND_API_KEY="your_resend_key"
```

### 3️⃣ Download AI Models

Download face-api.js models into `public/models/`:

```bash
npm run download-models
```

**Or manually download from**: [face-api.js weights](https://github.com/justadudewhohacks/face-api.js/tree/master/weights)

Required models:
- `ssd_mobilenetv1_model`
- `face_landmark_68_model`
- `face_recognition_model`

### 4️⃣ Setup Database

```bash
# Generate Prisma client
npx prisma generate

# Run migrations
npx prisma db push

# Seed database (optional)
npx prisma db seed
```

### 5️⃣ Start Development Servers

**Terminal 1 - Next.js Frontend:**
```bash
npm run dev
# Open http://localhost:3000
```

**Terminal 2 - Python Service:**
```bash
cd python-service
python main.py
# Service runs on http://localhost:8000
```

---

## 📁 Project Structure

```
photography-platform/
├── src/
│   ├── app/              # Next.js pages & layouts
│   ├── components/       # React components
│   ├── lib/              # Utility functions & services
│   ├── types/            # TypeScript definitions
│   ├── actions/          # Server actions
│   └── middleware.ts     # Auth middleware
├── public/
│   ├── models/           # AI model files
│   └── uploads/          # User uploads (photos, temp)
├── prisma/
│   ├── schema.prisma     # Database schema
│   └── migrations/       # Database migrations
├── python-service/       # Face recognition service
│   ├── main.py
│   └── requirements.txt
├── scripts/              # Utility scripts
└── package.json          # Dependencies
```

---

## 🎯 Core Features Deep Dive

### 📷 Face Recognition System

The system uses a hybrid architecture:

1. **Upload Phase**: Photos uploaded → Stored in S3 → Async trigger to Python service
2. **Processing Phase**: Python detects faces → Generates embeddings → Groups using FAISS
3. **Storage Phase**: Embeddings stored in PostgreSQL → Person grouping persisted
4. **Search Phase**: User uploads selfie → Match against FAISS index → Returns personId
5. **Privacy Phase**: API filters photos by personId from HttpOnly cookie

### 🎨 Gallery Management

- Create password-protected galleries
- Organize photos with custom metadata
- Face tagging and grouping
- Batch operations for efficiency
- Gallery sharing with secure links

### 💳 E-Commerce Integration

- One-click Stripe checkout
- Support for digital downloads and physical prints
- Automated order processing
- Invoice generation
- Revenue analytics

### 🔍 Semantic Search

- AI-powered image understanding
- Natural language queries
- Vector-based similarity matching
- Fast search using Pinecone indexes

---

## 🔒 Security Features

- ✅ NextAuth for secure authentication
- ✅ HttpOnly cookies for sensitive data
- ✅ Environment variable protection
- ✅ CSRF protection on forms
- ✅ SQL injection prevention with Prisma ORM
- ✅ S3 bucket policies for access control
- ✅ Secure Stripe webhook validation

---

## 📊 Database Schema

Key tables:
- **Users** - Platform users and admins
- **Galleries** - Photo collections
- **Photos** - Individual images
- **Faces** - Face embeddings and metadata
- **Persons** - Grouped faces (same person)
- **Orders** - Stripe orders
- **Orders Items** - Line items for orders

See `prisma/schema.prisma` for complete schema.

---

## 🚀 Deployment

### Vercel (Recommended)

1. Push code to GitHub
2. Connect repo to Vercel
3. Add environment variables in Vercel settings
4. Deploy with one click

### Docker

```bash
docker build -t photography-platform .
docker run -p 3000:3000 photography-platform
```

### Self-Hosted

```bash
# Build for production
npm run build

# Start production server
npm start
```

---

## 📚 API Documentation

### Key Endpoints

**Photos**
- `POST /api/gallery/upload` - Upload photo
- `GET /api/gallery/:slug` - Get gallery photos
- `DELETE /api/gallery/photo/:id` - Delete photo

**Faces**
- `POST /api/face/detect` - Detect faces in image
- `POST /api/face/search` - Search faces
- `GET /api/faces` - List detected faces

**Checkout**
- `POST /api/checkout/session` - Create Stripe session
- `POST /api/webhooks/stripe` - Handle Stripe events

**Auth**
- `POST /api/auth/signin` - Sign in user
- `POST /api/auth/signout` - Sign out user

---

## ⚠️ Known Issues & Fixes

### 🔴 **TypeScript Build Errors**
**Issue**: Some type-related build errors are being suppressed.
- **Location**: `next.config.ts` has `ignoreBuildErrors: true`
- **Fix Needed**: 
  - Review and fix type errors in component files
  - Remove `ignoreBuildErrors` flag once resolved
  - Run strict type checking: `tsc --noEmit`

### 🟡 **Face Detection Model Loading**
**Issue**: Face detection models may fail to load if not properly downloaded.
- **Location**: `src/lib/ai/find-faces.ts`
- **Symptoms**: Face search returns "Models not available" error
- **Fix**:
  - Ensure all models are in `public/models/` directory
  - Validate manifest files are not corrupted
  - Run `npm run download-models` to re-download
  - Check browser console for specific loading errors

### 🟡 **Pinecone Connection Failures**
**Issue**: Semantic search may fail if Pinecone is not configured or reachable.
- **Location**: Face search and AI integration
- **Symptoms**: No search results or timeout errors
- **Fix**:
  - Verify `PINECONE_API_KEY` in `.env.local`
  - Check `PINECONE_INDEX` exists in Pinecone dashboard
  - Test connection: `curl https://api.pinecone.io -H "Api-Key: $PINECONE_API_KEY"`
  - Review `src/lib/ai/find-faces.ts` error logs

### 🟡 **Python Service Connection Issues**
**Issue**: Python face recognition service may not start or communicate with Next.js.
- **Location**: `python-service/main.py` and API routes
- **Symptoms**: Face detection works via JavaScript but Python embeddings fail
- **Fix**:
  - Ensure Python 3.9+ is installed: `python --version`
  - Check dependencies: `pip install -r python-service/requirements.txt`
  - Verify `PYTHON_SERVICE_URL` is set correctly
  - Test service: `curl http://localhost:8000/health` (if endpoint exists)
  - Review Python service logs for import errors

### 🟡 **S3/R2 Upload Issues**
**Issue**: Photo uploads may fail if S3/R2 credentials are incorrect.
- **Location**: `src/lib/s3.ts` and upload API routes
- **Symptoms**: Upload button unresponsive or "Permission denied" errors
- **Fix**:
  - Verify AWS credentials in `.env.local`
  - Check bucket name and permissions
  - Ensure bucket CORS configuration allows uploads
  - Test with AWS CLI: `aws s3 ls s3://your-bucket-name`

### 🟡 **Database Schema Issues**
**Issue**: PostgreSQL migrations may fail if schema is inconsistent.
- **Location**: `prisma/schema.prisma`
- **Symptoms**: Migration errors or "table already exists" messages
- **Fix**:
  - Reset database: `npx prisma db push --force-reset` (⚠️ data loss)
  - Or manually fix schema conflicts
  - Review migration logs: `cat prisma/migrations/.migration_lock.toml`

### 🟡 **NextAuth Session Issues**
**Issue**: Authentication may fail or sessions may not persist.
- **Location**: `src/lib/auth.ts` and middleware
- **Symptoms**: Users logged out unexpectedly, CSRF token errors
- **Fix**:
  - Generate new `NEXTAUTH_SECRET`: `openssl rand -base64 32`
  - Verify `NEXTAUTH_URL` matches deployment URL
  - Check session storage configuration
  - Clear browser cookies and try again

### 🟡 **Image Optimization Errors**
**Issue**: Sharp or Canvas libraries may fail on certain systems.
- **Location**: `src/lib/image.ts` and face detection
- **Symptoms**: "Canvas is not defined" or image processing failures
- **Fix**:
  - Ensure build tools are installed: `npm install --save-dev node-gyp`
  - Rebuild native modules: `npm rebuild canvas`
  - On macOS: `brew install cairo pkg-config jpeg libpng`
  - On Linux: `apt-get install build-essential libcairo2-dev libpango1.2-dev libjpeg-dev libgif-dev`

### 🟡 **Memory Issues with Large Galleries**
**Issue**: Processing large galleries or many faces consumes excessive memory.
- **Location**: Face detection and embedding generation
- **Symptoms**: Process crashes or slowdowns with 1000+ photos
- **Fix**:
  - Implement batch processing for face detection
  - Add pagination to photo listings
  - Use streaming for large file uploads
  - Monitor memory usage: `node --max-old-space-size=4096`

---

## 🐛 Troubleshooting

### Python Service Not Starting
```bash
# Check if port 8000 is in use
lsof -i :8000
# Verify Python installation
python --version
# Check requirements
pip install -r python-service/requirements.txt
```

### Face Detection Issues
- Ensure all models are downloaded in `public/models/`
- Check Python service is running
- Verify S3 bucket permissions

### Database Connection Errors
```bash
# Test connection
npx prisma db execute --stdin < test_query.sql
# Check DATABASE_URL format
# Verify PostgreSQL is running
```

### Stripe Webhook Failures
- Verify webhook secret in `.env.local`
- Check Stripe CLI is running in development
- Review webhook logs in Stripe Dashboard

---

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Kadam** - Photography Platform Creator

- 📧 Email: kadam@example.com
- 🐙 GitHub: [@kadam](https://github.com/kadam)
- 💼 Location: Based on client work portfolio
- 🎯 Focus: AI-powered photography platform with face recognition and e-commerce integration

---

## 🙏 Acknowledgments

- [face-api.js](https://github.com/justadudewhohacks/face-api.js) for face detection
- [Xenova Transformers](https://xenova.github.io/transformers.js/) for semantic search
- [Stripe](https://stripe.com/) for payment processing
- [Vercel](https://vercel.com/) for hosting
- [Prisma](https://prisma.io/) for ORM

---

## 📞 Support

For support, open an issue on [GitHub Issues](https://github.com/yourusername/photography-platform/issues) or contact the maintainer.

---

<div align="center">

**Made with ❤️ for photographers who want to sell their work**

⭐ Star this repo if you found it helpful!

</div>
- **Database**: Use Railway or AWS RDS.
- **Storage**: Set up an S3 bucket or Cloudflare R2 bucket. Configure CORS to allow your domain.

## Project Structure
- `src/app`: App Router pages.
- `src/components`: Reusable UI components.
- `src/lib`: Utilities (DB, S3, AI, Auth).
- `src/actions`: Server Actions for form handling.
- `prisma`: Database schema.

## AI Pipeline
The platform uses an upload pipeline:
1. Admin uploads photo -> S3.
2. Server triggers `detectFaces(buffer)`.
3. Embeddings are generated using local ONNX runtime.
4. Vectors stored in Pinecone, Metadata in Postgres.
