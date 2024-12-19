import 'dart:convert';
import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:tractian_challenge/data/services/api/api_client.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}

extension HttpMethodMocks on MockHttpClient {
  void mockGet(String path, Object object) {
    when(() => get(any(), any(), path)).thenAnswer((invocation) {
      final request = MockHttpClientRequest();
      final response = MockHttpClientResponse();
      when(() => request.close()).thenAnswer((_) => Future.value(response));
      when(() => response.statusCode).thenReturn(200);
      when(() => response.transform(utf8.decoder))
          .thenAnswer((_) => Stream.value(jsonEncode(object)));
      return Future.value(request);
    });
  }
}
