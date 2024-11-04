import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:get/get.dart';
import 'package:surabhi/model/cheklist/complaint_model.dart';
import 'package:surabhi/constants/colors.dart';

class QRCodeScannerPage extends StatefulWidget {
  const QRCodeScannerPage({super.key});

  @override
  State<QRCodeScannerPage> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> with SingleTickerProviderStateMixin {
  MobileScannerController cameraController = MobileScannerController();
  bool _torchOn = false;
  String? _scannedValue;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: -5, end: 5).animate(_animationController);
  }

  @override
  void dispose() {
    cameraController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: MobileScanner(
              controller: cameraController,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  if (barcode.rawValue != null) {
                    setState(() => _scannedValue = barcode.rawValue);
                    _handleScanResult(barcode.rawValue!);
                  }
                }
              },
            ),
          ),
          _buildOverlay(),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const SizedBox(),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(_torchOn ? Icons.flash_on : Icons.flash_off, color: Colors.white),
                      onPressed: () {
                        cameraController.toggleTorch();
                        setState(() => _torchOn = !_torchOn);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.switch_camera, color: Colors.white),
                      onPressed: () => cameraController.switchCamera(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _scannedValue ?? 'Scan a QR code',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _scannedValue != null ? Colors.blue : Colors.black54,
                    ),
                  ),
                  if (_scannedValue != null) ...[
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: const Text('Scan Again'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () => setState(() => _scannedValue = null),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        final scanAreaSize = size.width * 0.7;
        return Stack(
          children: [
            CustomPaint(
              size: size,
              painter: ScannerOverlay(scanAreaSize),
            ),
            Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _animation.value * 5),
                    child: Container(
                      width: scanAreaSize,
                      height: 2,
                      color: Colors.blue.withOpacity(0.6),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: Container(
                width: scanAreaSize,
                height: scanAreaSize,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleScanResult(String result) {
    final toiletId = int.tryParse(result);
    if (toiletId != null) {
      // Navigate to ChecklistScreen with the scanned toiletId
      Get.to(() => ChecklistScreen(toiletId: toiletId, toiletCode: '',));
    } else {
      // Show error if the scanned code is not a valid ID
      Get.snackbar('Invalid QR Code', 'The scanned code is not a valid toilet ID');
    }
  }
}

class ScannerOverlay extends CustomPainter {
  final double scanAreaSize;

  ScannerOverlay(this.scanAreaSize);

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final cutoutRect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: scanAreaSize,
      height: scanAreaSize,
    );

    final backgroundPath = Path()
      ..addRect(Rect.largest)
      ..addRRect(RRect.fromRectAndRadius(cutoutRect, const Radius.circular(12)))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(backgroundPath, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
