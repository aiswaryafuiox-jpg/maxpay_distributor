import 'package:get/get.dart';
import 'package:maxpay/data/model/outstanding_list_model.dart';
import 'package:maxpay/domain/usecase/retailer/get_outstanding_list_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/update_outstanding_usecase.dart';

class OutstandingController extends GetxController {
  final GetOutstandingListUseCase getOutstandingListUseCase;
  final UpdateOutstandingUseCase updateOutstandingUseCase;

  OutstandingController(this.getOutstandingListUseCase, this.updateOutstandingUseCase);

  RxBool isLoading = false.obs;
  RxList<OutstandingItem> outstandingList = <OutstandingItem>[].obs;
  RxInt totalOutstanding = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOutstandingList();
  }

  Future<void> fetchOutstandingList() async {
    isLoading.value = true;
    final result = await getOutstandingListUseCase();
    
    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (response) {
        if (response.data?.list != null) {
          outstandingList.assignAll(response.data!.list!);
        }
        totalOutstanding.value = response.data?.total ?? 0;
      }
    );
    isLoading.value = false;
  }

  Future<void> updateOutstanding(int retailerId, String receivedAmount) async {
    final result = await updateOutstandingUseCase(retailerId, receivedAmount);
    
    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (response) {
        Get.snackbar("Success", response.message ?? "Outstanding updated successfully");
        fetchOutstandingList(); // Refresh list
      }
    );
  }
}
