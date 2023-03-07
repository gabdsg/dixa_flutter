package org.talkingpts.dixa_flutter

import androidx.annotation.NonNull

import android.app.Application
import android.app.Activity


import com.dixa.messenger.DixaMessenger
import com.dixa.messenger.LogLevel
import com.google.firebase.messaging.RemoteMessage


import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** DixaFlutterPlugin */
class DixaFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  	private lateinit var channel : MethodChannel
	private lateinit var application : Application
  	private lateinit var activity : Activity


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "dixa_flutter")
    channel.setMethodCallHandler(this)

	var context = flutterPluginBinding.applicationContext
	 while (context != null) {
		print("Trying to resolve Application from Context: ${context.javaClass.name}")
		application = context as Application
		if (application != null) {
			print("Resolved Application from Context")
			break
		} else {
			context = context.applicationContext
		}
	}
	if (application == null) {
		print("Fail to resolve Application from Context")
	}
  }


	override fun onAttachedToActivity(binding: ActivityPluginBinding) {
		activity = binding.activity
	}

	override fun onDetachedFromActivityForConfigChanges() {
		// TODO: the Activity your plugin was attached to was destroyed to change configuration.
		// This call will be followed by onReattachedToActivityForConfigChanges().
	}

	override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
		// TODO: your plugin is now attached to a new Activity after a configuration change.
	}

	override fun onDetachedFromActivity() {
		// TODO: your plugin is no longer associated with an Activity. Clean up references.
	}



  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

	when (call.method) {
		"configure" -> {            
			val apiKey = call.argument<String>("apiKey")
			if (apiKey != null) {
				val config = DixaMessenger.Configuration.Builder()
				.setApiKey(apiKey)
				.setLogLevel(LogLevel.ERROR)
				.build()
				DixaMessenger.init(config, application)
			}
		}
		"setPushToken" ->{
			val token = call.argument<String>("token")
			if (token != null) {
				DixaMessenger.PushNotifications.registerNewToken(token)
			}
		}
		"updateUserCredentials" ->{
		 	val username = call.argument<String>("username")
			val email = call.argument<String>("email")
			if (username != null && email != null) {
            	DixaMessenger.updateUserCredentials(name = username, email = email)
				result.success(true)
			}else{
				result.success(false)
			}
            
		}
		"clearUserCredentials" -> {
			DixaMessenger.clearUserCredentials()
            result.success(true)
		}
		"openMessenger" -> {
			DixaMessenger.openMessenger(activity = activity)
		}
		"processPushMessage" -> {
			val remoteMessage: RemoteMessage? = call.argument<RemoteMessage>("remoteMessage")
			if (remoteMessage != null) {
				DixaMessenger.PushNotifications.processNewMessage(remoteMessage)
			}	
		}
		else -> {
			result.notImplemented()
		}
	}


  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

}
