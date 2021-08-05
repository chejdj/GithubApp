package com.lingoace.github_app

import android.app.Application
import android.os.Handler
import com.google.firebase.crashlytics.FirebaseCrashlytics
import java.lang.RuntimeException

class MyApplication: Application(){
    override fun onCreate() {
        super.onCreate()
        FirebaseCrashlytics.getInstance().setUserId("123456")
        FirebaseCrashlytics.getInstance().setCustomKey("network",0)
        FirebaseCrashlytics.getInstance().setCustomKey("login",1)
        FirebaseCrashlytics.getInstance().log("MyApplication onCreate")
    }
}