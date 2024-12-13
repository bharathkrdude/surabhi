import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:get/get.dart';
import 'package:surabhi/controller/qr_controller/qr_controller.dart';
import 'package:surabhi/constants/colors.dart';

class QRCodeScannerPage extends GetView<QRScannerController> {
  const QRCodeScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          buildScanner(),
          _buildOverlay(),
          _buildTopControls(),
          _buildBottomPanel(),
        ],
      ),
    );
  }

  Widget buildScanner() {
    return MobileScanner(
      controller: controller.cameraController,
      onDetect: (capture) {
        final List<Barcode> barcodes = capture.barcodes;
        for (final barcode in barcodes) {
          if (barcode.rawValue != null) {
            controller.scannedValue.value = barcode.rawValue!;
            controller.handleScanResult(barcode.rawValue!);
          }
        }
      },
      fit: BoxFit.cover,
    );
  }

  Widget _buildTopControls() {
    return Positioned(
      top: 40,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Row(
            children: [
              Obx(() => IconButton(
                    icon: Icon(
                        controller.torchOn.value
                            ? Icons.flash_on
                            : Icons.flash_off,
                        color: Colors.white),
                    onPressed: controller.toggleTorch,
                  )),
              IconButton(
                icon: const Icon(Icons.switch_camera, color: Colors.white),
                onPressed: controller.switchCamera,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  controller.scannedValue.value.isEmpty
                      ? 'Scan a QR code'
                      : controller.scannedValue.value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: controller.scannedValue.value.isEmpty
                        ? Colors.black54
                        : Colors.red,
                  ),
                ),
                if (controller.scannedValue.value.isNotEmpty) ...[
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
                    onPressed: controller.resetScan,
                  ),
                ],
              ],
            )),
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
                animation: controller.animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, controller.animation.value * 5),
                    child: Container(
                      width: scanAreaSize,
                      height: 2,
                      color: Colors.red.withOpacity(0.6),
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

class InvalidQRPage extends StatelessWidget {
  const InvalidQRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.qr_code_scanner,
                size: 50,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Invalid QR Code',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The scanned QR code is not valid.\nPlease try scanning again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryButton,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => navigator?.pop(context),
              child: const Text(
                'Try Again',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
