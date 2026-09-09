# Please add these rules to your existing keep rules in order to suppress warnings.
-dontwarn com.nsdl.egov.esignaar.NsdlEsignActivity
-keep class com.nsdl.egov.esignaar.NsdlEsignActivity { *; }

# Keep weipl checkout classes safe
-dontwarn com.weipl.checkout.**
-keep class com.weipl.checkout.** { *; }
