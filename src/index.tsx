import NativeAppleHealthKit from './NativeAppleHealthKit';
export * from './types';

export const requestHealthKitPermissions = async () => {
  await NativeAppleHealthKit.requestHealthKitPermissions();
};

export const getHeartRate = async (days: number) => {
  await NativeAppleHealthKit.getHeartRate(days);
};

export const getSteps = async (days: number) => {
  await NativeAppleHealthKit.getSteps(days);
};

export const getMeasurement = async () => {
  await NativeAppleHealthKit.getMeasurement();
};
