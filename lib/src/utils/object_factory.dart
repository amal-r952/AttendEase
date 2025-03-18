import 'package:attendance_tracker/src/resources/repository/repository.dart';
import 'package:attendance_tracker/src/utils/dio.dart';
import 'package:attendance_tracker/src/utils/firebase_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'api_client.dart';
import 'hive.dart';

class ObjectFactory {
  static final _objectFactory = ObjectFactory._internal();

  ObjectFactory._internal();

  factory ObjectFactory() => _objectFactory;

  // Firebase Instances
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  ///Initialisation of Objects
  ///
  AppHive _appHive = AppHive();
  ApiClient _apiClient = ApiClient();
  AppDio _appDio = AppDio();
  FirebaseClient? _firebaseClient;
  Repository _repository = Repository();

  /// Getters of Objects

  ApiClient get apiClient => _apiClient;
  AppHive get appHive => _appHive;

  AppDio get appDio => _appDio;
  FirebaseClient get firebaseClient => _firebaseClient ??= FirebaseClient();
  Repository get repository => _repository;
}
