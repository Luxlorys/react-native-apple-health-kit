import AppleHealthKit from './NativeAppleHealthKit';

export const {
  getSteps,
  requestHealthKitPermissions,
  getHeartRate,
  getMeasurement,
  getAppleMoveTime,
} = AppleHealthKit;
