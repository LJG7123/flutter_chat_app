import 'package:flutter_chat_app/data/datasource/chat_data_source.dart';
import 'package:flutter_chat_app/data/model/chat_model.dart';
import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_chat_app/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource _dataSource;

  ChatRepositoryImpl(this._dataSource);

  @override
  Stream<List<Chat>> getChats(String userId) {
    final models = _dataSource.getChats(userId).map(
          (snapshot) => snapshot.docs.map(
            (doc) => ChatModel.fromJson(doc.id, doc.data()),
          ),
        );

    return models
        .map((data) => data.map((element) => element.toEntity()).toList());
  }
}
