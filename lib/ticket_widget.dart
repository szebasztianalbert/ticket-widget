import 'package:flutter/material.dart';

class TicketWidget extends StatelessWidget {
  final double width;
  final Widget? upperWidget;
  final Widget? bottomWidget;
  final num ratio;
  final Color? separatorColor;
  final Color? headerBackgroundColor;
  final Color? bodyBackgroundColor;

  const TicketWidget({
    Key? key,
    required this.width,
    this.ratio = 1 / 3,
    this.upperWidget,
    this.bottomWidget,
    this.separatorColor = Colors.red,
    this.headerBackgroundColor = Colors.deepPurpleAccent,
    this.bodyBackgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = width * 1.5;
    final radius = width / 10;
    final cutRadius = width / 20;
    const double separatorLineHeight = 2;
    final headerHeight = height * ratio;
    final bottomHeight = height - headerHeight;
    final separatorLineWidth = width - cutRadius * 2;
    final separatorLinePosition = height * ratio - separatorLineHeight / 2;

    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: width,
              alignment: Alignment.center,
              child: CustomPaint(
                painter: _TicketUpperShadow(radius: radius, cutRadius: cutRadius),
                child: ClipPath(
                  clipper: _TicketUpperClipper(radius: radius, cutRadius: cutRadius),
                  child: Container(
                    color: headerBackgroundColor,
                    alignment: Alignment.center,
                    height: headerHeight,
                    width: double.infinity,
                    child:
                        Container(alignment: Alignment.center, width: width, height: headerHeight, child: upperWidget),
                  ),
                ),
              ),
            ),
            Container(
              width: width,
              alignment: Alignment.center,
              child: CustomPaint(
                painter: _TicketBottomShadow(radius: radius, cutRadius: cutRadius),
                child: ClipPath(
                  clipper: _TicketBottomClipper(radius: radius, cutRadius: cutRadius),
                  child: Container(
                    color: bodyBackgroundColor,
                    alignment: Alignment.center,
                    height: bottomHeight,
                    child: Container(
                        alignment: Alignment.center, width: width * 0.75, height: width * 0.75, child: bottomWidget),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: separatorLinePosition,
          left: cutRadius,
          child: Container(height: separatorLineHeight, width: separatorLineWidth, color: separatorColor),
        )
      ],
    );
  }
}

class _TicketUpperClipper extends CustomClipper<Path> {
  final double radius;
  final double cutRadius;

  _TicketUpperClipper({required this.radius, required this.cutRadius});

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(radius, 0)
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(Offset(size.width, radius), radius: Radius.circular(radius))
      ..lineTo(size.width, size.height - cutRadius)
      ..arcToPoint(Offset(size.width - cutRadius, size.height), radius: Radius.circular(cutRadius), clockwise: false)
      ..lineTo(cutRadius, size.height)
      ..arcToPoint(Offset(0, size.height - cutRadius), radius: Radius.circular(cutRadius), clockwise: false)
      ..lineTo(0, radius)
      ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _TicketBottomClipper extends CustomClipper<Path> {
  final double radius;
  final double cutRadius;

  _TicketBottomClipper({required this.radius, required this.cutRadius});

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(cutRadius, 0)
      ..lineTo(size.width - cutRadius, 0)
      ..arcToPoint(Offset(size.width, cutRadius), radius: Radius.circular(cutRadius), clockwise: false)
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(Offset(size.width - radius, size.height), radius: Radius.circular(radius))
      ..lineTo(radius, size.height)
      ..arcToPoint(Offset(0, size.height - radius), radius: Radius.circular(radius))
      ..lineTo(0, cutRadius)
      ..arcToPoint(Offset(cutRadius, 0), radius: Radius.circular(cutRadius), clockwise: false)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _TicketUpperShadow extends CustomPainter {
  final double radius;
  final double cutRadius;

  _TicketUpperShadow({required this.radius, required this.cutRadius});

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..moveTo(radius, 0)
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(Offset(size.width, radius), radius: Radius.circular(radius))
      ..lineTo(size.width, size.height - cutRadius)
      ..arcToPoint(Offset(size.width - cutRadius, size.height), radius: Radius.circular(cutRadius), clockwise: false)
      ..lineTo(cutRadius, size.height)
      ..arcToPoint(Offset(0, size.height - cutRadius), radius: Radius.circular(cutRadius), clockwise: false)
      ..lineTo(0, radius)
      ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
      ..close();

    canvas.drawShadow(path, Colors.black54, 10.0, true);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TicketBottomShadow extends CustomPainter {
  final double radius;
  final double cutRadius;

  _TicketBottomShadow({required this.radius, required this.cutRadius});

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..moveTo(cutRadius, 0)
      ..lineTo(size.width - cutRadius, 0)
      ..arcToPoint(Offset(size.width, cutRadius), radius: Radius.circular(cutRadius), clockwise: false)
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(Offset(size.width - radius, size.height), radius: Radius.circular(radius))
      ..lineTo(radius, size.height)
      ..arcToPoint(Offset(0, size.height - radius), radius: Radius.circular(radius))
      ..lineTo(0, cutRadius)
      ..arcToPoint(Offset(cutRadius, 0), radius: Radius.circular(cutRadius), clockwise: false)
      ..close();

    canvas.drawShadow(path, Colors.black54, 10.0, true);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
