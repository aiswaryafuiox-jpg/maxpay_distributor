import 'package:get/get.dart';
import 'package:maxpay/data/model/statement/statement_detail_model.dart';
import 'package:maxpay/domain/usecase/statement/get_statement_detail_usecase.dart';

class StatementReadMoreController extends GetxController {
  final GetStatementDetailUseCase getStatementDetailUseCase;

  StatementReadMoreController(this.getStatementDetailUseCase);

  RxBool isLoading = false.obs;
  Rx<StatementDetailData?> statementDetail = Rx<StatementDetailData?>(null);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic> && args['id'] != null) {
      fetchStatementDetail(args['id']);
    }
  }

  Future<void> fetchStatementDetail(String id) async {
    isLoading.value = true;
    final result = await getStatementDetailUseCase.call(id);
    isLoading.value = false;

    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (success) {
        statementDetail.value = success.data;
      },
    );
  }
}
