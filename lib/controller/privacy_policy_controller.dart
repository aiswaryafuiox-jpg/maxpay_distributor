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
        if (urlStr != null && urlStr.trim().isNotEmpty) {
          try {
            var formattedUrl = urlStr.trim();
            if (!formattedUrl.startsWith('http://') &&
                !formattedUrl.startsWith('https://')) {
              formattedUrl = 'http://$formattedUrl';
            }
            final uri = Uri.parse(formattedUrl);
            await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
          } catch (e) {
            CustomToast.error("Could not open Privacy Policy link");
          }
        } else {
          CustomToast.error("Privacy Policy link not available");
        }
      },
    );
  }
}
