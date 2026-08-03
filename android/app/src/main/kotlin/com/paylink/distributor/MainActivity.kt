package com.paylink.distributor

import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.drawable.BitmapDrawable
import android.net.Uri
import android.os.Build
import android.util.Log
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import android.content.Context
import android.telephony.SubscriptionManager

class MainActivity : FlutterFragmentActivity() {
   private val CHANNEL = "com.paylink.distributor/upi_choose"
    private val SIM_CHANNEL = "sim_verification"
    private val TAG = "UPI_DEBUG"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call,
                result ->
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
                        val resolveInfos =
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
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
                        resolveInfos.forEach { Log.d(TAG, "Found: ${it.activityInfo.packageName}") }

                        val apps =
                                resolveInfos
                                        .distinctBy {
                                            it.activityInfo.packageName
                                        } // avoid dup entries
                                        .map { info ->
                                            val packageName = info.activityInfo.packageName
                                            val appName = info.loadLabel(packageManager).toString()
                                            val iconDrawable = info.loadIcon(packageManager)
                                            val bitmap =
                                                    if (iconDrawable is BitmapDrawable) {
                                                        iconDrawable.bitmap
                                                    } else {
                                                        val bmp =
                                                                Bitmap.createBitmap(
                                                                        iconDrawable.intrinsicWidth
                                                                                .coerceAtLeast(1),
                                                                        iconDrawable.intrinsicHeight
                                                                                .coerceAtLeast(1),
                                                                        Bitmap.Config.ARGB_8888
                                                                )
                                                        val canvas = android.graphics.Canvas(bmp)
                                                        iconDrawable.setBounds(
                                                                0,
                                                                0,
                                                                canvas.width,
                                                                canvas.height
                                                        )
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

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SIM_CHANNEL)
                .setMethodCallHandler { call, result ->
                    when (call.method) {
                        "getSimList" -> {
                            try {
                                result.success(getSimList())
                            } catch (e: SecurityException) {
                                result.error(
                                        "PERMISSION_DENIED",
                                        "Missing READ_PHONE_STATE permission",
                                        null
                                )
                            } catch (e: Exception) {
                                result.error("SIM_ERROR", e.message, null)
                            }
                        }
                        else -> result.notImplemented()
                    }
                }
    }

    private fun getSimList(): List<Map<String, Any>> {
        val subscriptionManager =
                getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager

        val activeSims = subscriptionManager.activeSubscriptionInfoList ?: return emptyList()

        return activeSims.map {
            mapOf(
                    "carrierName" to it.carrierName.toString(),
                    "number" to (it.number ?: ""),
                    "slotIndex" to it.simSlotIndex,
                    "subscriptionId" to it.subscriptionId
            )
        }
    }
}
