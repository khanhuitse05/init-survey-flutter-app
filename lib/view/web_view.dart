import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewRouter extends StatefulWidget {
  const WebViewRouter(this.url, {super.key});

  final String url;

  @override
  State<WebViewRouter> createState() => _WebViewRouterState();
}

class _WebViewRouterState extends State<WebViewRouter> {
  late final WebViewController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
  }

  void _initializeController(BuildContext context) {
    if (_initialized) {
      return;
    }
    _initialized = true;
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'ABCD',
        onMessageReceived: (JavaScriptMessage message) {
          if (!mounted) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    _initializeController(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.url),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/web-view',
                  arguments: widget.url);
            },
          ),
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
