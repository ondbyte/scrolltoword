import 'package:flutter/material.dart';

///controll the scrolling, takes in start and end index of the word to scroll in the scroller
abstract class ScrollToWordController {
  ///scroll the [ScrollToWord] content to the word with [wordStartIndex] and [wordEndIndex]
  void scrollToWord(int wordStartIndex, int wordEndIndex);
}

class ScrollToWord extends StatefulWidget {
  ///a long text to scroll
  final String scrollableData;

  ///[highlightedWordStyle] will be used for word we scroll to, [nonHighlightedWordStyle] is for the leftover text
  final TextStyle? highlightedWordStyle, nonHighlightedWordStyle;

  ///this function which will provide the controller to control his widget
  final void Function(ScrollToWordController) onScrollerCreated;

  ///scroll animation duation
  final Duration durationOfScroll;

  ///scroll animation [Curve]
  final Curve animationCurveOfScroll;

  ///A scrollable widget for long text which enables you to scroll the view to the exact word in the text,
  ///Use the controller provided by [onScrollerCreated] to controll the scrolling/focussing.
  ScrollToWord({
    Key? key,
    required this.scrollableData,
    this.highlightedWordStyle,
    this.nonHighlightedWordStyle,
    required this.onScrollerCreated,
    this.durationOfScroll = const Duration(milliseconds: 1000),
    this.animationCurveOfScroll = Curves.ease,
  }) : super(key: key);

  @override
  _ScrollToWordState createState() => _ScrollToWordState();
}

class _ScrollToWordState extends State<ScrollToWord>
    implements ScrollToWordController {
  late final ScrollController _controller;
  int? _end;
  int? _start;

  @override
  void initState() {
    _controller = ScrollController();
    widget.onScrollerCreated(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HighlightedWordInPara(
      text: widget.scrollableData,
      highlightStartIndex: _start,
      highlightEndIndex: _end,
      highlightedWordStyle:
          widget.highlightedWordStyle ?? Theme.of(context).textTheme.subtitle1!,
      nonHighlightedWordStyle: widget.nonHighlightedWordStyle ??
          Theme.of(context).textTheme.bodyText1!,
      wordPosition: (hp) {
        if (_controller.hasClients) {
          _controller.animateTo(
            hp,
            duration: widget.durationOfScroll,
            curve: widget.animationCurveOfScroll,
          );
        }
      },
      scrollController: _controller,
    );
  }

  @override
  void scrollToWord(int wordStartIndex, int wordEndIndex) {
    _start = wordStartIndex;
    _end = wordEndIndex;
    setState(() {});
  }
}

class HighlightedWordInPara extends StatefulWidget {
  final String text;
  final int? highlightStartIndex, highlightEndIndex;
  final TextStyle highlightedWordStyle, nonHighlightedWordStyle;
  final Function(double) wordPosition;
  final ScrollController scrollController;
  HighlightedWordInPara({
    Key? key,
    required this.text,
    required this.highlightStartIndex,
    required this.highlightEndIndex,
    required this.highlightedWordStyle,
    required this.nonHighlightedWordStyle,
    required this.wordPosition,
    required this.scrollController,
  }) : super(key: key);

  @override
  _HighlightedWordInParaState createState() => _HighlightedWordInParaState();
}

class _HighlightedWordInParaState extends State<HighlightedWordInPara> {
  late String? _first, _second, _third;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, cons) {
        _first = widget.text.substring(0, widget.highlightStartIndex);
        _second = widget.highlightStartIndex != null
            ? widget.text.substring(
                widget.highlightStartIndex!, widget.highlightEndIndex)
            : null;
        _third = widget.highlightEndIndex != null
            ? widget.text.substring(widget.highlightEndIndex!)
            : null;

        final span2 = TextSpan(
          text: _first,
          style: widget.nonHighlightedWordStyle,
          children: [
            TextSpan(
              text: _second,
              style: widget.highlightedWordStyle,
            ),
          ],
        );
        final painter2 = TextPainter(
          text: span2,
          textDirection: TextDirection.ltr,
        );
        painter2.layout(maxWidth: cons.biggest.width);
        Future.doWhile(
          () async {
            await Future.delayed(const Duration(milliseconds: 100));
            if (mounted) {
              widget.wordPosition(
                painter2.size.height - (cons.biggest.height / 2),
              );
              return false;
            }
            return true;
          },
        );

        final span = TextSpan(
          text: _first,
          style: widget.nonHighlightedWordStyle,
          children: [
            TextSpan(
              text: _second,
              style: widget.highlightedWordStyle,
            ),
            TextSpan(
              text: _third,
              style: widget.nonHighlightedWordStyle,
            ),
          ],
        );
        final painter = TextPainter(
          text: span,
          textDirection: TextDirection.ltr,
        );
        painter.layout(maxWidth: cons.biggest.width);
        final size = painter.size;
        if (size.height <= cons.biggest.height) {
          return SizedBox.fromSize(
            size: size,
            child: RichText(text: span),
          );
        }
        return SizedBox.fromSize(
          size: size,
          child: SingleChildScrollView(
            controller: widget.scrollController,
            child: RichText(text: span),
          ),
        );
      },
    );
  }
}
