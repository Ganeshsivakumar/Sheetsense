import 'package:mixpanel_flutter/mixpanel_flutter.dart';

Future trackEvent(String eventName) async {
  Mixpanel mixpanel;
  mixpanel = await Mixpanel.init("9b6bfc91d8de1e3e86baf41a970d6a03",
      trackAutomaticEvents: true);
  mixpanel.track(eventName);
}

Future trackChatEvent(String eventName, String isPremium) async {
  Mixpanel mixpanel;
  mixpanel = await Mixpanel.init("9b6bfc91d8de1e3e86baf41a970d6a03",
      trackAutomaticEvents: true);
  mixpanel.track(eventName, properties: {"isPremium": isPremium});
}
