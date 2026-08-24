# flutter_local_notifications deserializes scheduled notifications with Gson's
# TypeToken in ScheduledNotificationBootReceiver.onReceive. R8 strips generic
# signatures by default, which makes TypeToken throw
# "TypeToken must be created with a type argument" on boot (Play crash report).
-keepattributes Signature
-keep class com.google.gson.** { *; }
-keep class com.dexterous.flutterlocalnotifications.** { *; }
