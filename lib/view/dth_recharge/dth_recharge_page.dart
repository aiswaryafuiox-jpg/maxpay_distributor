import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/view/recharge/confirm_transaction_page.dart';

class DTHRechargePage extends StatefulWidget {
  const DTHRechargePage({super.key});

  @override
  State<DTHRechargePage> createState() => _DTHRechargePageState();
}

class _DTHRechargePageState extends State<DTHRechargePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedOperator = 'Airtel TV';
  Color _selectedOperatorColor = Colors.red;
  bool _showCustomerInfo = false;
  bool _isPaymentReceived = false;

  final List<Map<String, dynamic>> _operators = [
    {'name': 'Airtel TV', 'color': Colors.red},
    {'name': 'Dish TV', 'color': Colors.orange},
    {'name': 'Tata Play', 'color': Colors.blue},
    {'name': 'Sun Direct', 'color': Colors.yellow},
    {'name': 'Videocon d2h', 'color': Colors.green},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _showOperatorSelector(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: isDark ? AppColors.darkbgBlack : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            padding: EdgeInsets.all(20.r),
            width: 300.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Operator',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.orange,
                        size: 20.sp,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Divider(color: Colors.grey.withValues(alpha: 0.1)),
                ..._operators.map(
                  (op) => ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                    leading: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: op['color'],
                      child: Text(
                        op['name'][0],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      op['name'],
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedOperator = op['name'];
                        _selectedOperatorColor = op['color'];
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
            size: 18.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'DTH Recharge',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 WALLET BALANCE CARD
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15.h),
                decoration: BoxDecoration(
                  color: AppColors.clrPrimary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Text(
                      'Wallet Balance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      '₹ 245005.23',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              /// 🔹 CUSTOMER ID INPUT
              _buildInputLabel('Customer ID'),
              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkplceholder
                      : AppColors.clrplceholder,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Customer ID',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.cancel,
                          color: Colors.red.withValues(alpha: 0.5),
                          size: 20.sp,
                        ),
                        SizedBox(width: 10.w),
                        Icon(Icons.person, color: Colors.orange, size: 20.sp),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              /// 🔹 OPERATOR SELECTION
              GestureDetector(
                onTap: () => _showOperatorSelector(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkplceholder
                        : AppColors.clrplceholder,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 12.r,
                        backgroundColor: _selectedOperatorColor,
                        child: Text(
                          _selectedOperator[0],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        _selectedOperator,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_drop_down,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              /// 🔹 AMOUNT INPUT
              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkplceholder
                      : AppColors.clrplceholder,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Amount',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              /// 🔹 TOGGLE BUTTONS (Plan / Customer Info)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildToggleButton('Plan', !_showCustomerInfo, () {
                    setState(() {
                      _showCustomerInfo = false;
                    });
                  }),
                  SizedBox(width: 10.w),
                  _buildToggleButton('Customer Info', _showCustomerInfo, () {
                    setState(() {
                      _showCustomerInfo = true;
                    });
                  }),
                ],
              ),
              SizedBox(height: 20.h),

              /// 🔹 PAYMENT RECEIVED CHECKBOX
              Row(
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: Checkbox(
                      value: _isPaymentReceived,
                      onChanged: (v) {
                        setState(() {
                          _isPaymentReceived = v ?? false;
                        });
                      },
                      activeColor: AppColors.clrPrimary,
                      side: BorderSide(color: Colors.grey, width: 1.5.w),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Payment Received',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),

              if (!_showCustomerInfo) ...[
                /// 🔹 TABS FOR PLANS
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: Colors.orange,
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.grey,
                  dividerColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  tabs: const [
                    Tab(text: 'Entertainment Plan'),
                    Tab(text: 'Combo'),
                  ],
                ),
                SizedBox(height: 15.h),

                /// 🔹 PLAN LIST
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return _buildPlanCard(isDark);
                  },
                ),
              ] else ...[
                /// 🔹 CUSTOMER INFO SECTION
                _buildCustomerInfoSection(isDark),
              ],

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive ? AppColors.fav5 : Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
          border: isActive
              ? null
              : Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(bool isDark) {
    const price = "365";
    final cardColor = isDark ? AppColors.darkplceholder : AppColors.lightbg2;
    final primaryText = isDark ? Colors.white : Colors.black;
    final dividerColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.06);

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.05),
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\u{20B9}$price",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: primaryText,
                ),
              ),
              _buildPlanStat("28", ' days', 'validity'),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmTransactionPage(
                        productName: _selectedOperator,
                        operatorInitial: _selectedOperator[0],
                        operatorColor: _selectedOperatorColor,
                        amount: "\u{20B9}$price.00",
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.clrPrimary,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'buy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(height: 1, thickness: 1, color: dividerColor),
          ),
          Padding(
            padding: EdgeInsets.only(left: 100.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPlanBullet('12am-12pm Unlimited Data'),
                _buildPlanBullet('Unlimited Calls'),
                _buildPlanBullet('Weekend Data Rollover'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanBullet(String text) {
    return Text(
      "\u{2022} $text",
      style: TextStyle(
        fontSize: 10.sp,
        height: 1.45,
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.textclr
            : AppColors.clrTextgrey,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildPlanStat(String value, String subLabel, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              TextSpan(
                text: subLabel,
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : AppColors.clrTextgrey,
                ),
              ),
            ],
          ),
        ),

        Text(
          label,
          style: TextStyle(fontSize: 8.sp, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildCustomerInfoSection(bool isDark) {
    if (isDark) {
      return _buildDarkCustomerInfoSection();
    }

    final labelBgColor = isDark
        ? AppColors.darkplceholder
        : const Color(0xFFF8F9FF);
    final valueBgColor = isDark
        ? AppColors.darkplceholder.withValues(alpha: 0.85)
        : const Color(0xFFFFDEE5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputLabel(''),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              _buildInfoRow(
                'Customer Name',
                'Alagan',
                isDark,
                labelBgColor,
                valueBgColor,
                isMultiLine: false,
              ),
              _buildInfoRow(
                'Current Balance',
                '1.98',
                isDark,
                labelBgColor,
                valueBgColor,
              ),
              _buildInfoRow(
                'Monthly Transaction',
                '641',
                isDark,
                labelBgColor,
                valueBgColor,
              ),
              _buildInfoRow(
                'Next Transaction',
                '25-Jul-2025',
                isDark,
                labelBgColor,
                valueBgColor,
              ),
              _buildInfoRow(
                'Plan Name',
                'Tamil Basic Package Subscription 3 Months Renewal',
                isDark,
                labelBgColor,
                valueBgColor,
                isMultiLine: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDarkCustomerInfoSection() {
    const details = [
      ('Customer Name', 'Alagan'),
      ('Current Balance', '1.98'),
      ('Monthly Transaction', '641'),
      ('Next Transaction', '25-Jul-2025'),
      ('Plan Name', 'Tamil Basic Package\nSubscription 3 Months\nRenewal'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer Info',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 5.h),
              Container(width: 105.w, height: 2, color: Colors.orange),
            ],
          ),
        ),
        SizedBox(height: 18.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(7.r),
          child: Container(
            width: double.infinity,
            color: AppColors.darkplceholder,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 43,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8.w, 10.h, 6.w, 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final item in details)
                            _buildDarkInfoText(
                              item.$1,
                              bottomPadding: item == details.last ? 0 : 14.h,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Column(
                      children: [
                        for (final item in details)
                          _buildDarkInfoText(
                            ':',
                            bottomPadding: item == details.last ? 0 : 14.h,
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 51,
                    child: Container(
                      color: const Color(0xFF42465B),
                      padding: EdgeInsets.fromLTRB(24.w, 10.h, 10.w, 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final item in details)
                            _buildDarkInfoText(
                              item.$2,
                              bottomPadding: item == details.last ? 0 : 14.h,
                              fontWeight: FontWeight.w600,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDarkInfoText(
    String text, {
    required double bottomPadding,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.sp,
          height: 1.35,
          fontWeight: fontWeight,
          color: AppColors.textclr,
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    bool isDark,
    Color labelBgColor,
    Color valueBgColor, {
    bool isMultiLine = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 155.w,
            color: labelBgColor,
            padding: EdgeInsets.fromLTRB(10.w, 8.h, 6.w, 8.h),
            alignment: isMultiLine ? Alignment.topLeft : Alignment.centerLeft,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: valueBgColor,
              padding: EdgeInsets.fromLTRB(6.w, 8.h, 10.w, 8.h),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: isMultiLine
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Text(
                        ':',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
