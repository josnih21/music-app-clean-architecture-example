import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_app_clean_architecture/core/network/network_info.dart';
import 'network_info_test.mocks.dart';

@GenerateMocks([Connectivity])
final mockDataConnectionChecker = MockConnectivity();
void main() {
  late NetworkInfoImpl networkInfoImpl;

  setUp(() {
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call to DataConnectionChecker.hasConnection', () async {
      //check if value is the same future has the resulting future when calling DataConnectionChecker
      final hasConnectionFuture = Future.value(ConnectivityResult.wifi);
      when(mockDataConnectionChecker.checkConnectivity()).thenAnswer((_) => hasConnectionFuture);

      final result = networkInfoImpl.isConnected;
      verify(mockDataConnectionChecker.checkConnectivity());
      expect(result, hasConnectionFuture);
    });
  });
}
