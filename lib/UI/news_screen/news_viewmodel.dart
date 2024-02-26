import 'package:flutter/material.dart';
import 'package:tentwenty_live_coding/core/constants/endpoints.dart';
import 'package:tentwenty_live_coding/core/models/base_viewmodel.dart';
import 'package:tentwenty_live_coding/core/models/news.dart';
import 'package:tentwenty_live_coding/core/services/api_service.dart';
import 'package:tentwenty_live_coding/locator.dart';

class NewsFeedViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  List<NewsArticle> newsArticles = [];
  bool isLoadingData = false;

  int page = 1;
  int? totalArticles;

  ScrollController articlesScrollController = ScrollController();

  NewsFeedViewModel() {
    getNewsArticles(1);
    initScrollController();
  }

  getNewsArticles(int page) async {
    isLoadingData = true;
    notifyListeners();

    final response = await _apiService.get(
      endPoint: topHeadlines,
      params: {"page": page},
    );

    if (response != null) {
      List<NewsArticle> articles = [];
      totalArticles = response.data['totalResults'];
      response.data['articles'].forEach(
        (article) {
          articles.add(NewsArticle.fromJson(article));
        },
      );
      newsArticles.addAll(articles);
    }
    print('lenght of articles: ${newsArticles.length}');
    isLoadingData = false;
    notifyListeners();
  }

  /// ON SCROLL TO THE END OF THE PAGE
  /// UPDATE THE PAGE NUMBER
  /// CALL THE FETCH ARTICLES API
  /// CONCATINATE THE RESULTS WITH THE PREVIOUS ONES
  /// AND NOTIFY THE LIST
  ///
  initScrollController() {
    print('@initScrollController');
    articlesScrollController.addListener(
      () {
        if (articlesScrollController.position.pixels ==
                articlesScrollController.position.maxScrollExtent &&
            totalArticles != null &&
            newsArticles.length < totalArticles!) {
          print('ADDING NEXT PAGES');
          page = page + 1;
          getNewsArticles(page);
        }
      },
    );
    notifyListeners();
  }
}
