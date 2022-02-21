import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'user_friends_record.g.dart';

abstract class UserFriendsRecord
    implements Built<UserFriendsRecord, UserFriendsRecordBuilder> {
  static Serializer<UserFriendsRecord> get serializer =>
      _$userFriendsRecordSerializer;

  @nullable
  String get userid;

  @nullable
  String get friends;

  @nullable
  @BuiltValueField(wireName: 'time_created')
  DateTime get timeCreated;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UserFriendsRecordBuilder builder) => builder
    ..userid = ''
    ..friends = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user_friends');

  static Stream<UserFriendsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UserFriendsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UserFriendsRecord._();
  factory UserFriendsRecord([void Function(UserFriendsRecordBuilder) updates]) =
      _$UserFriendsRecord;

  static UserFriendsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUserFriendsRecordData({
  String userid,
  String friends,
  DateTime timeCreated,
}) =>
    serializers.toFirestore(
        UserFriendsRecord.serializer,
        UserFriendsRecord((u) => u
          ..userid = userid
          ..friends = friends
          ..timeCreated = timeCreated));
