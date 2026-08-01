import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/graph_model.dart';
import 'package:maxpay/domain/usecase/home/get_graph_usecase.dart';

class GraphController extends GetxController {
  final GetGraphUseCase getGraphUseCase;

  GraphController(this.getGraphUseCase);

  RxBool isLoading = false.obs;
  Rx<GraphData?> graphData = Rx<GraphData?>(null);
  RxString selectedType = 'annual'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGraphData();
  }

  void changeType(String type) {
    if (selectedType.value != type) {
      selectedType.value = type;
      fetchGraphData();
    }
  }

  Future<void> fetchGraphData() async {
    isLoading.value = true;
    final result = await getGraphUseCase.call(selectedType.value);
    result.fold(
      (failure) {
        isLoading.value = false;
        AppLogger.logError("Failed to fetch graph data: ${failure.message}");
      },
      (data) {
        isLoading.value = false;
        if (data.data != null) {
          graphData.value = data.data;
        }
      },
    );
  }
}
