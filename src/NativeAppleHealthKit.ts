import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

interface AppleMoveTime {
  dateString: string;
  moveTime: number;
}

interface Step {
  dateString: string;
  stepCount: number;
}

interface HeartRate {
  date: string;
  value: {
    time: string;
    heartRate: number;
  }[];
}

interface Measurement {
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

export default TurboModuleRegistry.getEnforcing<Spec>('AppleHealthKit');
