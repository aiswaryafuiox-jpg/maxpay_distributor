import 'package:get/get.dart';

class NotificationController extends GetxController {
  var notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.value = [
      {
        "title": "Wallet Request Approved",
        "message":
            "Your wallet credit request of ₹10,000 has been approved by Admin.",
        "time": "10 min ago",
        "isRead": false,
      },
      {
        "title": "Retailer Fund Request",
        "message":
            "Retailer 'Rahul Mobiles' has requested a wallet transfer of ₹5,000.",
        "time": "25 min ago",
        "isRead": false,
      },
      {
        "title": "Commission Credited",
        "message":
            "Commission of ₹1,450 for recharge transactions has been credited to your wallet.",
        "time": "2 hours ago",
        "isRead": false,
      },
      {
        "title": "Low Balance Alert",
        "message":
            "Retailer 'Anil Enterprises' wallet balance is below ₹500 threshold.",
        "time": "5 hours ago",
        "isRead": true,
      },
      {
        "title": "New Retailer Registered",
        "message":
            "Retailer 'Star Communications' has successfully onboarded under your distributor network.",
        "time": "Yesterday",
        "isRead": true,
      },
      {
        "title": "KYC Approved",
        "message":
            "Your submitted KYC verification has been reviewed and approved by the admin team.",
        "time": "2 days ago",
        "isRead": true,
      },
    ];
  }

  void markAsRead(int index) {
    if (index >= 0 && index < notifications.length) {
      notifications[index]["isRead"] = true;
      notifications.refresh();
    }
  }

  void markAllAsRead() {
    for (var n in notifications) {
      n["isRead"] = true;
    }
    notifications.refresh();
  }

  void clearAll() {
    notifications.clear();
  }
}
