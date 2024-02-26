import 'package:flutter/material.dart';
import 'package:tentwenty_live_coding/core/models/base_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsViewModel extends BaseViewModel {
  late WebViewController controller;

  NewsDetailsViewModel({required String url}) {
    initController(articleUrl: url);
  }

  initController({required String articleUrl}) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          // onNavigationRequest: (NavigationRequest request) {
          //   if (request.url.startsWith('https://www.youtube.com/')) {
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
        ),
      )
      ..loadRequest(Uri.parse(articleUrl));
  }
}
