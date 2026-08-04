import 'package:get/get.dart';
import 'package:maxpay/core/utils/snackbar.dart';
import 'package:maxpay/data/model/privacy_policy_model.dart';
import 'package:maxpay/domain/usecase/get_privacy_policy_usecase.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyController extends GetxController {
  final GetPrivacyPolicyUseCase getPrivacyPolicyUseCase;

  PrivacyPolicyController(this.getPrivacyPolicyUseCase);

  RxBool isLoading = false.obs;
  Rxn<PrivacyPolicyData> privacyPolicyData = Rxn<PrivacyPolicyData>();

  Future<void> openPrivacyPolicy() async {
    isLoading.value = true;
    final result = await getPrivacyPolicyUseCase();
    isLoading.value = false;

    result.fold(
      (failure) {
        CustomToast.error(failure.message);
      },
      (data) async {
        privacyPolicyData.value = data.data;
        final urlStr = data.data?.privacyPolicy;
        if (urlStr != null && urlStr.isNotEmpty) {
          final uri = Uri.parse(urlStr);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            CustomToast.error("Could not open Privacy Policy link");
          }
        } else {
          CustomToast.error("Privacy Policy link not available");
        }
      },
    );
  }
}
