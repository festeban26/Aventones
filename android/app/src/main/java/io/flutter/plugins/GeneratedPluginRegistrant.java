package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.roughike.facebooklogin.facebooklogin.FacebookLoginPlugin;
import com.baseflow.geolocator.GeolocatorPlugin;
import com.baseflow.googleapiavailability.GoogleApiAvailabilityPlugin;
import io.flutter.plugins.googlemaps.GoogleMapsPlugin;
import com.baseflow.location_permissions.LocationPermissionsPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FacebookLoginPlugin.registerWith(registry.registrarFor("com.roughike.facebooklogin.facebooklogin.FacebookLoginPlugin"));
    GeolocatorPlugin.registerWith(registry.registrarFor("com.baseflow.geolocator.GeolocatorPlugin"));
    GoogleApiAvailabilityPlugin.registerWith(registry.registrarFor("com.baseflow.googleapiavailability.GoogleApiAvailabilityPlugin"));
    GoogleMapsPlugin.registerWith(registry.registrarFor("io.flutter.plugins.googlemaps.GoogleMapsPlugin"));
    LocationPermissionsPlugin.registerWith(registry.registrarFor("com.baseflow.location_permissions.LocationPermissionsPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
