import 'package:maxpay/core/utils/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:maxpay/data/model/pending_wallet_request_model.dart';
import 'package:maxpay/data/model/pending_wallet_request_detail_model.dart';
import 'package:maxpay/data/model/approve_wallet_request_model.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/domain/usecase/retailer/get_pending_wallet_requests_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/get_pending_wallet_request_detail_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/approve_pending_wallet_request_usecase.dart';

class PendingWalletRequestController extends GetxController {
  final GetPendingWalletRequestsUseCase getPendingWalletRequestsUseCase;
  final GetPendingWalletRequestDetailUseCase getPendingWalletRequestDetailUseCase;
  final ApprovePendingWalletRequestUseCase approvePendingWalletRequestUseCase;

  PendingWalletRequestController(
    this.getPendingWalletRequestsUseCase,
    this.getPendingWalletRequestDetailUseCase,
    this.approvePendingWalletRequestUseCase,
  );

  RxBool isLoading = false.obs;
  RxList<PendingWalletRequestItem> pendingRequests = <PendingWalletRequestItem>[].obs;
  RxInt totalPendingRequests = 0.obs;
  
  RxBool isDetailLoading = false.obs;
  Rx<PendingWalletRequestDetailData?> selectedRequestDetail = Rx<PendingWalletRequestDetailData?>(null);

  RxBool isApproveLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPendingWalletRequests();
  }

  Future<void> fetchPendingWalletRequests() async {
    isLoading.value = true;
    final result = await getPendingWalletRequestsUseCase();
    
    result.fold(
      (Failure failure) {
        CustomSnackbar.error(failure.message);
      },
      (PendingWalletRequestModel response) {
        if (response.data?.list != null) {
          pendingRequests.assignAll(response.data!.list!);
        }
        totalPendingRequests.value = response.data?.total ?? 0;
      }
    );
    isLoading.value = false;
  }

  Future<void> fetchPendingWalletRequestDetail(int id) async {
    isDetailLoading.value = true;
    final result = await getPendingWalletRequestDetailUseCase(id);
    
    result.fold(
      (Failure failure) {
        CustomSnackbar.error(failure.message);
      },
      (PendingWalletRequestDetailModel response) {
        selectedRequestDetail.value = response.data;
      }
    );
    isDetailLoading.value = false;
  }

  Future<void> approveWalletRequest(int id, String confirmAmount) async {
    isApproveLoading.value = true;
    final result = await approvePendingWalletRequestUseCase(id, confirmAmount);
    
    result.fold(
      (Failure failure) {
        CustomSnackbar.error(failure.message);
      },
      (ApproveWalletRequestModel response) {
        CustomSnackbar.success(response.message ?? "Approved successfully");
        fetchPendingWalletRequests(); // Refresh the list
      }
    );
    isApproveLoading.value = false;
  }
}
