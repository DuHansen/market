 package io.flutter.plugins.batteryexample;

 import android.os.Bundle;
 import io.flutter.app.FlutterActivity;
 import io.flutter.plugins.battery.BatteryPlugin;

 public class EmbeddingV1Activity extends FlutterActivity {
   @Override
   protected void onCreate(Bundle savedInstanceState) {
     super.onCreate(savedInstanceState);
     BatteryPlugin.registerWith(registrarFor("io.flutter.plugins.battery.BatteryPlugin"));
   }
 }
package [your.package.name];

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
  // You do not need to override onCreate() in order to invoke
  // GeneratedPluginRegistrant. Flutter now does that on your behalf.

  // ...retain whatever custom code you had from before (if any).
}
class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
    }
}