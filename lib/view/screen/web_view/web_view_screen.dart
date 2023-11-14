import 'package:ezyrack/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class WebViewScreen extends StatefulWidget {

  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {

  /*WebViewController webViewController = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setNavigationDelegate(NavigationDelegate(
    onProgress: (int progress){},
    onWebResourceError: (error){},
    onNavigationRequest: (request){
      if(request.url.startsWith("www.google.com")){
        return NavigationDecision.prevent;
      }

      return NavigationDecision.navigate;
    }
  ))
  ..loadRequest(Uri.parse("https://ezyrack.com/"));*/

  double _progress = 0;
  late InAppWebViewController  inAppWebViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: ()async{
        var isLastPage = await inAppWebViewController.canGoBack();
        if(isLastPage){
          inAppWebViewController.goBack();
          return false;
        }
        return true;
      },
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.colorBlack,
          appBar: AppBar(
            backgroundColor: AppColors.colorBlack,
            elevation: 0,
            title: Text(
              "EZYRack Web",
              style: GoogleFonts.publicSans(
                fontSize: 16,
                color: AppColors.colorWhite,
                fontWeight: FontWeight.w500
              ),
            ),
            titleSpacing: -8,
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back, color: AppColors.colorWhite, size: 18),
            ),
          ),
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse("https://ezyrack.com/")
                ),
                onWebViewCreated: (InAppWebViewController controller){
                  inAppWebViewController = controller;
                },
                onProgressChanged: (InAppWebViewController controller , int progress){
                  setState(() {
                    _progress = progress / 100;
                  });
                },
              ),
              _progress < 1 ? LinearProgressIndicator(
                value: _progress,
              ): const SizedBox()
            ],
          )
          /*WebViewWidget(
            controller: webViewController,
          )*/,
        ),
      ),
    );
  }
}