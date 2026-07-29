import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/grade_model.dart';
import 'package:maxpay/domain/usecase/grade/get_grade_usecase.dart';

class GradeController extends GetxController {
  final GetGradeUseCase getGradeUseCase;

  GradeController(this.getGradeUseCase);

  var isLoading = false.obs;
  var gradeData = Rxn<GradeData>();
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGrade();
  }

  Future<void> fetchGrade() async {
    isLoading.value = true;
    errorMessage.value = '';
    
    final result = await getGradeUseCase.call();

    result.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = failure.message;
        AppLogger.logError("Failed to fetch grade: ${failure.message}");
        Get.snackbar("Error", failure.message);
      },
      (data) {
        isLoading.value = false;
        if (data.data != null) {
          gradeData.value = data.data;
        }
      },
    );
  }
}
