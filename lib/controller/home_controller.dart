import 'package:get/get.dart';


class HomePageController extends GetxController {
  // final GetNewsUseCase getNewsUseCase;
  // final GetWalletBalanceUseCase getWalletBalanceUseCase;
  // final TransSucFailUsecase transSucFailUsecase;
  // final ComplaintsUseCase complaintsUseCase;
  // final GetPopupMessageUseCase getPopupMessageUseCase;
  // final RefundCountUsecase refundCountUsecase;
  // final TodayCreditUsecase todaycreditusecase;
  // final GraphUsecase graphUsecase;
  // final FaqUsecase faqUsecase;

  // Rxn<TransactionResponse> transactionData = Rxn<TransactionResponse>();
  // final Rx<WalletBalance?> walletBalance = Rx<WalletBalance?>(null);
  // final Rx<PopupMessage?> popupMessage = Rx<PopupMessage?>(null);
  // final Rx<Complaints?> complaints = Rx<Complaints?>(null);
  // final Rx<RefundCount?> refundcount = Rx<RefundCount?>(null);
  // final Rx<TodayCredit?> todaycredit = Rx<TodayCredit?>(null);
  // final Rx<News?> news = Rx<News?>(null);
  // final Rx<Graph?> graphData = Rx<Graph?>(null);
  // final Rx<Faq?> faq = Rx<Faq?>(null);

  RxBool isLoading = false.obs;

  /// Shared mutex so the FAQ popup and the generic popup message
  /// never appear on screen at the same time. Any code that opens
  /// one of these dialogs must set this to `true` right before
  /// calling `Get.dialog(...)` and reset it to `false` when the
  /// dialog is closed.
  static bool isPopupOpen = false;
}
