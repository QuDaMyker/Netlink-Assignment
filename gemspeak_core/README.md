# GemSpeak Core

<p align="center">
  <img src="https://img.shields.io/badge/NestJS-E0234E?style=for-the-badge&logo=nestjs&logoColor=white" alt="NestJS" />
  <img src="https://img.shields.io/badge/TypeScript-007ACC?style=for-the-badge&logo=typescript&logoColor=white" alt="TypeScript" />
  <img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL" />
  <img src="https://img.shields.io/badge/Prisma-3982CE?style=for-the-badge&logo=Prisma&logoColor=white" alt="Prisma" />
  <img src="https://img.shields.io/badge/Microsoft_Azure-0089D0?style=for-the-badge&logo=microsoft-azure&logoColor=white" alt="Azure" />
  <img src="https://img.shields.io/badge/Google_Cloud-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white" alt="Google Cloud" />
</p>

**GemSpeak Core** is an advanced English pronunciation assessment and learning platform that combines AI-powered feedback with detailed speech analysis to help users improve their speaking skills.

## 🎯 Overview

GemSpeak Core is a comprehensive speech assessment API built with NestJS that provides real-time pronunciation analysis, feedback generation, and learning progress tracking. The platform integrates multiple AI services to deliver accurate speech evaluation and personalized coaching.

## ✨ Key Features

### 🎤 **Speech Recognition & Transcription**
- **Google Cloud Speech-to-Text**: High-accuracy audio transcription with support for multiple audio formats
- **Real-time processing**: Convert speech to text for immediate analysis

### 🗣️ **Advanced Pronunciation Assessment**
- **Microsoft Azure Cognitive Services**: Detailed pronunciation scoring at phoneme, syllable, and word levels
- **Multi-dimensional scoring**: Accuracy, fluency, completeness, and pronunciation scores
- **Error detection**: Identify specific pronunciation errors and areas for improvement

### 🤖 **AI-Powered Feedback**
- **Google Gemini AI**: Intelligent feedback generation for speaking practice
- **Contextual coaching**: Personalized suggestions based on user performance
- **Natural language responses**: Easy-to-understand feedback in conversational format

### 📚 **Comprehensive Learning Management**
- **Speaking Topics**: Organized practice sessions by topic and difficulty
- **Question Bank**: Structured questions for targeted practice
- **Progress Tracking**: Monitor improvement over time with detailed analytics
- **User Statistics**: Performance metrics and learning insights

### 🔐 **Secure User Management**
- **JWT Authentication**: Secure user sessions and API access
- **Password encryption**: BCrypt-based secure password storage
- **User profiles**: Personalized learning experiences

### 📊 **Detailed Analytics**
- **Audio assessments**: Store and analyze pronunciation data
- **Performance metrics**: Track accuracy, fluency, and completion scores
- **Learning insights**: Data-driven recommendations for improvement

## 🏗️ Architecture & Design Patterns

### **Modular Architecture**
- **Domain-driven design**: Organized by business domains (users, assessments, feedback)
- **Separation of concerns**: Clear separation between controllers, services, and repositories
- **Dependency injection**: NestJS IoC container for loose coupling

### **Design Patterns**
- **Repository Pattern**: Data access abstraction with Prisma ORM
- **Service Layer Pattern**: Business logic encapsulation
- **Module Pattern**: Feature-based code organization
- **Middleware Pattern**: Request logging and processing
- **Interceptor Pattern**: Response transformation and error handling

### **API Design**
- **RESTful API**: Standard HTTP methods and status codes
- **OpenAPI/Swagger**: Auto-generated API documentation
- **File upload handling**: Multer integration for audio file processing
- **Validation**: Class-validator for request validation

## 🛠️ Technology Stack

### **Backend Framework**
- **NestJS**: Progressive Node.js framework with TypeScript
- **TypeScript**: Static typing for enhanced development experience
- **Node.js**: Runtime environment

### **Database & ORM**
- **PostgreSQL**: Robust relational database
- **Prisma**: Modern type-safe ORM with schema management
- **UUID**: Secure unique identifiers

### **AI & Speech Services**
- **Google Cloud Speech-to-Text**: Speech recognition and transcription
- **Microsoft Azure Cognitive Services**: Pronunciation assessment
- **Google Gemini AI**: Intelligent feedback generation

### **Authentication & Security**
- **JWT (JSON Web Tokens)**: Stateless authentication
- **BCrypt**: Password hashing and security
- **Class-validator**: Input validation and sanitization

### **Development Tools**
- **ESLint**: Code linting and style enforcement
- **Prettier**: Code formatting
- **Jest**: Testing framework
- **SWC**: Fast compilation and bundling

### **File Handling**
- **Multer**: File upload middleware
- **File system operations**: Audio file processing and storage

## 🗄️ Database Schema

The application uses PostgreSQL with Prisma ORM. Key entities include:

### **Core Entities**
- **Users**: User accounts with authentication
- **Speaking Topics**: Categorized practice topics
- **Questions**: Practice questions linked to topics
- **User Answers**: User responses with audio files

### **Assessment Entities**
- **Audio Assessments**: Pronunciation analysis results
- **Audio Words**: Word-level pronunciation data
- **Audio Syllables**: Syllable-level analysis
- **Audio Phonemes**: Phoneme-level pronunciation scoring

### **Key Relationships**
```
Users → User Answers → Audio Assessments
      ↘ User Stats
      
Speaking Topics → Questions → User Answers

Audio Assessments → Audio Words → Audio Syllables
                              → Audio Phonemes
```

### **Features**
- **UUID primary keys**: Enhanced security and scalability
- **Timestamps**: Created/updated tracking
- **Cascading deletes**: Data integrity maintenance
- **Foreign key constraints**: Referential integrity

## 🚀 Getting Started

### **Prerequisites**
- Node.js (v18 or higher)
- PostgreSQL database
- Google Cloud account with Speech-to-Text API enabled
- Microsoft Azure account with Cognitive Services
- Google AI Studio account for Gemini API

### **Environment Variables**
Create a `.env` file in the root directory:

```env
# Database
DATABASE_URL="postgresql://username:password@localhost:5432/gemspeak_db"

# Google Cloud Speech-to-Text
GOOGLE_APPLICATION_CREDENTIALS="./credentials/gemspeak-ee3bcde1a852.json"

# Microsoft Azure Speech Services
AZURE_SPEECH_KEY="your_azure_speech_key"
AZURE_SPEECH_REGION="your_azure_region"

# Google Gemini AI
GEMINI_API_KEY="your_gemini_api_key"

# JWT
JWT_SECRET="your_jwt_secret"
```

### **Installation**

```bash
# Install dependencies
$ yarn install

# Generate Prisma client
$ npx prisma generate

# Run database migrations
$ npx prisma migrate dev

# Seed database (optional)
$ npx prisma db seed
```

### **Development**

```bash
# Start in development mode
$ yarn run start:dev

# Start in debug mode
$ yarn run start:debug

# Build for production
$ yarn run build

# Start in production mode
$ yarn run start:prod
```

### **Testing**

```bash
# Unit tests
$ yarn run test

# Watch mode
$ yarn run test:watch

# End-to-end tests
$ yarn run test:e2e

# Test coverage
$ yarn run test:cov
```

## 📡 API Endpoints

### **Authentication**
- `POST /auth/login` - User login
- `POST /auth/register` - User registration
- `GET /auth/profile` - Get user profile

### **Speech Assessment**
- `POST /feedback/audio` - Process audio and get feedback
- `POST /feedback/text` - Process text and get feedback
- `POST /pronunciation-assessment-azure` - Azure pronunciation assessment

### **Learning Management**
- `GET /speaking-topics` - Get all speaking topics
- `GET /questions` - Get questions by topic
- `POST /user-answers` - Submit user answers

### **Analytics**
- `GET /user-stats` - Get user learning statistics
- `GET /audio-assessments` - Get assessment history

## 🏗️ Project Structure

```
src/
├── config/                 # Configuration modules
│   ├── log/               # Logging middleware
│   └── response/          # Response interceptors
├── modules/               # Feature modules
│   ├── auth/             # Authentication
│   ├── feedback/         # AI feedback processing
│   ├── gemini/           # Gemini AI service
│   ├── pronunciation_assessment_azure/  # Azure speech services
│   ├── speaking_topics/  # Topic management
│   ├── questions/        # Question management
│   ├── users/           # User management
│   ├── user_answers/    # Answer processing
│   ├── audio_assessments/  # Assessment storage
│   ├── audio_words/     # Word-level analysis
│   ├── audio_syllables/ # Syllable analysis
│   └── audio_phonemes/  # Phoneme analysis
├── prisma/              # Database layer
├── utils/               # Utility functions
└── main.ts             # Application entry point
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### **Development Guidelines**
- Follow TypeScript best practices
- Write unit tests for new features
- Use ESLint and Prettier for code formatting
- Follow NestJS conventions and patterns

## 📋 API Documentation

Once the application is running, visit:
- **Swagger UI**: `http://localhost:3000/builtlab/api/document#/` (if Swagger is configured)
- **API Documentation**: Auto-generated OpenAPI specification

## 🔒 Security Features

- **Input validation**: All inputs validated using class-validator
- **SQL injection prevention**: Prisma ORM provides protection
- **Authentication**: JWT-based secure authentication
- **Password security**: BCrypt hashing with salt
- **File upload security**: Multer with type validation

## 📈 Performance Considerations

- **Database optimization**: Efficient queries with Prisma
- **File handling**: Optimized audio file processing
- **Memory management**: Proper cleanup of audio buffers
- **API rate limiting**: Consider implementing for production

## 🐛 Troubleshooting

### **Common Issues**
1. **Database connection**: Verify PostgreSQL is running and credentials are correct
2. **API keys**: Ensure all API keys are valid and have proper permissions
3. **File uploads**: Check file permissions and storage directory
4. **Audio processing**: Verify audio file formats are supported

### **Logs**
Check application logs for detailed error information:
```bash
# View logs in development
$ yarn run start:dev

## 📝 License

This project is licensed under the [UNLICENSED](LICENSE) license.

## 🙏 Acknowledgments

- **NestJS Team**: For the excellent framework
- **Google Cloud**: Speech-to-Text services
- **Microsoft Azure**: Cognitive Services for speech assessment
- **Google AI**: Gemini AI for intelligent feedback
- **Prisma Team**: For the modern ORM solution

---

<p align="center">
  Built with ❤️ using NestJS, TypeScript, and AI technologies
</p>
