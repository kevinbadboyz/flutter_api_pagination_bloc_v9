import 'package:flutter/material.dart';
import 'package:flutter_apli_bloc_pagination_v9/bloc/post/get_post_bloc.dart';
import 'package:flutter_apli_bloc_pagination_v9/models/post_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostIndexPage extends StatelessWidget {
  const PostIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      GetPostBloc()
        ..add(PostFetched()),
      child: PostList(),
    );
  }
}

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final scrollController = ScrollController();
  late GetPostBloc getPostBloc;

  // @override
  // void initState() {
  //   context.read<GetPostBloc>().add(PostFetched());
  //   scrollController.addListener(onScroll);
  //   super.initState();
  // }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    if (maxScroll == currentScroll) {
      getPostBloc.add(PostFetched());
    }
  }

  @override
  Widget build(BuildContext context) {
    getPostBloc = BlocProvider.of<GetPostBloc>(context);
    scrollController.addListener(onScroll);
    return Scaffold(
      appBar: AppBar(
        title: Text('Post List'),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
      ),
      body: BlocBuilder<GetPostBloc, GetPostState>(
        builder: (context, state) {
          return switch (state) {
          // TODO: Handle this case.
            GetPostInitial() ||
            GetPostLoading() => Center(child: CircularProgressIndicator()),
          // TODO: Handle this case.
            GetPostLoaded(listPostModel: var data) when data.isNotEmpty =>
                ListView.separated(
                  controller: scrollController,
                  itemBuilder: (_, index) {
                    if (index < state.listPostModel.length) {
                      PostModel postModel = state.listPostModel[index];
                      return ListTile(
                        leading: CircleAvatar(
                            child: Text(postModel.id.toString())),
                        title: Text(postModel.title.toString()),
                        subtitle: Text(postModel.body.toString()),
                      );
                    } else {
                      return Center(child: state.hasReachedMax
                          ? Text('You are in the end of page...')
                          : CircularProgressIndicator());
                    }
                  },
                  separatorBuilder: (_, index) {
                    return Divider(thickness: 1);
                  },
                  itemCount: state.hasReachedMax
                      ? state.listPostModel.length
                      : state.listPostModel.length + 1,
                ),
          // TODO: Handle this case.
            GetPostError() => Center(child: Text(state.message)),
          // TODO: Handle this case.
            GetPostLoaded() => Center(child: Text('Data is empty...')),
          };
        },
      ),
    );
  }
}
