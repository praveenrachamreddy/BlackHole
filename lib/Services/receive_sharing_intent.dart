import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class ReceiveSharingIntentService {
  // Method to initialize sharing intent listeners
  void initReceiveSharingIntent({
    required Function(String) handleSharedText,
    required Function(List<SharedMediaFile>) handleSharedFiles,
  }) {
    // For sharing or opening URLs/text coming from outside the app while the app is in memory
    ReceiveSharingIntent.getTextStream().listen((String? value) {
      if (value != null) handleSharedText(value);
    }, onError: (err) {
      print("Error receiving share: $err");
    });

    // For sharing or opening URLs/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String? value) {
      if (value != null) handleSharedText(value);
    });

    // For sharing files coming from outside the app while the app is in memory
    ReceiveSharingIntent.getMediaStream().listen((List<SharedMediaFile>? value) {
      if (value != null) handleSharedFiles(value);
    }, onError: (err) {
      print("Error receiving media share: $err");
    });

    // For sharing files coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile>? value) {
      if (value != null) handleSharedFiles(value);
    });
  }
}
