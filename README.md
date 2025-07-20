# GemSpeak - AI-Powered English Pronunciation Learning Platform 🗣️

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/NestJS-E0234E?style=for-the-badge&logo=nestjs&logoColor=white" alt="NestJS" />
  <img src="https://img.shields.io/badge/TypeScript-007ACC?style=for-the-badge&logo=typescript&logoColor=white" alt="TypeScript" />
  <img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL" />
  <img src="https://img.shields.io/badge/Microsoft_Azure-0089D0?style=for-the-badge&logo=microsoft-azure&logoColor=white" alt="Azure" />
  <img src="https://img.shields.io/badge/Google_Cloud-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white" alt="Google Cloud" />
</p>

**GemSpeak** is a comprehensive AI-powered English pronunciation learning platform that combines cutting-edge speech recognition technology with intelligent feedback systems to help users master English pronunciation. The platform consists of a cross-platform Flutter mobile application and a robust NestJS backend API.

## 🎯 Project Overview

GemSpeak leverages advanced AI technologies including Azure Speech Services, Google Cloud Speech-to-Text, and Google Gemini AI to provide:

- **Real-time pronunciation assessment** with detailed scoring metrics
- **AI-powered personalized feedback** for continuous improvement
- **Cross-platform accessibility** on mobile, web, and desktop
- **Comprehensive progress tracking** and analytics
- **Interactive learning sessions** with various difficulty levels

## 📱 App Preview

<p align="center">
  <img src="preview/Screenshot_1753026203.png" width="200" alt="Login Screen" />
  <img src="preview/Screenshot_1753026235.png" width="200" alt="Home Screen" />
  <img src="preview/Screenshot_1753026241.png" width="200" alt="Practice Topics" />
  <img src="preview/Screenshot_1753026245.png" width="200" alt="Question Practice" />
</p>

<p align="center">
  <img src="preview/Screenshot_1753026255.png" width="200" alt="Recording Session" />
  <img src="preview/Screenshot_1753026260.png" width="200" alt="AI Feedback" />
  <img src="preview/Screenshot_1753026268.png" width="200" alt="Pronunciation Assessment" />
  <img src="preview/Screenshot_1753026271.png" width="200" alt="Progress Tracking" />
</p>

<p align="center">
  <img src="preview/Screenshot_1753026275.png" width="200" alt="Analytics Dashboard" />
  <img src="preview/Screenshot_1753026278.png" width="200" alt="User Profile" />
  <img src="preview/Screenshot_1753026281.png" width="200" alt="Settings" />
  <img src="preview/Screenshot_1753026284.png" width="200" alt="Learning History" />
</p>

<p align="center">
  <img src="preview/Screenshot_1753026289.png" width="200" alt="Audio Playback" />
</p>

*Experience the intuitive interface designed for effective pronunciation learning across all devices*

## 🏗️ Architecture

This project follows a **microservices architecture** with clear separation between frontend and backend:

```
┌─────────────────────────────────────────────────────────────┐
│                    GemSpeak Platform                        │
├─────────────────────────────────────────────────────────────┤
│  Frontend (gem_speak/)          │  Backend (gemspeak_core/)  │
│  ├─ Flutter Mobile App          │  ├─ NestJS API Server     │
│  ├─ Cross-platform UI           │  ├─ PostgreSQL Database   │
│  ├─ BLoC State Management       │  ├─ Prisma ORM           │
│  └─ Audio Recording/Playback    │  └─ JWT Authentication    │
├─────────────────────────────────────────────────────────────┤
│                    AI Services Integration                   │
│  ├─ Azure Speech Services (Pronunciation Assessment)        │
│  ├─ Google Cloud Speech-to-Text (Transcription)            │
│  └─ Google Gemini AI (Intelligent Feedback)                │
└─────────────────────────────────────────────────────────────┘
```

## 📁 Project Structure

```
netlink_assignment/
├── gem_speak/                  # Flutter Frontend Application
│   ├── lib/
│   │   ├── core/              # Core functionality (auth, env, logger)
│   │   ├── config/            # App configuration (routes, themes)
│   │   ├── common/            # Shared components and widgets
│   │   ├── modules/           # Feature modules (home, practice, etc.)
│   │   └── utils/             # Utility functions
│   ├── assets/                # App assets (images, fonts, animations)
│   ├── android/               # Android-specific configuration
│   ├── ios/                   # iOS-specific configuration
│   └── web/                   # Web-specific configuration
│
├── gemspeak_core/             # NestJS Backend API
│   ├── src/
│   │   ├── config/            # Configuration modules
│   │   ├── modules/           # Feature modules (auth, feedback, etc.)
│   │   ├── prisma/            # Database layer
│   │   └── utils/             # Utility functions
│   ├── prisma/                # Database schema and migrations
│   ├── credentials/           # Service account credentials
│   └── uploads/               # Audio file storage
│
└── README.md                  # This file
```

## 🚀 Features

### 🎤 **Advanced Speech Assessment**
- **Multi-dimensional Scoring**: Pronunciation, accuracy, fluency, and completeness metrics
- **Phoneme-level Analysis**: Detailed breakdown of pronunciation errors
- **Real-time Feedback**: Instant assessment with actionable suggestions
- **Progress Tracking**: Monitor improvement over time with detailed analytics

### 🤖 **AI-Powered Learning**
- **Intelligent Feedback**: Context-aware suggestions powered by Google Gemini AI
- **Personalized Coaching**: Adaptive learning recommendations
- **Speech Recognition**: High-accuracy transcription using Google Cloud Speech-to-Text
- **Error Detection**: Identify specific pronunciation patterns to improve

### 📱 **Cross-Platform Experience**
- **Mobile Apps**: Native iOS and Android applications
- **Web Application**: Browser-based access for desktop users
- **Desktop Apps**: Windows, macOS, and Linux support
- **Responsive Design**: Optimized for various screen sizes

### 📊 **Comprehensive Analytics**
- **Performance Metrics**: Detailed scoring and improvement tracking
- **Learning Insights**: Data-driven recommendations
- **Session History**: Review past practice sessions
- **Progress Visualization**: Charts and graphs for motivation

## 🛠️ Technology Stack

### **Frontend (gem_speak/)**
- **Framework**: Flutter 3.29.3+ with Dart
- **State Management**: flutter_bloc (BLoC pattern)
- **Audio**: record, just_audio, flutter_tts
- **UI/UX**: Custom widgets, Lottie animations, Material Design
- **Storage**: Hive (local database), flutter_secure_storage
- **Navigation**: go_router for declarative routing

### **Backend (gemspeak_core/)**
- **Framework**: NestJS with TypeScript
- **Database**: PostgreSQL with Prisma ORM
- **Authentication**: JWT with BCrypt password hashing
- **File Handling**: Multer for audio uploads
- **Testing**: Jest for unit and e2e testing

### **AI & Cloud Services**
- **Microsoft Azure**: Speech Services for pronunciation assessment
- **Google Cloud**: Speech-to-Text for transcription
- **Google AI**: Gemini AI for intelligent feedback generation

## 🚦 Getting Started

### **Prerequisites**
- Node.js (v18 or higher)
- Flutter SDK (3.7.2 or higher)
- PostgreSQL database
- API keys for Azure Speech Services, Google Cloud, and Gemini AI

### **Quick Start**

1. **Clone the repository**
   ```bash
   git clone https://github.com/QuDaMyker/Netlink-Assignment
   cd netlink_assignment
   ```

2. **Setup Backend (gemspeak_core/)**
   ```bash
   cd gemspeak_core
   yarn install
   cp .env.example .env  # Configure your environment variables
   npx prisma generate
   npx prisma migrate dev
   yarn run start:dev
   ```

3. **Setup Frontend (gem_speak/)**
   ```bash
   cd ../gem_speak
   flutter pub get
   dart run build_runner build --delete-conflicting-outputs
   flutter run
   ```

### **Environment Configuration**

#### Backend (.env)
```env
DATABASE_URL="postgresql://username:password@localhost:5432/gemspeak_db"
GOOGLE_APPLICATION_CREDENTIALS="./credentials/gemspeak-ee3bcde1a852.json"
AZURE_SPEECH_KEY="your_azure_speech_key"
AZURE_SPEECH_REGION="your_azure_region"
GEMINI_API_KEY="your_gemini_api_key"
JWT_SECRET="your_jwt_secret"
```

#### Frontend (.env)
```env
ENVIRONMENT=development
BASE_URL=http://10.0.2.2:3000
```

### **Test Account**

For testing and demonstration purposes, you can use the following test account:

```json
{
  "email": "user@gmail.com",
  "password": "123456"
}
```

*Note: This is a demo account for development and testing. In production, ensure proper user registration and secure password policies.*

## 📚 Documentation

### **API Documentation**
- **Swagger UI**: `http://localhost:3000/api/docs` (when backend is running)
- **Postman Collection**: Available in `gemspeak_core/docs/`

### **Development Guides**
- **Frontend Setup**: See `gem_speak/README.md`
- **Backend Setup**: See `gemspeak_core/README.md`
- **API Reference**: Auto-generated OpenAPI specification
- **Database Schema**: Prisma schema documentation

## 🚀 Deployment

### **Docker Deployment (Recommended)**

GemSpeak provides pre-built Docker images for easy deployment across any environment:

#### **Pre-built Docker Images**
- **Database**: `quocdanhmyker/gemspeak-db:1.0.1`
  - PostgreSQL 17 with pre-configured schema
  - Includes initial database structure and seed data
  - Optimized for production workloads

- **Backend API**: `quocdanhmyker/gemspeak-app:1.0.1`
  - NestJS application with all dependencies
  - Multi-stage build for optimized size (~200MB)
  - Includes Prisma client and database tools

#### **Quick Docker Setup**

1. **Clone the repository**
   ```bash
   git clone https://github.com/QuDaMyker/Netlink-Assignment
   cd netlink_assignment/gemspeak_core
   ```

2. **Configure environment**
   ```bash
   cp .env.example .env.production
   # Edit .env.production with your API keys and configuration
   ```

3. **Deploy with Docker Compose**
   ```bash
   # Start the entire stack
   docker-compose -f docker-compose-server.yml up -d
   
   # View logs
   docker-compose -f docker-compose-server.yml logs -f
   
   # Check status
   docker-compose -f docker-compose-server.yml ps
   ```

4. **Access the application**
   - **API Server**: `http://localhost:4000`
   - **Database**: `localhost:5433`
   - **API Documentation**: `http://localhost:4000/api/docs`

#### **Docker Compose Configuration**

```yaml
# docker-compose-server.yml
version: '3.9'

services:
  db:
    image: quocdanhmyker/gemspeak-db:1.0.1
    container_name: postgres_db
    ports:
      - "5433:5432"
    restart: always
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=gemspeak
      - POSTGRES_DB=gem_speak

  app:
    image: quocdanhmyker/gemspeak-app:1.0.1
    container_name: nest_app
    depends_on:
      - db
    env_file:
      - .env.production
    ports:
      - "4000:3000"
    volumes:
      - ./credentials:/app/credentials:ro
    platform: linux/amd64
    restart: always
```

### **🌐 EC2 Amazon Service Deployment**

The GemSpeak platform has been successfully tested and deployed on **Amazon EC2** using Docker Compose. Here's the complete deployment guide:

#### **EC2 Instance Setup**

**Recommended Instance Configuration:**
- **Instance Type**: t3.medium (2 vCPU, 4 GiB RAM) or higher
- **Operating System**: Ubuntu 22.04 LTS
- **Storage**: 20 GB SSD (minimum)
- **Security Group**: 
  - HTTP (80), HTTPS (443)
  - Custom TCP (4000) for API access
  - SSH (22) for administration

#### **EC2 Deployment Steps**

1. **Connect to EC2 Instance**
   ```bash
   ssh -i your-key.pem ubuntu@your-ec2-public-ip
   ```

2. **Install Docker and Docker Compose**
   ```bash
   # Update system
   sudo apt update && sudo apt upgrade -y
   
   # Install Docker
   sudo apt install docker.io -y
   sudo systemctl start docker
   sudo systemctl enable docker
   sudo usermod -aG docker ubuntu
   
   # Install Docker Compose
   sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose
   
   # Verify installation
   docker --version
   docker-compose --version
   ```

3. **Deploy GemSpeak Application**
   ```bash
   # Clone repository
   git clone https://github.com/QuDaMyker/Netlink-Assignment
   cd Netlink-Assignment/gemspeak_core
   
   # Setup environment
   cp .env.example .env.production
   nano .env.production  # Configure your environment variables
   
   # Create credentials directory
   mkdir -p credentials
   # Upload your Google Cloud credentials file to ./credentials/
   
   # Deploy with Docker Compose
   docker-compose -f docker-compose-server.yml up -d
   ```

4. **Configure Environment Variables for EC2**
   ```env
   # .env.production
   DATABASE_URL="postgresql://postgres:gemspeak@db:5432/gem_speak"
   GOOGLE_APPLICATION_CREDENTIALS="./credentials/gemspeak-ee3bcde1a852.json"
   AZURE_SPEECH_KEY="your_azure_speech_key"
   AZURE_SPEECH_REGION="your_azure_region"
   GEMINI_API_KEY="your_gemini_api_key"
   JWT_SECRET="your_production_jwt_secret_here"
   NODE_ENV="production"
   PORT=3000
   ```

5. **Verify Deployment**
   ```bash
   # Check container status
   docker-compose -f docker-compose-server.yml ps
   
   # View logs
   docker-compose -f docker-compose-server.yml logs -f app
   
   # Test API endpoint
   curl http://localhost:4000/health
   ```

#### **Production Access URLs**

Once deployed on EC2, your application will be accessible at:
- **API Server**: `http://your-ec2-public-ip:4000`
- **API Documentation**: `http://your-ec2-public-ip:4000/api/docs`
- **Health Check**: `http://your-ec2-public-ip:4000/health`

#### **SSL Configuration (Optional)**

For production HTTPS access, configure SSL with Let's Encrypt:

```bash
# Install Nginx
sudo apt install nginx certbot python3-certbot-nginx -y

# Configure Nginx reverse proxy
sudo nano /etc/nginx/sites-available/gemspeak
```

```nginx
# /etc/nginx/sites-available/gemspeak
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:4000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

```bash
# Enable site and get SSL certificate
sudo ln -s /etc/nginx/sites-available/gemspeak /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
sudo certbot --nginx -d your-domain.com
```

#### **Monitoring and Maintenance**

```bash
# View system resources
docker stats

# Backup database
docker-compose exec db pg_dump -U postgres gem_speak > backup_$(date +%Y%m%d).sql

# Update application
docker-compose -f docker-compose-server.yml pull
docker-compose -f docker-compose-server.yml up -d

# View application logs
docker-compose -f docker-compose-server.yml logs -f app | tail -100
```

#### **Cost Optimization for EC2**

- **Instance Type**: Start with t3.small ($15-20/month) for testing
- **Storage**: Use GP3 SSD for better price/performance
- **Auto Scaling**: Configure for traffic fluctuations
- **Reserved Instances**: Save up to 75% for long-term deployments

### **Traditional Deployment**

#### **Backend Deployment**
```bash
cd gemspeak_core
yarn install --production
yarn run build
yarn run start:prod
```

#### **Frontend Deployment**
```bash
cd gem_speak
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

### **Production Considerations**

#### **Environment Variables**
- Use strong JWT secrets for production
- Configure proper CORS settings
- Set up rate limiting and API security
- Enable request logging and monitoring

#### **Database Security**
- Use strong passwords
- Enable SSL connections
- Regular backups to S3
- Monitor database performance

#### **Infrastructure Scaling**
- **Load Balancer**: AWS Application Load Balancer
- **Database**: Amazon RDS PostgreSQL for managed database
- **File Storage**: Amazon S3 for audio file uploads
- **CDN**: CloudFront for global content delivery


### **Development Guidelines**
- Follow the existing code structure and patterns
- Write comprehensive tests for new features
- Update documentation for API changes
- Use semantic commit messages
- Ensure cross-platform compatibility

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Microsoft Azure** for powerful speech assessment capabilities
- **Google Cloud & AI** for speech recognition and intelligent feedback
- **Flutter Team** for the amazing cross-platform framework
- **NestJS Team** for the progressive Node.js framework
- **Open Source Community** for the incredible tools and libraries

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/QuDaMyker/Netlink-Assignment/issues)
- **Documentation**: Check individual README files in each module
- **API Questions**: Refer to Swagger documentation
