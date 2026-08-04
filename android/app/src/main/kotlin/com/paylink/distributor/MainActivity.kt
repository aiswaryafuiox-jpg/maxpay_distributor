package com.paylink.distributor

import android.Manifest
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.drawable.BitmapDrawable
import android.net.Uri
import android.os.Build
import android.telephony.SubscriptionInfo
import android.telephony.SubscriptionManager
import android.telephony.TelephonyManager
import android.util.Log
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "com.paylink.distributor/upi_choose"
    private val SIM_CHANNEL = "sim_verification"
    private val TAG = "UPI_DEBUG"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "openUpiChooser" -> {
                        val url = call.argument<String>("url")
                        if (url.isNullOrBlank()) {
                            result.success(false)
                            return@setMethodCallHandler
                        }
                        try {
                            val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                            val chooser = Intent.createChooser(intent, "Pay using")
                            chooser.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

                            if (chooser.resolveActivity(packageManager) != null) {
                                startActivity(chooser)
                                result.success(true)
                            } else {
                                result.success(false)
                            }
                        } catch (e: Exception) {
                            Log.e(TAG, "openUpiChooser failed", e)
                            result.success(false)
                        }
                    }

                    "getInstalledUpiApps" -> {
                        try {
                            val upiIntent = Intent(Intent.ACTION_VIEW, Uri.parse("upi://pay"))

                            // FIX: MATCH_DEFAULT_ONLY is the correct flag — UPI apps
                            // register their upi:// intent-filter with category DEFAULT.
                            // MATCH_ALL was silently returning empty/wrong results on
                            // several OEM ROMs.
                            val resolveInfos = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                                packageManager.queryIntentActivities(
                                    upiIntent,
                                    PackageManager.ResolveInfoFlags.of(
                                        PackageManager.MATCH_DEFAULT_ONLY.toLong()
                                    )
                                )
                            } else {
                                packageManager.queryIntentActivities(
                                    upiIntent,
                                    PackageManager.MATCH_DEFAULT_ONLY
                                )
                            }

                            Log.d(TAG, "Raw resolveInfos count: ${resolveInfos.size}")
                            resolveInfos.forEach {
                                Log.d(TAG, "Found: ${it.activityInfo.packageName}")
                            }

                            val apps = resolveInfos
                                .distinctBy { it.activityInfo.packageName } // avoid dup entries
                                .map { info ->
                                    val packageName = info.activityInfo.packageName
                                    val appName = info.loadLabel(packageManager).toString()
                                    val iconDrawable = info.loadIcon(packageManager)
                                    val bitmap = if (iconDrawable is BitmapDrawable) {
                                        iconDrawable.bitmap
                                    } else {
                                        val bmp = Bitmap.createBitmap(
                                            iconDrawable.intrinsicWidth.coerceAtLeast(1),
                                            iconDrawable.intrinsicHeight.coerceAtLeast(1),
                                            Bitmap.Config.ARGB_8888
                                        )
                                        val canvas = android.graphics.Canvas(bmp)
                                        iconDrawable.setBounds(0, 0, canvas.width, canvas.height)
                                        iconDrawable.draw(canvas)
                                        bmp
                                    }

                                    val stream = ByteArrayOutputStream()
                                    bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
                                    val iconBytes = stream.toByteArray()

                                    mapOf(
                                        "packageName" to packageName,
                                        "name" to appName,
                                        "icon" to iconBytes
                                    )
                                }

                            Log.d(TAG, "Final apps list size: ${apps.size}")
                            result.success(apps)
                        } catch (e: Exception) {
                            Log.e(TAG, "getInstalledUpiApps failed", e)
                            result.error("UPI_LIST_ERROR", e.message, null)
                        }
                    }

                    "openSpecificUpiApp" -> {
                        val packageName = call.argument<String>("packageName")
                        val url = call.argument<String>("url")
                        if (packageName.isNullOrBlank() || url.isNullOrBlank()) {
                            result.success(false)
                            return@setMethodCallHandler
                        }
                        try {
                            val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                            intent.setPackage(packageName)
                            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

                            if (intent.resolveActivity(packageManager) != null) {
                                startActivity(intent)
                                result.success(true)
                            } else {
                                result.success(false)
                            }
                        } catch (e: Exception) {
                            Log.e(TAG, "openSpecificUpiApp failed", e)
                            result.error("UPI_OPEN_ERROR", e.message, null)
                        }
                    }

                    else -> result.notImplemented()
                }
            }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            SIM_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getSimList" -> {
                    try {
                        result.success(getSimList())
                    } catch (e: SecurityException) {
                        Log.e(TAG, "Permission denied for SIM info", e)
                        result.error("PERMISSION_DENIED", "Missing READ_PHONE_STATE permission", null)
                    } catch (e: Exception) {
                        Log.e(TAG, "Failed to get SIM list", e)
                        result.error("SIM_ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getSimList(): List<Map<String, Any>> {
        val hasPhoneState = ContextCompat.checkSelfPermission(
            this,
            Manifest.permission.READ_PHONE_STATE
        ) == PackageManager.PERMISSION_GRANTED

        val hasPhoneNumbers = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.READ_PHONE_NUMBERS
            ) == PackageManager.PERMISSION_GRANTED
        } else {
            false
        }

        val telephonyManager = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getSystemService(TelephonyManager::class.java)
                ?: (getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager)
        } else {
            getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager
        }

        val subscriptionManager = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getSystemService(SubscriptionManager::class.java)
                ?: (getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as? SubscriptionManager)
                ?: SubscriptionManager.from(this)
        } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
            SubscriptionManager.from(this)
        } else {
            null
        }

        val subList = mutableListOf<SubscriptionInfo>()

        // 1. Try activeSubscriptionInfoList (Standard API)
        if (subscriptionManager != null && (hasPhoneState || hasPhoneNumbers)) {
            try {
                val list = subscriptionManager.activeSubscriptionInfoList
                if (!list.isNullOrEmpty()) {
                    subList.addAll(list)
                }
            } catch (e: Exception) {
                Log.w(TAG, "activeSubscriptionInfoList failed: ${e.message}")
            }
        }

        // 2. If list is still empty, query by slot index (resolves Android 12 / OEM dual-SIM null list issue)
        if (subList.isEmpty() && subscriptionManager != null && (hasPhoneState || hasPhoneNumbers)) {
            val phoneCount = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                telephonyManager?.activeModemCount ?: 2
            } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                @Suppress("DEPRECATION")
                telephonyManager?.phoneCount ?: 2
            } else {
                2
            }
            for (slot in 0 until phoneCount) {
                try {
                    val subInfo = subscriptionManager.getActiveSubscriptionInfoForSimSlotIndex(slot)
                    if (subInfo != null && !subList.any { it.subscriptionId == subInfo.subscriptionId }) {
                        subList.add(subInfo)
                    }
                } catch (e: Exception) {
                    Log.w(TAG, "getActiveSubscriptionInfoForSimSlotIndex($slot) failed: ${e.message}")
                }
            }
        }

        // 3. If subscription info objects were found, map them
        if (subList.isNotEmpty()) {
            Log.d(TAG, "Found ${subList.size} subscription info records")
            return subList.map { subInfo ->
                var phoneNumber = ""

                // Method A: Android 13+ (API 33+) SubscriptionManager.getPhoneNumber(subId)
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU && subscriptionManager != null) {
                    try {
                        val num = subscriptionManager.getPhoneNumber(subInfo.subscriptionId)
                        if (!num.isNullOrBlank()) {
                            phoneNumber = num
                        }
                    } catch (e: Exception) {
                        Log.w(TAG, "getPhoneNumber failed for subId ${subInfo.subscriptionId}: ${e.message}")
                    }
                }

                // Method B: Legacy subInfo.number
                if (phoneNumber.isBlank()) {
                    try {
                        @Suppress("DEPRECATION")
                        val num = subInfo.number
                        if (!num.isNullOrBlank()) {
                            phoneNumber = num
                        }
                    } catch (e: Exception) {
                        Log.w(TAG, "subInfo.number failed for subId ${subInfo.subscriptionId}: ${e.message}")
                    }
                }

                // Method C: TelephonyManager line1Number for specific subscription ID (API 24+)
                if (phoneNumber.isBlank() && telephonyManager != null) {
                    try {
                        val subTelephony = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                            telephonyManager.createForSubscriptionId(subInfo.subscriptionId)
                        } else {
                            telephonyManager
                        }
                        val line1 = subTelephony.line1Number
                        if (!line1.isNullOrBlank()) {
                            phoneNumber = line1
                        }
                    } catch (e: Exception) {
                        Log.w(TAG, "subTelephony.line1Number failed for subId ${subInfo.subscriptionId}: ${e.message}")
                    }
                }

                val carrierName = subInfo.carrierName?.toString()?.takeIf { it.isNotBlank() }
                    ?: subInfo.displayName?.toString()?.takeIf { it.isNotBlank() }
                    ?: "SIM ${subInfo.simSlotIndex + 1}"

                val displayName = subInfo.displayName?.toString() ?: ""
                val countryIso = subInfo.countryIso ?: ""

                Log.d(
                    TAG,
                    "SIM slotIndex=${subInfo.simSlotIndex}, subId=${subInfo.subscriptionId}, carrier=$carrierName, number=$phoneNumber"
                )

                mapOf(
                    "carrierName" to carrierName,
                    "displayName" to displayName,
                    "number" to phoneNumber.trim(),
                    "slotIndex" to subInfo.simSlotIndex,
                    "subscriptionId" to subInfo.subscriptionId,
                    "countryIso" to countryIso
                )
            }
        }

        // 4. Fallback using TelephonyManager if SubscriptionManager returned empty but a SIM is inserted
        if (telephonyManager != null) {
            val simState = telephonyManager.simState
            val isSimPresent = simState == TelephonyManager.SIM_STATE_READY ||
                simState == TelephonyManager.SIM_STATE_NETWORK_LOCKED ||
                telephonyManager.simOperatorName.isNotBlank() ||
                telephonyManager.networkOperatorName.isNotBlank()

            if (isSimPresent) {
                Log.d(TAG, "Falling back to TelephonyManager for SIM detection")
                val operatorName = telephonyManager.simOperatorName.takeIf { it.isNotBlank() }
                    ?: telephonyManager.networkOperatorName.takeIf { it.isNotBlank() }
                    ?: "SIM 1"
                var line1 = ""
                try {
                    line1 = telephonyManager.line1Number ?: ""
                } catch (e: Exception) {
                    Log.w(TAG, "telephonyManager.line1Number fallback failed: ${e.message}")
                }
                val count = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                    telephonyManager.activeModemCount.coerceAtLeast(1)
                } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    @Suppress("DEPRECATION")
                    telephonyManager.phoneCount.coerceAtLeast(1)
                } else {
                    1
                }

                val fallbackSims = mutableListOf<Map<String, Any>>()
                for (i in 0 until count) {
                    fallbackSims.add(
                        mapOf(
                            "carrierName" to if (i == 0) operatorName else "SIM ${i + 1}",
                            "displayName" to if (i == 0) operatorName else "SIM ${i + 1}",
                            "number" to if (i == 0) line1.trim() else "",
                            "slotIndex" to i,
                            "subscriptionId" to (i + 1),
                            "countryIso" to (telephonyManager.simCountryIso ?: "")
                        )
                    )
                }
                return fallbackSims
            }
        }

        if (!hasPhoneState && !hasPhoneNumbers) {
            throw SecurityException("Missing READ_PHONE_STATE or READ_PHONE_NUMBERS permission")
        }

        return emptyList()
    }
}