import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/snackbar.dart';
import 'package:maxpay/data/model/home_card_model.dart';
import 'package:maxpay/data/model/news_model.dart';
import 'package:maxpay/data/model/today_transaction_model.dart';
import 'package:maxpay/domain/usecase/home/get_home_card_usecase.dart';
import 'package:maxpay/domain/usecase/home/get_today_transaction_amount_usecase.dart';
import 'package:maxpay/domain/usecase/home/get_news_usecase.dart';
import 'package:maxpay/domain/usecase/home/get_faq_usecase.dart';
import 'package:maxpay/domain/usecase/home/get_popup_message_usecase.dart';
import 'package:maxpay/domain/usecase/home/faq_reply_usecase.dart';
import 'package:maxpay/data/model/faq_model.dart' as faq_model;
import 'package:maxpay/data/model/popup_message_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {
  final GetHomeCardUseCase getHomeCardUseCase;
  final GetTodayTransactionAmountUseCase getTodayTransactionAmountUseCase;
  final GetNewsUseCase getNewsUseCase;
  final GetFaqUseCase getFaqUseCase;
  final GetPopupMessageUseCase getPopupMessageUseCase;
  final FaqReplyUseCase faqReplyUseCase;

  HomePageController(
    this.getHomeCardUseCase,
    this.getTodayTransactionAmountUseCase,
    this.getNewsUseCase,
    this.getFaqUseCase,
    this.getPopupMessageUseCase,
    this.faqReplyUseCase,
  );

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  final Rx<NewsModel?> news = Rx<NewsModel?>(null);
  Rx<HomeCardData?> homeCardData = Rx<HomeCardData?>(null);
  Rx<TodayTransactionData?> todayTransactionData = Rx<TodayTransactionData?>(null);
  
  Rx<faq_model.Faq?> faqData = Rx<faq_model.Faq?>(null);
  Rx<PopupMessage?> popupMessageData = Rx<PopupMessage?>(null);


  @override
  void onInit() {
    super.onInit();
    fetchHomeCardData();
    fetchTodayTransactionAmount();
    fetchNews();
    fetchFaq();
    fetchPopupMessage("Home");
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
    try {
      AppLogger.debugPrint("🚀 [API CALL START] fetchNews");
      isLoading.value = true;

      final result = await getNewsUseCase();

      result.fold(
        (failure) {
          CustomToast.error(failure.message);
        },
        (data) {
          AppLogger.debugPrint("✅ [API CALL SUCCESS] fetchNews");
          news.value = data;
        },
      );
    } catch (e) {
      AppLogger.logError("🔥 [API CALL EXCEPTION] fetchNews error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> faqReply({
    required String comment,
    required String faqid,
    required String reply,
  }) async {
    try {
      isLoading.value = true;

      final result = await faqReplyUseCase(
        comment: comment,
        faqid: faqid,
        reply: reply,
      );

      AppLogger.debugPrint("API CALLED SUCCESSFULLY");

      result.fold(
        (failure) {
          CustomToast.error(failure.message.toString());
          debugPrint("ERROR: ${failure.message}");
        },
        (response) async {
          CustomToast.success(response.message ?? "FAQ Replied Successfully");
          debugPrint("SUCCESS RESPONSE: ${response.toJson()}");

          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool("faq_replied_$faqid", true);
        },
      );
    } catch (e) {
      CustomToast.error(e.toString());
      debugPrint("EXCEPTION: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFaq() async {
    try {
      final result = await getFaqUseCase();
      result.fold(
        (failure) {
          AppLogger.logError("Failed to fetch FAQ: ${failure.message}");
        },
        (data) async {
          faqData.value = data;

          if (data.data == null || data.data!.isEmpty) {
            return;
          }

          final currentFaq = data.data!.first;
          bool alreadyRepliedOnServer = currentFaq.isreply == "1";
          bool alreadyRepliedLocally = false;
          
          if (!alreadyRepliedOnServer) {
            final prefs = await SharedPreferences.getInstance();
            alreadyRepliedLocally = prefs.getBool("faq_replied_${currentFaq.id}") ?? false;
          }

          if (alreadyRepliedOnServer || alreadyRepliedLocally) {
            return;
          }

          final now = DateTime.now();
          final fromDate = currentFaq.liveFromDate ?? DateTime.now();
          final toDate = (currentFaq.liveFromDate ?? DateTime.now()).add(
            const Duration(days: 1),
          );

          if (now.isAfter(fromDate.subtract(const Duration(seconds: 1))) &&
              now.isBefore(toDate)) {
            await _showFaqPopup(currentFaq);
          }
        },
      );
    } catch (e) {
      AppLogger.logError("Error fetching FAQ: $e");
    }
  }

  Future<void> fetchPopupMessage(String currentScreen) async {
    try {
      final result = await getPopupMessageUseCase();
      result.fold(
        (failure) {
          AppLogger.logError("Failed to fetch Popup Message: ${failure.message}");
        },
        (data) async {
          popupMessageData.value = data;

          final popupList = data.data ?? [];
          if (popupList.isEmpty) {
            return;
          }

          for (var popupData in popupList) {
            if ((popupData.screenType ?? "").toLowerCase() != currentScreen.toLowerCase()) {
              continue;
            }

            String currentUserType = "Distributor";

            List<dynamic> userTypes = [];
            if (popupData.userType != null && popupData.userType!.isNotEmpty) {
              userTypes = jsonDecode(popupData.userType!);
            }

            if (!userTypes.contains(currentUserType)) continue;

            if ((Get.isDialogOpen ?? false) || HomePageController.isPopupOpen) {
              break;
            }

            String noOfMsg = popupData.noOfMsg ?? "0-0";
            int maxCount = int.tryParse(noOfMsg.split("-").last) ?? 0;

            final prefs = await SharedPreferences.getInstance();
            String key = "popup_${popupData.id}_$currentScreen";

            int currentCount = prefs.getInt(key) ?? 0;

            if (currentCount >= maxCount) continue;

            await prefs.setInt(key, currentCount + 1);

            Future.delayed(const Duration(milliseconds: 500), () {
              if ((Get.isDialogOpen ?? false) || HomePageController.isPopupOpen) {
                return;
              }

              HomePageController.isPopupOpen = true;

              Get.dialog(
                barrierDismissible: false,
                barrierColor: Colors.black.withValues(alpha: 0.4),
                Dialog(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12, right: 12),
                        child: Container(
                          width: 250,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Theme.of(Get.context!).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            popupData.message ?? "",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: InkWell(
                          onTap: () {
                            HomePageController.isPopupOpen = false;
                            if (Get.isDialogOpen ?? false) {
                              Get.back();
                            }
                          },
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });

            break;
          }
        },
      );
    } catch (e) {
      AppLogger.logError("Error fetching Popup Message: $e");
    }
  }

  /// Shared mutex so the FAQ popup and the generic popup message
  /// never appear on screen at the same time. Any code that opens
  /// one of these dialogs must set this to `true` right before
  /// calling `Get.dialog(...)` and reset it to `false` when the
  /// dialog is closed.
  static bool isPopupOpen = false;
}

Future<void> _showFaqPopup(faq_model.Data faqData) async {
  final commentController = TextEditingController();
  final homeController = Get.find<HomePageController>();

  if (faqData.isreply == "1") {
    return;
  }

  if ((Get.isDialogOpen ?? false) || HomePageController.isPopupOpen) {
    return;
  }

  HomePageController.isPopupOpen = true;

  Get.dialog(
    barrierDismissible: false,
    Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 18),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if ((faqData.image ?? "").isNotEmpty)
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(
                        faqData.image!,
                        width: double.infinity,
                        height: 280,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Enter Comments",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: commentController,
                          maxLines: 4,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: "Interest",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await homeController.faqReply(
                                      comment: commentController.text.trim(),
                                      faqid: faqData.id.toString(),
                                      reply: faqData.replyOne ?? "",
                                    );

                                    HomePageController.isPopupOpen = false;
                                    Get.back();
                                  },
                                  child: Text(
                                    faqData.replyOne?.isNotEmpty == true
                                        ? faqData.replyOne!
                                        : "Reply 1",
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.clrPrimary,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await homeController.faqReply(
                                      comment: commentController.text.trim(),
                                      faqid: faqData.id.toString(),
                                      reply: faqData.replyTwo ?? "",
                                    );

                                    HomePageController.isPopupOpen = false;
                                    Get.back();
                                  },
                                  child: Text(
                                    faqData.replyTwo?.isNotEmpty == true
                                        ? faqData.replyTwo!
                                        : "Reply 2",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                HomePageController.isPopupOpen = false;
                Get.back();
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(5),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
