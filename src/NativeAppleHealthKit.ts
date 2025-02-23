import type { TurboModule } from 'react-native';
import { Platform, TurboModuleRegistry } from 'react-native';

export interface AppleMoveTime {
  dateString: string;
  moveTime: number;
}

export interface Step {
  dateString: string;
  stepCount: number;
}

export interface HeartRate {
  date: string;
  value: {
    time: string;
    heartRate: number;
  }[];
}

export interface Measurement {
  bodyMass: number | null;
  height: number | null;
  biologicalSex: string | null;
  dateOfBirth: string | null;
}

export interface Spec extends TurboModule {
  requestHealthKitPermissions(): Promise<string>;
  getSteps(daysBefore: number): Promise<Step[]>;
  getHeartRate(daysBefore: number): Promise<HeartRate[]>;
  getMeasurement(): Promise<Measurement>;
  getAppleMoveTime(daysBefore: number): Promise<AppleMoveTime[]>;
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
  getAppleMoveTime(): Promise<AppleMoveTime[]> {
    return Promise.reject(new Error('HealthKit is not available on Android.'));
  },
};

export default Platform.OS === 'android'
  ? NoOpSpec
  : TurboModuleRegistry.getEnforcing<Spec>('AppleHealthKit');
