# Tool Core 🛠️

A comprehensive Flutter package providing core business logic, data models, networking, and storage utilities for the GemSpeak pronunciation assessment application. This package serves as the foundation layer containing all shared functionality across the application.

## 📋 Features

### 🌐 Networking
- **HTTP Client**: Robust API client built on Dio with interceptors
- **Error Handling**: Centralized error handling and exception management
- **Request/Response Models**: Type-safe API communication
- **Logging**: Pretty logging for development and debugging
- **Authentication**: Built-in auth token management

### 📊 Data Models
- **Speech Assessment**: Comprehensive pronunciation assessment models
- **Audio Analysis**: Detailed audio word, syllable, and phoneme models
- **User Management**: User authentication and progress tracking
- **Learning Content**: Topics, questions, and assessment results
- **AI Feedback**: Gemini AI feedback and suggestions

### 💾 Storage Solutions
- **Abstract Storage**: Platform-agnostic storage interface
- **Local File Storage**: File-based storage implementation
- **In-Memory Storage**: Fast temporary storage for session data
- **Secure Storage**: Encrypted storage for sensitive information

### 🏛️ Repository Pattern
- **Clean Architecture**: Separation of data sources and business logic
- **Interface-based Design**: Easy testing and dependency injection
- **Error Propagation**: Consistent error handling across data layers

## 🏗️ Architecture

### Package Structure
```
lib/
├── config/              # Configuration constants
├── enum/                # Application enumerations
├── error/               # Error handling utilities
├── models/              # Data models and DTOs
│   ├── dto/            # Data Transfer Objects
│   └── enum/           # Model-specific enums
├── network/             # HTTP client and API utilities
├── repositories/        # Repository interfaces and implementations
└── storage/             # Storage abstractions and implementations
```

### Core Components

#### 🌐 Network Layer
- `ApiClient`: Main HTTP client with interceptors
- `ApiResponse<T>`: Generic response wrapper
- `ApiException`: Custom exception handling
- `ApiInterceptor`: Request/response interceptors

#### 📊 Models
- `Topic` & `Question`: Learning content models
- `PronunciationAssessmentAzureRes`: Azure Speech API response
- `AudioAssessment`, `AudioWord`, `AudioSyllable`: Detailed audio analysis
- `GeminiFeedback`: AI-generated feedback and suggestions
- `UserAnswers` & `UserAuth`: User data models

#### 💾 Storage
- `AppStorage<E>`: Generic storage interface
- `LocalFileStorage`: File-based storage implementation
- `InMemoryStorage`: Session-based temporary storage

#### 🏛️ Repositories
- `IUserRepository`: User data operations interface
- `IAuthRepository`: Authentication operations interface
- Concrete implementations with API integration

## 🚀 Getting Started

### Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  tool_core:
    path: packages/tool_core
```

### Basic Usage

#### Initialize API Client
```dart
import 'package:tool_core/tool_core.dart';

// Initialize API client
final apiClient = ApiClient(AppEnv.development, baseUrl: 'https://api.example.com');

// Update base URL dynamically
apiClient.updateBaseUrl('https://new-api.example.com');
```

#### Use Repository Pattern
```dart
// Initialize repository
final userRepository = UserRepository(apiClient);

// Fetch topics
final response = await userRepository.getTopics(
  languageCode: 'en',
  difficultyLevel: 'beginner',
);

if (response.isSuccess) {
  final topics = response.data;
  // Handle successful response
} else {
  // Handle error
  print('Error: ${response.message}');
}
```

#### Pronunciation Assessment
```dart
// Check pronunciation
final assessmentResponse = await userRepository.checkPronunciation(
  audioFilePath: '/path/to/audio.wav',
  text: 'Hello world',
);

if (assessmentResponse.isSuccess) {
  final assessment = assessmentResponse.data;
  print('Pronunciation Score: ${assessment.pronunciationAssessment.pronunciationScore}');
  print('Accuracy Score: ${assessment.pronunciationAssessment.accuracyScore}');
}
```

#### AI Feedback
```dart
// Get Gemini AI feedback
final feedbackResponse = await userRepository.gemeniFeedBackAndPronunciationAssessment(
  audioFilePath: '/path/to/audio.wav',
  questionId: 'question-123',
);

if (feedbackResponse.isSuccess) {
  final feedback = feedbackResponse.data;
  print('Transcript: ${feedback.transcript}');
  // Access detailed pronunciation assessment
  final assessment = feedback.pronunciationAssessment;
}
```

#### Storage Usage
```dart
// Use local file storage
final storage = LocalFileStorage<String>();

// Store data
await storage.setItem('user_preference', 'dark_mode');

// Retrieve data
final preference = await storage.getItem('user_preference');

// Check existence
final exists = await storage.containsKey('user_preference');

// Delete data
await storage.deleteItem('user_preference');
```

## 📋 API Reference

### Core Classes

#### ApiResponse<T>
Generic wrapper for API responses with success/error handling:
```dart
class ApiResponse<T> {
  final bool isSuccess;
  final T? data;
  final String? message;
  final dynamic error;
}
```

#### PronunciationAssessment
Detailed pronunciation scoring:
```dart
class PronunciationAssessment {
  final int? pronunciationScore;   // Overall pronunciation score (0-100)
  final int? accuracyScore;        // Word accuracy score (0-100)
  final int? fluencyScore;         // Speech fluency score (0-100)
  final int? completenessScore;    // Completeness score (0-100)
  final List<WordAssessment>? wordAssessments;
}
```

#### GeminiFeedback
AI-powered feedback:
```dart
class GeminiFeedback {
  final String transcript;
  final PronunciationAssessmentAzureRes pronunciationAssessment;
}
```

### Repository Interfaces

#### IUserRepository
```dart
abstract class IUserRepository {
  Future<ApiResponse<List<Topic>>> getTopics({String? languageCode, String? difficultyLevel});
  Future<ApiResponse<PronunciationAssessmentAzureRes>> checkPronunciation({required String audioFilePath, required String text});
  Future<ApiResponse<GeminiFeedback>> gemeniFeedBackAndPronunciationAssessment({required String audioFilePath, required String questionId});
  // ... more methods
}
```

## 🔧 Configuration

### Environment Setup
```dart
enum AppEnv {
  development,
  staging,
  production;
  
  bool get isDevelopment => this == AppEnv.development;
}
```

### Core Constants
```dart
class CoreConstant {
  static const Duration timeout = Duration(seconds: 30);
  // Other constants...
}
```

## 🧪 Testing

The package includes comprehensive test coverage for:
- Repository implementations
- API client functionality
- Storage operations
- Model serialization/deserialization

Run tests:
```bash
flutter test
```

## 🤝 Contributing

1. Follow the existing code structure and patterns
2. Add tests for new functionality
3. Update documentation for public APIs
4. Ensure all models have proper JSON serialization

## 📄 Dependencies

- `dio ^5.8.0+1`: HTTP client for API communication
- `pretty_dio_logger ^1.4.0`: Development logging
- `flutter_secure_storage ^9.2.4`: Secure data storage
- `intl ^0.20.2`: Internationalization support

## 🏷️ Version History

- **0.0.1**: Initial release with core networking, models, and storage functionality

---

This package is part of the GemSpeak pronunciation learning application ecosystem.
