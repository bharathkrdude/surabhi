import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surabhi/model/cheklist/checklist_screen.dart';
import 'package:surabhi/view/widgets/qr_code_widget.dart';

class QRScannerController extends GetxController with GetSingleTickerProviderStateMixin {
  late MobileScannerController cameraController;
  late AnimationController animation;
  RxBool torchOn = false.obs;
  RxString scannedValue = ''.obs;
  bool isProcessing = false;

  @override
  void onInit() {
    super.onInit();
    cameraController = MobileScannerController(
      facing: CameraFacing.back,
      torchEnabled: false,
    );
    
    animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  void toggleTorch() {
    cameraController.toggleTorch();
    torchOn.value = !torchOn.value;
  }

  void switchCamera() {
    cameraController.switchCamera();
  }

  void resetScan() {
    scannedValue.value = '';
  }

  void handleScanResult(String result) {
    if (isProcessing) return;

    isProcessing = true;
    print('Scanned QR Value: $result');
    
    try {
      final toiletId = int.tryParse(result);
      print('Parsed Toilet ID: $toiletId');
      
      // For testing purposes, consider any number as valid
      if (toiletId != null) {
        print('Valid toilet ID found, navigating to ChecklistScreen');
        Get.off(() => ChecklistScreen(toiletId: toiletId));
      } else {
        print('Could not parse QR code as number');
        Fluttertoast.showToast(
          msg: 'Invalid QR Code: Not a valid number',
          toastLength: Toast.LENGTH_LONG,
        );
        Get.to(() => const InvalidQRPage());
      }
    } catch (e) {
      print('Error processing QR code: $e');
      Fluttertoast.showToast(
        msg: 'Error processing QR code',
        toastLength: Toast.LENGTH_LONG,
      );
      Get.to(() => const InvalidQRPage());
    } finally {
      isProcessing = false;
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    animation.dispose();
    super.onClose();
  }
}
