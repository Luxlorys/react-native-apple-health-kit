import ReactNativeAppleHealthKit, {
  type HeartRate,
  type Measurement,
  type Step,
} from './NativeReactNativeAppleHealthKit';

export async function requestHealthKitPermissions(): Promise<string> {
  return await ReactNativeAppleHealthKit.requestHealthKitPermissions();
}

export async function getMeasurement(): Promise<Measurement> {
  return await ReactNativeAppleHealthKit.getMeasurement();
}

export async function getSteps(forNumberOfDay: number): Promise<Step[]> {
  return await ReactNativeAppleHealthKit.getSteps(forNumberOfDay);
}

export async function getHeartRate(
  forNumberOfDay: number
): Promise<HeartRate[]> {
  return await ReactNativeAppleHealthKit.getHeartRate(forNumberOfDay);
}

export async function checkAvailability(): Promise<boolean> {
  return await ReactNativeAppleHealthKit.checkAvailability();
}
