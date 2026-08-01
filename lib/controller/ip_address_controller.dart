import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/domain/usecase/ip_address_usecase.dart';

class IpAddressController extends GetxController {
  final IpAddressUseCase ipAddressUseCase;

  IpAddressController({required this.ipAddressUseCase});

  Future<void> saveIpAddress() async {
    try {
      final dio = Dio();
      final response = await dio.get('http://ip-api.com/json/');
      
      if (response.statusCode == 200) {
        final data = response.data;
        
        final String ip = data['query'] ?? 'Unknown';
        final String city = data['city'] ?? 'Unknown';
        final String state = data['regionName'] ?? 'Unknown';
        final String country = data['country'] ?? 'Unknown';

        final result = await ipAddressUseCase(
          ipAddress: ip,
          city: city,
          state: state,
          country: country,
        );

        result.fold(
          (failure) => AppLogger.logError("Failed to save IP: ${failure.message}"),
          (success) => AppLogger.debugPrint("IP saved successfully: ${success.message}"),
        );
      }
    } catch (e) {
      AppLogger.logError("Error fetching IP details: $e");
    }
  }
}
