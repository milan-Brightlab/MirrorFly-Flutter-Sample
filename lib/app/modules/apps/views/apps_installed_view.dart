import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:math';
import 'package:lottie/lottie.dart';

class CustomWebViewBottomSheet extends StatefulWidget {
  final String url;
  final String name;


  const CustomWebViewBottomSheet({Key? key, required this.url, required this.name}) : super(key: key);

  @override
  State<CustomWebViewBottomSheet> createState() => _CustomWebViewBottomSheetState();
}

class _CustomWebViewBottomSheetState extends State<CustomWebViewBottomSheet> {
  late final WebViewController webController;
  double _dragStartPosition = 0.0;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  void _handleDragStart(DragStartDetails details) {
    _dragStartPosition = details.globalPosition.dy;
    isDragging = true;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!isDragging) return;

    double dragDistance = details.globalPosition.dy - _dragStartPosition;
    if (dragDistance > MediaQuery.of(context).size.height * 0.2) {
      isDragging = false;
      Navigator.of(context).pop();
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    isDragging = false;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 5,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Main content including WebView
              Column(
                children: [
                  // SizedBox(height: 0), // Space for the handle
                  AppBar(
                    title: Text(
                      widget.name,
                      style: TextStyle(color: Colors.black87),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.black87),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  Expanded(
                    child: WebViewWidget(controller: webController),
                  ),
                ],
              ),
              // Drag Handle overlay
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragStart: _handleDragStart,
                  onVerticalDragUpdate: _handleDragUpdate,
                  onVerticalDragEnd: _handleDragEnd,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                    ),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class InstalledApp {
  final String name;
  final String title;
  final String iconPath;
  final String url;
  final Color color;
  final bool native;  // Added native property

  InstalledApp({
    required this.name,
    required this.title,
    required this.iconPath,
    required this.url,
    required this.color,
    required this.native,
  });
}

class InstalledAppsView extends StatefulWidget {  // Changed to StatefulWidget
  final List installedapps;
  final int coloumns;
  final Color? color;
  final Color? iconColor;
  final TextStyle noDataTextStyle;

  InstalledAppsView({
    Key? key,
    required this.installedapps,
    required this.noDataTextStyle,
    required this.coloumns,
    this.color,
    this.iconColor,
  }) : super(key: key);

  @override
  State<InstalledAppsView> createState() => _InstalledAppsViewState();
}
class _InstalledAppsViewState extends State<InstalledAppsView> with SingleTickerProviderStateMixin {
  int? loadingIndex;
  late AnimationController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
  }

  void _startLoading(int index) {
    if (widget.installedapps[index].native) {
      setState(() {
        loadingIndex = index;
      });
      _controller.reset();
      _controller.forward();

      _timer = Timer(Duration(seconds: 3), () {
        setState(() {
          loadingIndex = null;
        });
        // Add your native app launch logic here
      });
    }
  }

  void _cancelLoading() {
    _timer?.cancel();
    _controller.reset();
    setState(() {
      loadingIndex = null;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.coloumns,
          mainAxisSpacing: 20,
          crossAxisSpacing: 15,
          childAspectRatio: 1,
        ),
        itemCount: widget.installedapps.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {

              if (widget.installedapps[index].native == false) {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    barrierColor: Colors.black54,
                    pageBuilder: (context, _, __) =>
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(color: Colors.transparent),
                            ),
                            CustomWebViewBottomSheet(
                                url: widget.installedapps[index].url,
                                name: widget.installedapps[index].title),
                          ],
                        ),
                    transitionsBuilder: (context, animation,
                        secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                        )),
                        child: child,
                      );
                    },
                  ),
                );
              }
              else{

              }
            },
            onLongPressStart: (_) => _startLoading(index),
            onLongPressEnd: (_) => _cancelLoading(),
            child: Container(
              height: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Stack(
                      children: [
                        // Base container with original color
                        Container(
                          decoration: BoxDecoration(
                            color: widget.color ?? widget.installedapps[index].color,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // Loading animation
                        if (loadingIndex == index && widget.installedapps[index].native)
                          Lottie.network(
                            'https://lottie.host/c1554cbb-9cdf-4594-abfc-da66f3e7275d/hG8EjuUsZN.json',
                            height: 5000,
                            width: 5000,

                          ),
                        Center(
                          child: Icon(
                            widget.installedapps[index].iconPath ?? Icons.app_blocking_outlined ,
                            color: widget.iconColor ?? Colors.white,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        widget.installedapps[index].title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
class LoadingArcPainter extends CustomPainter {
  final double progress;
  final Color color;

  LoadingArcPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);

    final path = Path();
    path.moveTo(center.dx, center.dy);

    // Start at top center
    path.lineTo(center.dx, 0);

    // Calculate the total angle based on progress (starting from -90 degrees)
    double currentAngle = 2 * pi * progress - (pi / 2);

    // Determine which edges to fill
    if (currentAngle <= 0) { // Top edge
      path.lineTo(center.dx + center.dx * (currentAngle + pi/2) / (pi/2), 0);
    } else if (currentAngle <= pi/2) { // Right edge
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height * currentAngle / (pi/2));
    } else if (currentAngle <= pi) { // Bottom edge
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width - size.width * (currentAngle - pi/2) / (pi/2), size.height);
    } else if (currentAngle <= 3*pi/2) { // Left edge
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(0, size.height - size.height * (currentAngle - pi) / (pi/2));
    } else { // Back to top edge
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(center.dx + center.dx * (currentAngle - 3*pi/2) / (pi/2), 0);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LoadingArcPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}