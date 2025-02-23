package com.applehealthkit

import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.annotations.ReactModule

@ReactModule(name = AppleHealthKitModule.NAME)
class AppleHealthKitModule(reactContext: ReactApplicationContext) :
  NativeAppleHealthKitSpec(reactContext) {

  override fun getName(): String {
    return NAME
  }

  // Placeholder for requestHealthKitPermissions
  override fun requestHealthKitPermissions(promise: Promise) {
    promise.reject("Unsupported", "HealthKit is not supported on Android.")
  }

  // Placeholder for getSteps
  override fun getSteps(daysBefore: Double, promise: Promise) {
    promise.reject("Unsupported", "HealthKit is not supported on Android.")
  }

  // Placeholder for getHeartRate
  override fun getHeartRate(daysBefore: Double, promise: Promise) {
    promise.reject("Unsupported", "HealthKit is not supported on Android.")
  }

  // Placeholder for getMeasurement
  override fun getMeasurement(promise: Promise) {
    promise.reject("Unsupported", "HealthKit is not supported on Android.")
  }

  // Placeholder for getAppleMoveTime
  override fun getAppleMoveTime(daysBefore: Double, promise: Promise) {
    promise.reject("Unsupported", "HealthKit is not supported on Android.")
  }

  companion object {
    const val NAME = "AppleHealthKit"
  }
}