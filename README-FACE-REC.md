# Face Recognition System

This project implements a privacy-focused face recognition system using a hybrid Next.js + Python architecture.

## Tech Stack
- **Frontend**: Next.js App Router
- **Backend**: Next.js API Routes + Prisma (PostgreSQL)
- **AI Service**: Python (FastAPI, InsightFace, FAISS)
- **Storage**: S3 (or R2) / Local Fallback

## Architecture
1. **Upload**: Photos uploaded via Next.js -> Saved to S3 -> Async Trigger to Python Service.
2. **Processing**: Python Service downloads photo, detects faces (RetinaFace), generates embeddings (ArcFace), and groups them using FAISS (Cosine Similarity). Match Threshold: ~0.5.
3. **Storage**: Face embeddings (Float[]) stored in `Face` table. Person grouping stored in `Person` table.
4. **Search**: Client uploads selfie -> Python finds match in FAISS -> Returns `personId` -> Next.js sets HttpOnly Cookie.
5. **View**: API filters photos by `personId` from the cookie (Privacy locked).

## Setup & Deployment

1. **Database**:
   - Ensure PostgreSQL is running.
   - Run migrations: `npx prisma migrate deploy`

2. **Python Service**:
   - Install dependencies: `pip install -r python-service/requirements.txt`
   - Run service: `cd python-service && uvicorn main:app --port 8000`

3. **Next.js App**:
   - Ensure `.env` has `PYTHON_SERVICE_URL="http://localhost:8000"`.
   - Run app: `npm run dev`

## Testing Checklist

- [ ] **Photo Upload**: Upload a photo with multiple faces. Verify `Person` and `Face` records are created in DB.
- [ ] **Grouping**: Upload another photo of the SAME person. Verify they are linked to the SAME `Person` ID.
- [ ] **Selfie Search**: Upload a selfie of that person to `/api/face/search-selfie` (via Postman or UI). Verify `found: true`.
- [ ] **Privacy**: Use the returned cookie to access `/api/gallery/[id]/person/photos`. Verify ONLY their photos are returned.
- [ ] **Negative Test**: Upload a selfie of a stranger. Verify `found: false`.

## Notes
- **FAISS**: The vector index is built in-memory on Python service startup from the DB. If you have millions of faces, consider using `pgvector` extension and updating the service logic.
- **Security**: Images are accessed via Signed URLs.
