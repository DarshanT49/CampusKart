# Render Deployment Guide

## Files Created for Deployment

### 1. **Dockerfile** - Multi-stage Docker build
   - **Build stage**: Maven 3.9 with Java 17 - compiles your app
   - **Runtime stage**: Lightweight Alpine JRE - runs the compiled JAR
   - Exposes port 8080

### 2. **.env.example** - Environment variables template
   - PostgreSQL database configuration
   - Updated Hibernate dialect for PostgreSQL
   - File upload limits
   - Replace credentials with your actual Render PostgreSQL values

### 3. **.dockerignore** - Excludes unnecessary files from Docker context

## Prerequisites

1. **Render Account** - Create one at https://render.com
2. **GitHub Repository** - Push your code to GitHub (Render connects to GitHub)
3. **PostgreSQL Database** - Create one on Render

## Step-by-Step Deployment on Render

### Step 1: Create PostgreSQL Database on Render
1. Go to Render Dashboard → New → PostgreSQL
2. Configure:
   - **Name**: `campuskart-db` (or your choice)
   - **Region**: Choose closest to your users
   - **PostgreSQL Version**: 15+
3. Click "Create Database"
4. Copy the **Internal Database URL** and **External Database URL** (you'll need these)

### Step 2: Create Web Service
1. Go to Render Dashboard → New → Web Service
2. Connect to your GitHub repository
3. Configure:
   - **Name**: `campuskart-api` (or your choice)
   - **Region**: Same as database
   - **Branch**: `main` or your default branch
   - **Build Command**: `mvn clean package -DskipTests`
   - **Start Command**: `java -jar target/*.jar`
   - **Plan**: Choose (Starter = free)

### Step 3: Set Environment Variables
1. In your Web Service settings, go to **Environment**
2. Add the following variables:
   ```
   SPRING_DATASOURCE_URL=postgresql://<user>:<password>@<host>:<port>/<database>
   SPRING_DATASOURCE_USERNAME=<postgres_username>
   SPRING_DATASOURCE_PASSWORD=<postgres_password>
   SPRING_DATASOURCE_DRIVER_CLASS_NAME=org.postgresql.Driver
   SPRING_JPA_DATABASE_PLATFORM=org.hibernate.dialect.PostgreSQLDialect
   SPRING_JPA_HIBERNATE_DDL_AUTO=update
   SPRING_JPA_SHOW_SQL=false
   SPRING_APPLICATION_NAME=campusProject
   SERVER_PORT=8080
   SPRING_SERVLET_MULTIPART_MAX_FILE_SIZE=10MB
   SPRING_SERVLET_MULTIPART_MAX_REQUEST_SIZE=10MB
   ```

3. Get values from your PostgreSQL database URL (format: `postgresql://user:password@host:port/dbname`)

### Step 4: Deploy
1. Click **Deploy** on the Web Service
2. Monitor the build logs in the **Logs** tab
3. Once deployed, you'll get a URL like: `https://campuskart-api.onrender.com`

## Important Notes

### Database Migration
- Since you're moving from MySQL to PostgreSQL:
  - Update `application.properties` to use PostgreSQL dialect (already configured in `.env.example`)
  - Existing MySQL data won't automatically migrate
  - Render will run `ddl-auto=update` to create fresh schema

### File Uploads (uploads/ folder)
- Render's file system is ephemeral (deleted on redeploy)
- For persistent file uploads, use:
  - **Render Disks** (attached storage)
  - **AWS S3** (recommended)
  - **Cloudinary** (image service)

### Port Configuration
- Render automatically assigns a port (usually 8080)
- The Dockerfile and env already configure this

### Build Command
- If your default branch is not `main`, update Render settings accordingly
- Ensure you have `mvnw` or Maven installed for builds

## Docker Image Size Tips
- Current build: ~300-400 MB (lightweight Alpine)
- If too large, you can:
  - Use `spring-boot-thin-layout` (advanced)
  - Remove dev tools from production builds

## Local Testing Before Deployment

```bash
# Build Docker image locally
docker build -t campuskart-app .

# Run with external PostgreSQL
docker run --rm \
  -e SPRING_DATASOURCE_URL=postgresql://user:pass@host:5432/db \
  -e SPRING_DATASOURCE_USERNAME=user \
  -e SPRING_DATASOURCE_PASSWORD=pass \
  -p 8080:8080 \
  campuskart-app
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Build fails | Check Java version (17), check pom.xml syntax |
| Database connection fails | Verify PostgreSQL URL in env vars, check firewall rules |
| App crashes on startup | Check logs tab, ensure all env vars are set |
| File uploads don't persist | Configure file storage (S3, Render Disks, etc.) |

## Next Steps

1. Push the Dockerfile, .env.example, and updated pom.xml to GitHub
2. Create PostgreSQL database on Render
3. Create Web Service and link your GitHub repo
4. Set environment variables
5. Deploy and monitor logs

Good luck! 🚀
