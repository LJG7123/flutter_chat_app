import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/data/datasource/user_data_source.dart';
import 'package:flutter_chat_app/data/repository/user_repository_impl.dart';
import 'package:flutter_chat_app/domain/repository/user_repository.dart';
import 'package:flutter_chat_app/domain/usecase/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

// DataSource Providers
final userDataSourceProvider = Provider<UserDataSource>(
    (ref) => UserDataSource(ref.read(firestoreProvider)));

// Repository Providers
final userRepositoryProvider = Provider<UserRepository>(
    (ref) => UserRepositoryImpl(ref.read(userDataSourceProvider)));

// UseCase Providers
final getUsersUseCaseProvider = Provider<GetUsersUseCase>(
    (ref) => GetUsersUseCase(ref.read(userRepositoryProvider)));
