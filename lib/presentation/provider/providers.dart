import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_chat_app/core/notification/notification_manager.dart';
import 'package:flutter_chat_app/data/datasource/auth_data_source.dart';
import 'package:flutter_chat_app/data/datasource/chat_data_source.dart';
import 'package:flutter_chat_app/data/datasource/image_data_source.dart';
import 'package:flutter_chat_app/data/datasource/user_data_source.dart';
import 'package:flutter_chat_app/data/repository/auth_repository_impl.dart';
import 'package:flutter_chat_app/data/repository/chat_repository_impl.dart';
import 'package:flutter_chat_app/data/repository/image_repository_impl.dart';
import 'package:flutter_chat_app/data/repository/user_repository_impl.dart';
import 'package:flutter_chat_app/domain/repository/auth_repository.dart';
import 'package:flutter_chat_app/domain/repository/chat_repository.dart';
import 'package:flutter_chat_app/domain/repository/image_repository.dart';
import 'package:flutter_chat_app/domain/repository/user_repository.dart';
import 'package:flutter_chat_app/domain/usecase/auth_usecase.dart';
import 'package:flutter_chat_app/domain/usecase/chat_usecase.dart';
import 'package:flutter_chat_app/domain/usecase/image_usecase.dart';
import 'package:flutter_chat_app/domain/usecase/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final firebaseStorageProvider =
    Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);
final notificationProvider =
    StateNotifierProvider<NotificationNotifier, StreamSubscription?>(
        (ref) => NotificationNotifier(ref));

// DataSource Providers
final userDataSourceProvider = Provider<UserDataSource>(
    (ref) => UserDataSource(ref.read(firestoreProvider)));
final chatDataSourceProvider = Provider<ChatDataSource>(
    (ref) => ChatDataSource(ref.read(firestoreProvider)));
final authDataSourceProvider = Provider<AuthDataSource>(
    (ref) => AuthDataSource(ref.read(firebaseAuthProvider)));
final imageDataSourceProvider = Provider<ImageDataSource>(
    (ref) => ImageDataSource(ref.read(firebaseStorageProvider)));

// Repository Providers
final userRepositoryProvider = Provider<UserRepository>(
    (ref) => UserRepositoryImpl(ref.read(userDataSourceProvider)));
final chatRepositoryProvider = Provider<ChatRepository>(
    (ref) => ChatRepositoryImpl(ref.read(chatDataSourceProvider)));
final authRepositoryProvider = Provider<AuthRepository>(
    (ref) => AuthRepositoryImpl(ref.read(authDataSourceProvider)));
final imageRepositoryProvider = Provider<ImageRepository>(
    (ref) => ImageRepositoryImpl(ref.read(imageDataSourceProvider)));

// UseCase Providers
final getUsersUseCaseProvider = Provider<GetUsersUseCase>((ref) =>
    GetUsersUseCase(
        ref.read(userRepositoryProvider), ref.read(imageRepositoryProvider)));
final getUserUseCaseProvider = Provider<GetUserUseCase>((ref) => GetUserUseCase(
    ref.read(userRepositoryProvider), ref.read(imageRepositoryProvider)));
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
    GetCurrentUserUseCase(ref.read(authRepositoryProvider),
        ref.read(userRepositoryProvider), ref.read(imageRepositoryProvider)));
final isEmailAvailableUseCaseProvider = Provider<IsEmailAvailableUseCase>(
    (ref) => IsEmailAvailableUseCase(ref.read(userRepositoryProvider)));
final uploadProfileImageUseCase = Provider<UploadProfileImageUseCase>(
    (ref) => UploadProfileImageUseCase(ref.read(imageRepositoryProvider)));
final getProfileImageUrlUseCase = Provider<GetProfileImageUrlUseCase>(
    (ref) => GetProfileImageUrlUseCase(ref.read(imageRepositoryProvider)));
final updateTokenUseCaseProvider = Provider<UpdateTokenUseCase>((ref) =>
    UpdateTokenUseCase(
        ref.read(authRepositoryProvider), ref.read(userRepositoryProvider)));
final setReceptionAllowedUseCaseProvider = Provider<SetReceptionAllowedUseCase>(
    (ref) => SetReceptionAllowedUseCase(
        ref.read(authRepositoryProvider), ref.read(userRepositoryProvider)));
