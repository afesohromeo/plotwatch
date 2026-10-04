# API Provider & Repository Patterns

## API Provider

**Location:** `lib/src/data/api/{domain}/{feature}_api_provider.dart`

### Canonical Template

```dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:extension_sage_paie/extension_sage_paie.dart';

class MyFeatureApiProvider {
  Dio get _dio => ApiProvider().dioExtSagePaie!;

  // --- Paginated fetch ---
  Future<AppApiResponse> fetchMyFeatures(
    int pageKey, {
    String? keyword,
    int? size,
  }) async {
    try {
      final response = await _dio.get(
        '/api/ext-paie/my-features',
        queryParameters: {
          'size': size ?? 10,
          'page': pageKey,
          'keyword': keyword,
          'sort': 'DESC',
        }..removeWhere((key, value) => value == null),
      );
      return AppApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // --- Fetch all (large page, no UI pagination) ---
  Future<AppApiResponse> fetchAllMyFeatures() async {
    try {
      final response = await _dio.get(
        '/api/ext-paie/my-features',
        queryParameters: {'size': 999, 'page': 0, 'sort': 'DESC'}
            ..removeWhere((key, value) => value == null),
      );
      return AppApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // --- Create ---
  Future<AppApiResponse> createMyFeature(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        '/api/ext-paie/my-features',
        data: jsonEncode(data),
      );
      return AppApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // --- Update ---
  Future<AppApiResponse> updateMyFeature(
      int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        '/api/ext-paie/my-features/$id',
        data: jsonEncode(data),
      );
      return AppApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // --- Delete ---
  Future<AppApiResponse> deleteMyFeature(int id) async {
    try {
      final response =
          await _dio.delete('/api/ext-paie/my-features/$id');
      return AppApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // --- File upload variant ---
  Future<AppApiResponse> createMyFeatureWithFile(
    Map<String, dynamic> data, {
    required Uint8List fileBytes,
    required String fileName,
  }) async {
    try {
      final formData = FormData.fromMap({
        ...data,
        'file': MultipartFile.fromBytes(fileBytes, filename: fileName),
      });
      final response =
          await _dio.post('/api/ext-paie/my-features', data: formData);
      return AppApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
```

### Rules

- Dio instance accessed via lazy getter: `Dio get _dio => ApiProvider().dioExtSagePaie!`
- Query params MUST use `..removeWhere((key, value) => value == null)` for optional fields
- POST/PUT bodies MUST use `jsonEncode(data)` — not raw Map
- File uploads use `FormData.fromMap({...data, 'field': MultipartFile.fromBytes(...)})`
- ALL methods catch ONLY `DioException` and throw `ApiErrorHandler.handle(e)`
- NEVER add business logic here — data transformation belongs in the repository

---

## AppApiResponse

```dart
class AppApiResponse {
  final bool success;   // true if json['success']==true OR json['code']==200
  final String message;
  final Data? data;     // Paginated response container
  final dynamic data2;  // Single object response (cast explicitly at call site)
}

// Paginated container
class Data {
  final List<Map<String, dynamic>> content;  // Raw JSON items
  final Pagination pagination;
}

class Pagination {
  final int? totalElement;
  final int? totalPages;
  final int? size;
}

class PaginatedList {
  final Pagination pagination;
  final List<dynamic> content;   // Cast to List<Model> in repository
}
```

- Use `apiResponse.data` for list endpoints
- Use `apiResponse.data2` for create/update endpoints that return a single object
- Cast `data2`: `MyModel.fromJson(apiResponse.data2 as Map<String, dynamic>)`

---

## Repository

**Location:** `lib/src/domain/repository/{feature}_repository.dart`

### Canonical Template

```dart
import 'dart:developer';
import 'package:extension_sage_paie/extension_sage_paie.dart';

class MyFeatureRepository {
  final MyFeatureApiProvider _apiProvider = MyFeatureApiProvider();

  // --- Paginated fetch → PaginatedList? ---
  Future<PaginatedList?> fetchMyFeatures(
    int pageKey, {
    String? keyword,
    int? size,
  }) async {
    try {
      final res = await _apiProvider.fetchMyFeatures(
        pageKey,
        keyword: keyword,
        size: size,
      );
      if (res.success && res.data != null) {
        return PaginatedList(
          pagination: res.data!.pagination,
          content: List<MyFeature>.from(
            res.data!.content.map((e) => MyFeature.fromJson(e)),
          ),
        );
      }
      return null;
    } catch (e) {
      log('Error fetching my features: $e');
      rethrow;
    }
  }

  // --- Create → Model? ---
  Future<MyFeature?> createMyFeature(Map<String, dynamic> data) async {
    try {
      final res = await _apiProvider.createMyFeature(data);
      if (res.success) {
        return MyFeature.fromJson(res.data2 as Map<String, dynamic>);
      }
      throw Exception(LocalizationService.localization.operationError);
    } catch (e) {
      log('Error creating my feature: $e');
      rethrow;
    }
  }

  // --- Update → Model? ---
  Future<MyFeature?> updateMyFeature(int id, Map<String, dynamic> data) async {
    try {
      final res = await _apiProvider.updateMyFeature(id, data);
      if (res.success) {
        return MyFeature.fromJson(res.data2 as Map<String, dynamic>);
      }
      throw Exception(LocalizationService.localization.operationError);
    } catch (e) {
      log('Error updating my feature: $e');
      rethrow;
    }
  }

  // --- Delete → bool ---
  Future<bool> deleteMyFeature(int id) async {
    try {
      final res = await _apiProvider.deleteMyFeature(id);
      if (res.success) return true;
      throw Exception(LocalizationService.localization.operationError);
    } catch (e) {
      log('Error deleting my feature: $e');
      rethrow;
    }
  }
}
```

### Rules

- API provider is directly instantiated: `final XApiProvider _apiProvider = XApiProvider()`
- Return types:
  - List endpoint → `PaginatedList?` (null = failure)
  - Create/Update → `Model?` (null = failure)
  - Delete → `bool` (false = failure; throw if API returns success: false)
- ALWAYS `log('Error ...: $e')` then `rethrow` — never swallow exceptions
- Error messages from `LocalizationService.localization.*` — never hardcoded strings
- Payload maps are passed in from the BLoC (which gets them from the model's static payload builder)
