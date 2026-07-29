import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/login_history_model.dart';
import 'package:maxpay/domain/usecase/login_history/get_login_history_usecase.dart';

class LoginHistoryController extends GetxController {
  final GetLoginHistoryUseCase getLoginHistoryUseCase;

  LoginHistoryController(this.getLoginHistoryUseCase);

  var isLoading = false.obs;
  var loginHistoryData = Rxn<LoginHistoryData>();
  var errorMessage = ''.obs;
  
  var fromDate = ''.obs;
  var toDate = ''.obs;
  var searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLoginHistory();
  }

  Future<void> fetchLoginHistory() async {
    isLoading.value = true;
    errorMessage.value = '';
    
    final result = await getLoginHistoryUseCase.call(
      fromDate: fromDate.value,
      toDate: toDate.value,
      search: searchText.value,
    );

    result.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = failure.message;
        AppLogger.logError("Failed to fetch login history: ${failure.message}");
        Get.snackbar("Error", failure.message);
      },
      (data) {
        isLoading.value = false;
        if (data.data != null) {
          loginHistoryData.value = data.data;
        } else if (data.message != null) {
          errorMessage.value = data.message!;
        }
      },
    );
  }
}
