import AppleHealthKit from './NativeAppleHealthKit';

export const {
  getStepsCountForCurrentDay,
  getStepsCountForLast30Days,
  requestHealthKitPermissions,
} = AppleHealthKit;
