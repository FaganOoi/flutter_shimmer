import 'package:flutter/material.dart';

class ShimmerText extends StatefulWidget {
  final bool isShimmerLoading;
  final Text? text;
  final TextSpan? textSpan;

  /// isSpan true = TextSpan; Otherwise  =  Text
  final bool isSpan;
  final double shimmerLoadingWidth;
  final double shimmerLoadingHeight;

  const ShimmerText({
    Key? key,
    required this.isShimmerLoading,
    required this.isSpan,
    this.text,
    this.textSpan,
    this.shimmerLoadingWidth = 0,
    this.shimmerLoadingHeight = 0,
  })  : assert(
          (isSpan && textSpan != null) || (!isSpan && text != null),
          'Please check data',
        ),
        super(key: key);

  @override
  State<ShimmerText> createState() => _ShimmerTextState();
}

class _ShimmerTextState extends State<ShimmerText> {
  double widthUsed = 0;
  double heightUsed = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget widgetUsed = _getWidget();
    if (widget.isShimmerLoading) {
      _getSizeBasedOnWidget();
      return Container(
        color: Colors.white,
        width: widthUsed,
        height: heightUsed,
      );
    }

    return widgetUsed;
  }

  Widget _getWidget() {
    return widget.isSpan
        ? RichText(
            text: widget.textSpan!,
          )
        : widget.text!;
  }

  void _getSizeBasedOnWidget() {
    if (widget.shimmerLoadingWidth == 0 || widget.shimmerLoadingWidth == 0) {
      if (!widget.isSpan) {
        final Size textSize = _textSize(
          widget.text!.data ?? '',
          widget.text!.style ??
              const TextStyle(
                fontSize: 12,
              ),
        );
        widthUsed = textSize.width;
        heightUsed = textSize.height;
      } else {
        widthUsed = double.infinity;
        heightUsed = 50;
      }
    } else {
      widthUsed = widget.shimmerLoadingWidth;
      heightUsed = widget.shimmerLoadingHeight;
    }
  }

  // https://stackoverflow.com/questions/52659759/how-can-i-get-the-size-of-the-text-widget-in-flutter
  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
