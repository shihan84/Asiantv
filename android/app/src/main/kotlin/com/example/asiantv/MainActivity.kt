package com.example.asiantv

import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Android 12 compatibility
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // Handle Android 12 specific initialization if needed
        }
    }
}
