# Find Faces Functionality

This document describes the face detection and search features in the Photography Platform.

## Overview

The platform includes comprehensive face recognition capabilities allowing users to:
- Find their photos by uploading a selfie
- Filter gallery views by specific people
- Identify and group photos by detected individuals

## Components

### 1. Face Detection (`src/lib/ai/face.ts`)
- Uses **face-api.js** for face detection and descriptor extraction
- Requires pre-trained models in `public/models/`
- Returns face detections with landmarks and descriptors

**Required Models:**
- `ssd_mobilenetv1_model` - Face detection
- `face_landmark_68_model` - Face landmark detection
- `face_recognition_model` - Face embedding extraction

### 2. Find Faces Utility (`src/lib/ai/find-faces.ts`)
Core utility functions for face operations:

#### `findFacesInImage(imageBuffer, galleryId?)`
Detects faces in an image and finds matching photos across the system.

```typescript
const result = await findFacesInImage(imageBuffer, galleryId);
// Returns: { success, detectedFaces, matchedPhotos, confidence, error? }
```

#### `findPhotosByPerson(galleryId, personId)`
Get all photos containing a specific person in a gallery.

#### `getGalleryPeople(galleryId)`
List all detected people in a gallery with photo counts.

#### `validateModelsAvailable()`
Check if face detection models are properly installed.

### 3. API Endpoints

#### `/api/faces/search` (POST)
Generic face search endpoint using uploaded image.
- **Request:** multipart form with `file` and optional `galleryId`
- **Response:** { success, photos, detectedFaces, confidence }

#### `/api/face/search-selfie` (POST)
Selfie-specific search that sets cookie filters for UI.
- **Request:** multipart form with `file` and `galleryId`
- **Response:** { success, personId } + cookie
- **Fallback:** Uses local face detection if Python service unavailable

### 4. UI Components

#### `FacesList` (`src/components/gallery/FacesList.tsx`)
Displays detected people in a gallery with thumbnail previews.
- Click to filter gallery by person
- Upload selfie to find yourself
- Shows photo count per person

#### `SelfieUploader` (`src/components/search/SelfieUploader.tsx`)
Modal dialog for uploading a selfie to find matching photos.
- File upload input
- Loading states
- Error messaging
- Secure processing

### 5. Backend Processing

#### Python Service (`python-service/main.py`)
Optional backend service for face processing:
- `/process-photo` - Process uploaded photos for face detection
- `/search-selfie` - Find matching people by selfie
- Uses FAISS for fast similarity search
- Stores embeddings in PostgreSQL

## Workflow

### Gallery Upload Flow
1. Admin uploads photo to gallery
2. Photo uploaded to S3/R2
3. Python service triggered to detect faces
4. Face embeddings stored in Postgres
5. FAISS index updated for fast search

### Selfie Search Flow
1. User uploads selfie in gallery view
2. API detects face in selfie
3. Python service searches for matches (if available)
4. Falls back to local detection if needed
5. Filter cookie set for matching person
6. Gallery automatically re-renders showing filtered photos

### Manual Person Filter
1. Click on person thumbnail in FacesList
2. `setGalleryPersonFilter` action called
3. Filter cookie set
4. Gallery filtered to show only photos with that person

## Configuration

### Environment Variables
- `PYTHON_SERVICE_URL` - Optional Python service endpoint (default: `http://localhost:8000`)
- `PINECONE_API_KEY` - Optional vector DB for face similarity search
- `DATABASE_URL` - PostgreSQL connection

### Model Setup
Run the model download script:
```bash
# PowerShell
.\scripts\download-models.ps1

# Node.js
node scripts/download-models.js

# Manual
Download from: https://github.com/justadudewhohacks/face-api.js/tree/master/weights
Place in: public/models/
```

## Error Handling

The system includes graceful degradation:
1. **Missing Models** - Face detection disabled, shows friendly error
2. **Python Service Down** - Falls back to local face-api.js detection
3. **No Faces Detected** - Returns clear error message
4. **No Matches Found** - Returns empty results

## Performance Considerations

- Face detection models load once at startup and are cached
- FAISS index for Python service runs in memory
- Cosine similarity threshold: 0.5 (configurable)
- Search returns top 5 matches by default
- Gallery filtering uses server-side cookies

## Security

- Selfies are processed securely
- Temporary files deleted after processing
- Face embeddings never exposed to client
- Gallery filters use httpOnly cookies
- Person filtering scoped to gallery

## Troubleshooting

### No faces detected
- Ensure image quality is good
- Face should be clearly visible
- Try a frontal or near-frontal angle
- Check that models are properly installed

### Models not loading
```bash
# Verify models exist
ls public/models/

# Re-download if missing
node scripts/download-models.js
```

### Python service connection issues
- Check `PYTHON_SERVICE_URL` environment variable
- Ensure service is running: `python python-service/main.py`
- Check service logs for errors
- System will fall back to local detection if unavailable

## Future Enhancements

- [ ] Improve similarity threshold (machine learning based)
- [ ] Support multiple face search in single image
- [ ] Add face grouping/clustering UI
- [ ] Webhook support for bulk face processing
- [ ] Admin face merge/split interface
