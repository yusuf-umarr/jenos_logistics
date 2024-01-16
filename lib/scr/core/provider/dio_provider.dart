import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/core/interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = "";
  dio.interceptors.add(AppInterceptor());
  return dio;
});
