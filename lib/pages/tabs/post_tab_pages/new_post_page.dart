import 'package:yipl/services/bloc/posts/posts_bloc.dart';
import 'package:yipl/utils/styles.dart';
import 'package:yipl/widgets/features/longtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../others/post_detail_page.dart';

class NewPostsPage extends StatefulWidget {
  const NewPostsPage({super.key});

  @override
  State<NewPostsPage> createState() => _NewPostsPageState();
}

class _NewPostsPageState extends State<NewPostsPage> {
  final PostsBloc postsBloc = PostsBloc();
  bool isExpanded = false;
  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              postsBloc.add(PostAddEvent());
            }),
        body: BlocConsumer<PostsBloc, PostsState>(
          bloc: postsBloc,
          listenWhen: (previous, current) => current is PostsActionState,
          buildWhen: (previous, current) => current is! PostsActionState,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case PostsFetchingLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case PostFetchingSuccessfulState:
                final successState = state as PostFetchingSuccessfulState;

                return ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailPage(
                                successState.posts[index].id,
                                successState.posts[index].body,
                                successState.posts[index].title),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                contentTitle(successState.posts[index].title),
                                LongText(
                                    longText: successState.posts[index].body),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.favorite_outline_rounded,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.comment_outlined),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.bookmark_add_outlined),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              default:
                return const SizedBox();
            }
          },
        ));
  }
}
