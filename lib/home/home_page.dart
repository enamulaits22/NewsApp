import 'package:flutter/material.dart';
import 'package:news_app/home/bloc/news_bloc.dart';
import 'package:news_app/home/data/repository/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home/view/details_page.dart';
import 'package:news_app/home/view/homepage_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  late final RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: false);
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onLoading(BuildContext context) {
    BlocProvider.of<NewsBloc>(context).add(LoadMoreNewsEvent());
  }

  void _onRefresh(BuildContext context) {
    BlocProvider.of<NewsBloc>(context).add(RefreshNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: BlocProvider(
          create: (context) => NewsBloc(
            RepositoryProvider.of<NewsRepository>(context),
          )..add(LoadNewsEvent()),
          child: BlocConsumer<NewsBloc, NewsState>(
            listener: (context, state) {
              if (state is NewsRefreshCompleteState) {
                _refreshController
                  ..loadComplete()
                  ..refreshCompleted();
              }
              if (state is NewsLoadMoreCompleteState) {
                _refreshController
                  ..loadComplete()
                  ..refreshCompleted();
              }
            },
            builder: (context, state) {
              if (state is NewsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is NewsLoadedState) {
                return SmartRefresher(
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
                                publishedAt: newsInfo.publishedAt.toString(),
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
                );
              }
              if (state is NewsErrorState) {
                return Center(
                  child: Text(state.error.toString()),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
