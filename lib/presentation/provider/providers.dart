import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/data/datasource/auth_data_source.dart';
import 'package:flutter_chat_app/data/datasource/chat_data_source.dart';
import 'package:flutter_chat_app/data/datasource/user_data_source.dart';
import 'package:flutter_chat_app/data/repository/auth_repository_impl.dart';
import 'package:flutter_chat_app/data/repository/chat_repository_impl.dart';
import 'package:flutter_chat_app/data/repository/user_repository_impl.dart';
import 'package:flutter_chat_app/domain/repository/auth_repository.dart';
import 'package:flutter_chat_app/domain/repository/chat_repository.dart';
import 'package:flutter_chat_app/domain/repository/user_repository.dart';
import 'package:flutter_chat_app/domain/usecase/auth_usecase.dart';
import 'package:flutter_chat_app/domain/usecase/chat_usecase.dart';
import 'package:flutter_chat_app/domain/usecase/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// DataSource Providers
final userDataSourceProvider = Provider<UserDataSource>(
    (ref) => UserDataSource(ref.read(firestoreProvider)));
final chatDataSourceProvider = Provider<ChatDataSource>(
    (ref) => ChatDataSource(ref.read(firestoreProvider)));
final authDataSourceProvider = Provider<AuthDataSource>(
    (ref) => AuthDataSource(ref.read(firebaseAuthProvider)));

// Repository Providers
final userRepositoryProvider = Provider<UserRepository>(
    (ref) => UserRepositoryImpl(ref.read(userDataSourceProvider)));
final chatRepositoryProvider = Provider<ChatRepository>(
    (ref) => ChatRepositoryImpl(ref.read(chatDataSourceProvider)));
final authRepositoryProvider = Provider<AuthRepository>(
    (ref) => AuthRepositoryImpl(ref.read(authDataSourceProvider)));

// UseCase Providers
final getUsersUseCaseProvider = Provider<GetUsersUseCase>(
    (ref) => GetUsersUseCase(ref.read(userRepositoryProvider)));
final getUserUseCaseProvider = Provider<GetUserUseCase>(
    (ref) => GetUserUseCase(ref.read(userRepositoryProvider)));
final getUsersWithFilterUseCaseProvider = Provider<GetUsersWithFilterUseCase>(
    (ref) => GetUsersWithFilterUseCase(ref.read(userRepositoryProvider)));
final getChatsUseCaseProvider = Provider<GetChatsUseCase>(
    (ref) => GetChatsUseCase(ref.read(chatRepositoryProvider)));
final getMessagesUseCaseProvider = Provider<GetMessagesUseCase>(
    (ref) => GetMessagesUseCase(ref.read(chatRepositoryProvider)));
final createChatUseCaseProvider = Provider<CreateChatUseCase>(
    (ref) => CreateChatUseCase(ref.read(chatRepositoryProvider)));
final sendMessageUseCaseProvider = Provider<SendMessageUseCase>(
    (ref) => SendMessageUseCase(ref.read(chatRepositoryProvider)));
final signInUseCaseProvider = Provider<SignInUseCase>((ref) => SignInUseCase(
    ref.read(authRepositoryProvider), ref.read(userRepositoryProvider)));
final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) => SignUpUseCase(
    ref.read(authRepositoryProvider), ref.read(userRepositoryProvider)));
final signOutUseCaseProvider = Provider<SignOutUseCase>(
    (ref) => SignOutUseCase(ref.read(authRepositoryProvider)));
final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) =>
    GetCurrentUserUseCase(
        ref.read(authRepositoryProvider), ref.read(userRepositoryProvider)));
final isEmailAvailableUseCaseProvider = Provider<IsEmailAvailableUseCase>(
    (ref) => IsEmailAvailableUseCase(ref.read(userRepositoryProvider)));
