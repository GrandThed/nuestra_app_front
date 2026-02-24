// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatApiResponse {

 String get messageId;
/// Create a copy of ChatApiResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatApiResponseCopyWith<ChatApiResponse> get copyWith => _$ChatApiResponseCopyWithImpl<ChatApiResponse>(this as ChatApiResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatApiResponse&&(identical(other.messageId, messageId) || other.messageId == messageId));
}


@override
int get hashCode => Object.hash(runtimeType,messageId);

@override
String toString() {
  return 'ChatApiResponse(messageId: $messageId)';
}


}

/// @nodoc
abstract mixin class $ChatApiResponseCopyWith<$Res>  {
  factory $ChatApiResponseCopyWith(ChatApiResponse value, $Res Function(ChatApiResponse) _then) = _$ChatApiResponseCopyWithImpl;
@useResult
$Res call({
 String messageId
});




}
/// @nodoc
class _$ChatApiResponseCopyWithImpl<$Res>
    implements $ChatApiResponseCopyWith<$Res> {
  _$ChatApiResponseCopyWithImpl(this._self, this._then);

  final ChatApiResponse _self;
  final $Res Function(ChatApiResponse) _then;

/// Create a copy of ChatApiResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = null,}) {
  return _then(_self.copyWith(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatApiResponse].
extension ChatApiResponsePatterns on ChatApiResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChatApiResponseDataRequest value)?  dataRequest,TResult Function( ChatApiResponseResponse value)?  response,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChatApiResponseDataRequest() when dataRequest != null:
return dataRequest(_that);case ChatApiResponseResponse() when response != null:
return response(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChatApiResponseDataRequest value)  dataRequest,required TResult Function( ChatApiResponseResponse value)  response,}){
final _that = this;
switch (_that) {
case ChatApiResponseDataRequest():
return dataRequest(_that);case ChatApiResponseResponse():
return response(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChatApiResponseDataRequest value)?  dataRequest,TResult? Function( ChatApiResponseResponse value)?  response,}){
final _that = this;
switch (_that) {
case ChatApiResponseDataRequest() when dataRequest != null:
return dataRequest(_that);case ChatApiResponseResponse() when response != null:
return response(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String messageId,  String message,  List<ChatToolCallModel> requests)?  dataRequest,TResult Function( String messageId,  String reply,  List<ChatToolCallModel> toolCalls,  List<String> suggestions)?  response,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChatApiResponseDataRequest() when dataRequest != null:
return dataRequest(_that.messageId,_that.message,_that.requests);case ChatApiResponseResponse() when response != null:
return response(_that.messageId,_that.reply,_that.toolCalls,_that.suggestions);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String messageId,  String message,  List<ChatToolCallModel> requests)  dataRequest,required TResult Function( String messageId,  String reply,  List<ChatToolCallModel> toolCalls,  List<String> suggestions)  response,}) {final _that = this;
switch (_that) {
case ChatApiResponseDataRequest():
return dataRequest(_that.messageId,_that.message,_that.requests);case ChatApiResponseResponse():
return response(_that.messageId,_that.reply,_that.toolCalls,_that.suggestions);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String messageId,  String message,  List<ChatToolCallModel> requests)?  dataRequest,TResult? Function( String messageId,  String reply,  List<ChatToolCallModel> toolCalls,  List<String> suggestions)?  response,}) {final _that = this;
switch (_that) {
case ChatApiResponseDataRequest() when dataRequest != null:
return dataRequest(_that.messageId,_that.message,_that.requests);case ChatApiResponseResponse() when response != null:
return response(_that.messageId,_that.reply,_that.toolCalls,_that.suggestions);case _:
  return null;

}
}

}

/// @nodoc


class ChatApiResponseDataRequest implements ChatApiResponse {
  const ChatApiResponseDataRequest({required this.messageId, required this.message, final  List<ChatToolCallModel> requests = const []}): _requests = requests;
  

@override final  String messageId;
 final  String message;
 final  List<ChatToolCallModel> _requests;
@JsonKey() List<ChatToolCallModel> get requests {
  if (_requests is EqualUnmodifiableListView) return _requests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requests);
}


/// Create a copy of ChatApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatApiResponseDataRequestCopyWith<ChatApiResponseDataRequest> get copyWith => _$ChatApiResponseDataRequestCopyWithImpl<ChatApiResponseDataRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatApiResponseDataRequest&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._requests, _requests));
}


@override
int get hashCode => Object.hash(runtimeType,messageId,message,const DeepCollectionEquality().hash(_requests));

@override
String toString() {
  return 'ChatApiResponse.dataRequest(messageId: $messageId, message: $message, requests: $requests)';
}


}

/// @nodoc
abstract mixin class $ChatApiResponseDataRequestCopyWith<$Res> implements $ChatApiResponseCopyWith<$Res> {
  factory $ChatApiResponseDataRequestCopyWith(ChatApiResponseDataRequest value, $Res Function(ChatApiResponseDataRequest) _then) = _$ChatApiResponseDataRequestCopyWithImpl;
@override @useResult
$Res call({
 String messageId, String message, List<ChatToolCallModel> requests
});




}
/// @nodoc
class _$ChatApiResponseDataRequestCopyWithImpl<$Res>
    implements $ChatApiResponseDataRequestCopyWith<$Res> {
  _$ChatApiResponseDataRequestCopyWithImpl(this._self, this._then);

  final ChatApiResponseDataRequest _self;
  final $Res Function(ChatApiResponseDataRequest) _then;

/// Create a copy of ChatApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? message = null,Object? requests = null,}) {
  return _then(ChatApiResponseDataRequest(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,requests: null == requests ? _self._requests : requests // ignore: cast_nullable_to_non_nullable
as List<ChatToolCallModel>,
  ));
}


}

/// @nodoc


class ChatApiResponseResponse implements ChatApiResponse {
  const ChatApiResponseResponse({required this.messageId, required this.reply, final  List<ChatToolCallModel> toolCalls = const [], final  List<String> suggestions = const []}): _toolCalls = toolCalls,_suggestions = suggestions;
  

@override final  String messageId;
 final  String reply;
 final  List<ChatToolCallModel> _toolCalls;
@JsonKey() List<ChatToolCallModel> get toolCalls {
  if (_toolCalls is EqualUnmodifiableListView) return _toolCalls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_toolCalls);
}

 final  List<String> _suggestions;
@JsonKey() List<String> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}


/// Create a copy of ChatApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatApiResponseResponseCopyWith<ChatApiResponseResponse> get copyWith => _$ChatApiResponseResponseCopyWithImpl<ChatApiResponseResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatApiResponseResponse&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.reply, reply) || other.reply == reply)&&const DeepCollectionEquality().equals(other._toolCalls, _toolCalls)&&const DeepCollectionEquality().equals(other._suggestions, _suggestions));
}


@override
int get hashCode => Object.hash(runtimeType,messageId,reply,const DeepCollectionEquality().hash(_toolCalls),const DeepCollectionEquality().hash(_suggestions));

@override
String toString() {
  return 'ChatApiResponse.response(messageId: $messageId, reply: $reply, toolCalls: $toolCalls, suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class $ChatApiResponseResponseCopyWith<$Res> implements $ChatApiResponseCopyWith<$Res> {
  factory $ChatApiResponseResponseCopyWith(ChatApiResponseResponse value, $Res Function(ChatApiResponseResponse) _then) = _$ChatApiResponseResponseCopyWithImpl;
@override @useResult
$Res call({
 String messageId, String reply, List<ChatToolCallModel> toolCalls, List<String> suggestions
});




}
/// @nodoc
class _$ChatApiResponseResponseCopyWithImpl<$Res>
    implements $ChatApiResponseResponseCopyWith<$Res> {
  _$ChatApiResponseResponseCopyWithImpl(this._self, this._then);

  final ChatApiResponseResponse _self;
  final $Res Function(ChatApiResponseResponse) _then;

/// Create a copy of ChatApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? reply = null,Object? toolCalls = null,Object? suggestions = null,}) {
  return _then(ChatApiResponseResponse(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String,toolCalls: null == toolCalls ? _self._toolCalls : toolCalls // ignore: cast_nullable_to_non_nullable
as List<ChatToolCallModel>,suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ChatHistoryResponse {

 List<ChatMessageModel> get messages; bool get hasMore;
/// Create a copy of ChatHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatHistoryResponseCopyWith<ChatHistoryResponse> get copyWith => _$ChatHistoryResponseCopyWithImpl<ChatHistoryResponse>(this as ChatHistoryResponse, _$identity);

  /// Serializes this ChatHistoryResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatHistoryResponse&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(messages),hasMore);

@override
String toString() {
  return 'ChatHistoryResponse(messages: $messages, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $ChatHistoryResponseCopyWith<$Res>  {
  factory $ChatHistoryResponseCopyWith(ChatHistoryResponse value, $Res Function(ChatHistoryResponse) _then) = _$ChatHistoryResponseCopyWithImpl;
@useResult
$Res call({
 List<ChatMessageModel> messages, bool hasMore
});




}
/// @nodoc
class _$ChatHistoryResponseCopyWithImpl<$Res>
    implements $ChatHistoryResponseCopyWith<$Res> {
  _$ChatHistoryResponseCopyWithImpl(this._self, this._then);

  final ChatHistoryResponse _self;
  final $Res Function(ChatHistoryResponse) _then;

/// Create a copy of ChatHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,Object? hasMore = null,}) {
  return _then(_self.copyWith(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageModel>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatHistoryResponse].
extension ChatHistoryResponsePatterns on ChatHistoryResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatHistoryResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatHistoryResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatHistoryResponse value)  $default,){
final _that = this;
switch (_that) {
case _ChatHistoryResponse():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatHistoryResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ChatHistoryResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatMessageModel> messages,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatHistoryResponse() when $default != null:
return $default(_that.messages,_that.hasMore);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatMessageModel> messages,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _ChatHistoryResponse():
return $default(_that.messages,_that.hasMore);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatMessageModel> messages,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _ChatHistoryResponse() when $default != null:
return $default(_that.messages,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatHistoryResponse implements ChatHistoryResponse {
  const _ChatHistoryResponse({required final  List<ChatMessageModel> messages, required this.hasMore}): _messages = messages;
  factory _ChatHistoryResponse.fromJson(Map<String, dynamic> json) => _$ChatHistoryResponseFromJson(json);

 final  List<ChatMessageModel> _messages;
@override List<ChatMessageModel> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override final  bool hasMore;

/// Create a copy of ChatHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatHistoryResponseCopyWith<_ChatHistoryResponse> get copyWith => __$ChatHistoryResponseCopyWithImpl<_ChatHistoryResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatHistoryResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatHistoryResponse&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),hasMore);

@override
String toString() {
  return 'ChatHistoryResponse(messages: $messages, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$ChatHistoryResponseCopyWith<$Res> implements $ChatHistoryResponseCopyWith<$Res> {
  factory _$ChatHistoryResponseCopyWith(_ChatHistoryResponse value, $Res Function(_ChatHistoryResponse) _then) = __$ChatHistoryResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ChatMessageModel> messages, bool hasMore
});




}
/// @nodoc
class __$ChatHistoryResponseCopyWithImpl<$Res>
    implements _$ChatHistoryResponseCopyWith<$Res> {
  __$ChatHistoryResponseCopyWithImpl(this._self, this._then);

  final _ChatHistoryResponse _self;
  final $Res Function(_ChatHistoryResponse) _then;

/// Create a copy of ChatHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? hasMore = null,}) {
  return _then(_ChatHistoryResponse(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageModel>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
