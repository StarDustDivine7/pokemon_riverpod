// That si another provider it is feture provider and there have many more provider
//  like that
// 1. Future Provider

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:river_pod/services/http_services.dart';

import '../model/pokamon.dart';

final pokamonDataProvider =
    FutureProvider.family<Pokemon?, String>((ref, url) async {
  HttpServices httpService = GetIt.instance.get<HttpServices>();
  Response? response = await httpService.get(url);
  if (response != null) {
    return Pokemon.fromJson(response.data);
  }

  return null;
});
