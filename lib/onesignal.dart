import 'package:onesignal_flutter/onesignal_flutter.dart';

var externalID;
var playerID;

/// Setting ExternalID on OneSignal
Future<void> setExternalId() async {
  externalID = 'ultisend-' + playerID.toString();
  print(OneSignal.shared.setExternalUserId(externalID));
}

/// Getting PlayerID from OneSignal
Future<void> getPlayerID() async {
  print('get player id');
  try {
    final status = await OneSignal.shared.getPermissionSubscriptionState();
    playerID = status.subscriptionStatus.userId.toString();
    print(status.subscriptionStatus.userId);
    await setExternalId();
  } catch (e) {
    print('error get player id, coba lagi');
  }
  // return status.subscriptionStatus.userId.toString();
  if (playerID == null) getPlayerID();
}

// Initializing OneSignal
// Registering devices for push notification, setting push notification listener etc
Future initOneSignal() {
  print('init onesignal');
  // ini punya one signal dicky 32e66a8a-ae1c-4aac-928c-1e5941735832
  // ini punya ultipay c5bdc74f-9832-4320-a338-d13cbde60597
  // ini punya one signal dicky akun kantor b3758b44-383f-44c4-8811-1fe513991fd0
  // ini punya ultisend mas ron 36c13185-ff90-4866-9285-f05e21348d47
  OneSignal.shared.init(
      'de3fd9e3-2711-49cd-9959-acda741fb050', // OneSignal AppID
      iOSSettings: {
        OSiOSSettings.autoPrompt: true,
        OSiOSSettings.inAppLaunchUrl: true
      });

  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult notification) {
    print('open woi $notification');
    print(notification.notification.payload.rawPayload);
    // final jsonString = notification.notification.payload.rawPayload['custom'];
    // final data = jsonDecode(jsonString)['a'];
  });

  final abc = getPlayerID();

  return abc;
}

/// Remove ExternalID when user logs out
void removeExternalIdOnLogout() {
  OneSignal.shared.removeExternalUserId();
}
