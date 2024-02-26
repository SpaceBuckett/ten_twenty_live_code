import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_live_coding/UI/news_details/news_details_veiwmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsArticleDetails extends StatelessWidget {
  const NewsArticleDetails({required this.newsArticleUrl, super.key});

  final String newsArticleUrl;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsDetailsViewModel(url: newsArticleUrl),
      child: Consumer<NewsDetailsViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Article Details'),
          ),
          body: WebViewWidget(
            controller: model.controller,
          ),
        ),
      ),
    );
  }
}
