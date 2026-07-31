
import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/home_card_model.dart';
import 'package:maxpay/data/model/today_transaction_model.dart';
import 'package:maxpay/domain/usecase/home/get_home_card_usecase.dart';
import 'package:maxpay/domain/usecase/home/get_today_transaction_amount_usecase.dart';
import 'package:maxpay/domain/usecase/home/get_news_usecase.dart';

class HomePageController extends GetxController {
  final GetHomeCardUseCase getHomeCardUseCase;
  final GetTodayTransactionAmountUseCase getTodayTransactionAmountUseCase;
  final GetNewsUseCase getNewsUseCase;

  HomePageController(this.getHomeCardUseCase, this.getTodayTransactionAmountUseCase, this.getNewsUseCase);

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  Rx<HomeCardData?> homeCardData = Rx<HomeCardData?>(null);
  Rx<TodayTransactionData?> todayTransactionData = Rx<TodayTransactionData?>(null);
  RxString newsText = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeCardData();
    fetchTodayTransactionAmount();
    fetchNews();
  }

  Future<void> fetchHomeCardData() async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await getHomeCardUseCase.call();

    result.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = failure.message;
        AppLogger.logError("Failed to fetch home card data: ${failure.message}");
      },
      (data) {
        isLoading.value = false;
        if (data.data != null) {
          homeCardData.value = data.data;
        } else if (data.message != null) {
          errorMessage.value = data.message!;
        }
      },
    );
  }

  Future<void> fetchTodayTransactionAmount() async {
    final result = await getTodayTransactionAmountUseCase.call();

    result.fold(
      (failure) {
        AppLogger.logError("Failed to fetch today transaction amount: ${failure.message}");
      },
      (data) {
        if (data.data != null) {
          todayTransactionData.value = data.data;
        }
      },
    );
  }

  Future<void> fetchNews() async {
    final result = await getNewsUseCase.call();
    result.fold(
      (failure) {
        AppLogger.logError("Failed to fetch news: ${failure.message}");
        newsText.value = "No news";
      },
      (data) {
        if (data.data != null && data.data!.isNotEmpty) {
          final List<String> messages = [];
          for (var item in data.data!) {
            if (item.message != null && item.message!.isNotEmpty) {
              messages.add(item.message!);
            }
          }
          if (messages.isNotEmpty) {
            newsText.value = messages.join(" • ");
          } else {
            newsText.value = "No news";
          }
        } else {
          newsText.value = "No news";
        }
      },
    );
  }

  /// Shared mutex so the FAQ popup and the generic popup message
  /// never appear on screen at the same time. Any code that opens
  /// one of these dialogs must set this to `true` right before
  /// calling `Get.dialog(...)` and reset it to `false` when the
  /// dialog is closed.
  static bool isPopupOpen = false;
}
