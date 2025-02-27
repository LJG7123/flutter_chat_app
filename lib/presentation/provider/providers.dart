import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/data/datasource/chat_data_source.dart';
import 'package:flutter_chat_app/data/datasource/user_data_source.dart';
import 'package:flutter_chat_app/data/repository/chat_repository_impl.dart';
import 'package:flutter_chat_app/data/repository/user_repository_impl.dart';
import 'package:flutter_chat_app/domain/repository/chat_repository.dart';
import 'package:flutter_chat_app/domain/repository/user_repository.dart';
import 'package:flutter_chat_app/domain/usecase/chat_usecase.dart';
import 'package:flutter_chat_app/domain/usecase/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

// DataSource Providers
final userDataSourceProvider = Provider<UserDataSource>(
    (ref) => UserDataSource(ref.read(firestoreProvider)));
final chatDataSourceProvider = Provider<ChatDataSource>(
    (ref) => ChatDataSource(ref.read(firestoreProvider)));

// Repository Providers
final userRepositoryProvider = Provider<UserRepository>(
    (ref) => UserRepositoryImpl(ref.read(userDataSourceProvider)));
final chatRepositoryProvider = Provider<ChatRepository>(
    (ref) => ChatRepositoryImpl(ref.read(chatDataSourceProvider)));

// UseCase Providers
final getUsersUseCaseProvider = Provider<GetUsersUseCase>(
    (ref) => GetUsersUseCase(ref.read(userRepositoryProvider)));
final getChatsUseCaseProvider = Provider<GetChatsUseCase>(
    (ref) => GetChatsUseCase(ref.read(chatRepositoryProvider)));
final getMessagesUseCaseProvider = Provider<GetMessagesUseCase>(
    (ref) => GetMessagesUseCase(ref.read(chatRepositoryProvider)));
final createChatUseCaseProvider = Provider<CreateChatUseCase>(
    (ref) => CreateChatUseCase(ref.read(chatRepositoryProvider)));
final sendMessageUseCaseProvider = Provider<SendMessageUseCase>(
    (ref) => SendMessageUseCase(ref.read(chatRepositoryProvider)));
