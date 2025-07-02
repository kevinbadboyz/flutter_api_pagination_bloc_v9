part of 'get_post_bloc.dart';

@immutable
sealed class GetPostState {}

final class GetPostInitial extends GetPostState {}

final class GetPostLoading extends GetPostState {}

final class GetPostLoaded extends GetPostState {
  final List<PostModel> listPostModel;
  final bool hasReachedMax;

  GetPostLoaded({
    this.listPostModel = const <PostModel>[],
    this.hasReachedMax = false,
  });

  GetPostLoaded copyWith({List<PostModel>? list, bool? hasReachedMax}) {
    return GetPostLoaded(
      listPostModel: list ?? this.listPostModel,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

final class GetPostError extends GetPostState {
  final String message;

  GetPostError({required this.message});
}
