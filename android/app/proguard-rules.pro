# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# Stripe rules
-keep class com.stripe.android.** { *; }
-keep class com.stripe.android.pushProvisioning.** { *; }
-keep class com.stripe.android.pushProvisioning.PushProvisioningActivity$g { *; }
-keep class com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args { *; }
-keep class com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error { *; }
-keep class com.stripe.android.pushProvisioning.PushProvisioningActivityStarter { *; }
-keep class com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider { *; }

# Keep all Stripe related classes
-keep class com.stripe.** { *; }
-dontwarn com.stripe.**

# Keep React Native Stripe SDK classes
-keep class com.reactnativestripesdk.** { *; }
-dontwarn com.reactnativestripesdk.**

# Keep all native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep all classes that have @Keep annotation
-keep @androidx.annotation.Keep class * { *; }
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}

# Keep all classes in the main package
-keep class com.findorlookup.findcarsale.** { *; }
