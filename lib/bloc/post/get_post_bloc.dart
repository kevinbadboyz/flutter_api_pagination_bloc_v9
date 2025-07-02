import 'package:bloc/bloc.dart';
import 'package:flutter_apli_bloc_pagination_v9/models/post_model.dart';
import 'package:flutter_apli_bloc_pagination_v9/repo/post_repository.dart';
import 'package:meta/meta.dart';

part 'get_post_event.dart';

part 'get_post_state.dart';

class GetPostBloc extends Bloc<GetPostEvent, GetPostState> {
  final postRepository = PostRepository();

  GetPostBloc() : super(GetPostInitial()) {
    on<PostFetched>((event, emit) async {
      // emit(GetPostLoading());
      try {
        List<PostModel> list;
        if (state is GetPostInitial) {
          list = await postRepository.getPosts(0, 10);
          emit(GetPostLoaded(listPostModel: list));
        } else {
          GetPostLoaded getPostLoaded = state as GetPostLoaded;
          list = await postRepository.getPosts(
            getPostLoaded.listPostModel.length,
            10,
          );
          emit(
            list.isEmpty
                ? getPostLoaded.copyWith(hasReachedMax: true)
                : getPostLoaded.copyWith(
                    list: getPostLoaded.listPostModel + list,
                    hasReachedMax: false,
                  ),
          );
        }
      } catch (e) {
        emit(GetPostError(message: e.toString()));
      }
    });
  }
}
