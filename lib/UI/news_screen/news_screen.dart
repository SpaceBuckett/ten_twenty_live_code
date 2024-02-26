import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_live_coding/UI/news_screen/news_viewmodel.dart';
import 'package:tentwenty_live_coding/core/models/news.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsFeedViewModel(),
      child: Consumer<NewsFeedViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text(
              'NEWS FEED',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: model.isLoadingData
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  controller: model.articlesScrollController,
                  itemCount: model.newsArticles.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return NewsArticleWidget(
                      newsArticle: model.newsArticles[index],
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class NewsArticleWidget extends StatelessWidget {
  const NewsArticleWidget({
    required this.newsArticle,
    super.key,
  });

  final NewsArticle newsArticle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 22.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsArticle.title ?? 'No title',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            newsArticle.urlToImage != null
                ? CachedNetworkImage(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    imageUrl: newsArticle.urlToImage!,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.withOpacity(0.2),
                    child: const Center(
                      child: Text('No Image Found'),
                    ),
                  ),
            Text(newsArticle.description ?? ''),
          ],
        ),
      ),
    );
  }
}
