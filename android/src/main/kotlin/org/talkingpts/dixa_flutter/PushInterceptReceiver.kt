package org.talkingpts.dixa_flutter

import android.app.Application
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.dixa.messenger.DixaMessenger
import com.google.firebase.messaging.RemoteMessage

class PushInterceptReceiver : BroadcastReceiver() {


    override fun onReceive(context: Context?, intent: Intent?) {
        if (context == null) return

        val application = context.applicationContext as Application

        val dataBundle = intent?.extras ?: return

        val remoteMessage = RemoteMessage(dataBundle)
        val message = remoteMessage.data

       
        if (remoteMessage.data["type"].toString() == "deliver-message"){
            Log.d(TAG, "Dixa message received")
            DixaMessenger.PushNotifications.processNewMessage(remoteMessage)
        }else{
            Log.d(TAG, "Not Dixa message received")
        }

        

     
    }

    companion object {
        private const val TAG = "PushInterceptReceiver"
    }
}