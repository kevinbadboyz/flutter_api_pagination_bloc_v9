part of 'get_post_bloc.dart';

@immutable
sealed class GetPostEvent {}

final class PostFetched extends GetPostEvent{}