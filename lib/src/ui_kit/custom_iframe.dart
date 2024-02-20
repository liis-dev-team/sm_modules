import 'package:flutter/material.dart';

class CustomIFrame extends StatefulWidget {
  final Future<Uri?> Function() onGenerateUri;

  const CustomIFrame({
    super.key,
    required this.onGenerateUri,
  });

  @override
  State<CustomIFrame> createState() => _CustomIFrameState();
}

class _CustomIFrameState extends State<CustomIFrame> {
  Uri? url;
  final GlobalKey webViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.onGenerateUri();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
