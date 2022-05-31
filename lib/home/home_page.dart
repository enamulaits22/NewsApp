import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/home/news_provider/news_notifier.dart';
import 'package:news_app/home/view/details_page.dart';
import 'package:news_app/home/view/homepage_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with AutomaticKeepAliveClientMixin {
  late final RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: false);
    ref.read(newsDataProvider.notifier).onLoadNews();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onLoading(BuildContext context) {
    // BlocProvider.of<NewsBloc>(context).add(LoadMoreNewsEvent());
    ref.read(newsDataProvider.notifier).onLoadMoreNews();
  }

  void _onRefresh(BuildContext context) {
    // BlocProvider.of<NewsBloc>(context).add(RefreshNewsEvent());
    ref.read(newsDataProvider.notifier).onRefreshNews();
  }

  @override
  Widget build(BuildContext context) {
    NewsState state = ref.watch(newsDataProvider);

    ref.listen(newsDataProvider, (previous, next) {
      if (next is NewsRefreshCompleteState) {
        _refreshController
          ..loadComplete()
          ..refreshCompleted();
      }
      if (next is NewsLoadMoreCompleteState) {
        _refreshController
          ..loadComplete()
          ..refreshCompleted();
      }
    });
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: state is NewsLoadingState
            ? const Center(child: CircularProgressIndicator())
            : state is NewsLoadedState
            ? SmartRefresher(
                controller: _refreshController,
                enablePullUp: state.enablePullUp,
                onRefresh: () => _onRefresh(context),
                onLoading: () => _onLoading(context),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.news.length,
                  itemBuilder: (context, index) {
                    var newsInfo = state.news[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                              author: newsInfo.author!,
                              title: newsInfo.title!,
                              description: newsInfo.description!,
                              url: newsInfo.url!,
                              urlToImage: newsInfo.urlToImage!,
                              publishedAt:
                                  newsInfo.publishedAt.toString(),
                              content: newsInfo.content!,
                            ),
                          ),
                        );
                      },
                      child: HomePageView(
                        title: state.news[index].title!,
                        imageUrl: state.news[index].urlToImage!,
                      ),
                    );
                  },
                ),
              )
            : state is NewsErrorState
            ? Center(child: Text(state.error.toString()))
            : Container(),
          ),
        );
  }

  @override
  bool get wantKeepAlive => true;
}



// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:news_app/home/news_provider/news_notifier.dart';
// import 'package:news_app/home/view/details_page.dart';
// import 'package:news_app/home/view/homepage_view.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// class HomePage extends ConsumerStatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
// }

// class _HomePageState extends ConsumerState<HomePage> with AutomaticKeepAliveClientMixin{
//   late final RefreshController _refreshController;

//   @override
//   void initState() {
//     _refreshController = RefreshController(initialRefresh: false);
//     ref.read(newsDataProvider.notifier).onLoadNews();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _refreshController.dispose();
//     super.dispose();
//   }

//   void _onLoading(BuildContext context) {
//     // BlocProvider.of<NewsBloc>(context).add(LoadMoreNewsEvent());
//     ref.read(newsDataProvider.notifier).onLoadMoreNews();
//   }

//   void _onRefresh(BuildContext context) {
//     // BlocProvider.of<NewsBloc>(context).add(RefreshNewsEvent());
//     ref.read(newsDataProvider.notifier).onRefreshNews();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
//         child: Consumer(
//             builder: (context, ref, child) {
//               NewsState state = ref.watch(newsDataProvider);
              
//               ref.listen(newsDataProvider, (previous, next) {
//                 if (next is NewsRefreshCompleteState) {
//                 _refreshController
//                   ..loadComplete()
//                   ..refreshCompleted();
//               }
//               if (next is NewsLoadMoreCompleteState) {
//                 _refreshController
//                   ..loadComplete()
//                   ..refreshCompleted();
//               }
//               });
//               if (state is NewsLoadingState) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               if (state is NewsLoadedState) {
//                 return SmartRefresher(
//                   controller: _refreshController,
//                   enablePullUp: state.enablePullUp,
//                   onRefresh: () => _onRefresh(context),
//                   onLoading: () => _onLoading(context),
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: state.news.length,
//                     itemBuilder: (context, index) {
//                       var newsInfo = state.news[index];
//                       return InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => DetailsPage(
//                                 author: newsInfo.author!,
//                                 title: newsInfo.title!,
//                                 description: newsInfo.description!,
//                                 url: newsInfo.url!,
//                                 urlToImage: newsInfo.urlToImage!,
//                                 publishedAt: newsInfo.publishedAt.toString(),
//                                 content: newsInfo.content!,
//                               ),
//                             ),
//                           );
//                         },
//                         child: HomePageView(
//                           title: state.news[index].title!,
//                           imageUrl: state.news[index].urlToImage!,
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               }
//               if (state is NewsErrorState) {
//                 return Center(
//                   child: Text(state.error.toString()),
//                 );
//               }
//               return Container();
//             },
//         ),
//       ),
//     );
//   }
  
//   @override
//   bool get wantKeepAlive => true;
// }
