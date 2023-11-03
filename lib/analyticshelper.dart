import 'package:firebase_analytics/firebase_analytics.dart';

class MyAnalyticsHelper {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> testEventLog(_value) async {
    await analytics
        .logEvent(name: '${_value}_click', parameters: {'Value': _value});
    print('Send Event');
  }

  Future<void> testSetUserId(_value) async {
    await analytics.setUserId(id: '$_value');
    print('setUserId succeeded');
  }

  Future<void> testSetUserProperty() async {
    await analytics.setUserProperty(name: 'regular', value: 'indeed');
    print('setUserProperty succeeded');
  }

  Future<void> testSessionTimeoutDuration() async {
    await analytics.setSessionTimeoutDuration(Duration(seconds: 10));
    print('setSessionTimeoutDuration succeeded');
  }

  Future<void> testAppInstanceId() async {
    await analytics.appInstanceId;
    print('appInstanceId succeeded');
  }

  Future<void> testResetAnalyticsData() async {
    await analytics.resetAnalyticsData();
    print('resetAnalyticsData succeeded');
  }

  Future<void> testLogAddPaymentInfo() async {
    await analytics.logAddPaymentInfo();
    print('logAddPaymentInfo succeeded');
  }

  Future<void> testLogAddToCart() async {
    await analytics.logAddToCart();
    print('logAddToCart succeeded');
  }

  Future<void> testLogPurchase() async {
    await analytics.logPurchase();
    print('logPurchase succeeded');
  }
}
