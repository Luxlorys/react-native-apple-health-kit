import type { TurboModule } from 'react-native';
import { Platform, TurboModuleRegistry } from 'react-native';
import type { HeartRate, Measurement, Step } from './types';

export interface Spec extends TurboModule {
  requestHealthKitPermissions(): Promise<string>;
  getSteps(daysBefore: number): Promise<Step[]>;
  getHeartRate(daysBefore: number): Promise<HeartRate[]>;
  getMeasurement(): Promise<Measurement>;
}

const NoOpSpec: Spec = {
  requestHealthKitPermissions(): Promise<string> {
    return Promise.reject(new Error('HealthKit is not available on Android.'));
  },
  getSteps(): Promise<Step[]> {
    return Promise.reject(new Error('HealthKit is not available on Android.'));
  },
  getHeartRate(): Promise<HeartRate[]> {
    return Promise.reject(new Error('HealthKit is not available on Android.'));
  },
  getMeasurement(): Promise<Measurement> {
    return Promise.reject(new Error('HealthKit is not available on Android.'));
  },
};

export default Platform.OS === 'android'
  ? NoOpSpec
  : TurboModuleRegistry.getEnforcing<Spec>('AppleHealthKit');
