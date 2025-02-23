import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

interface Step {
  datestring: string;
  stepCount: number;
}

export interface Spec extends TurboModule {
  requestHealthKitPermissions(): Promise<string>;
  getSteps(daysBefore: number): Promise<Step[]>;
}

export default TurboModuleRegistry.getEnforcing<Spec>('AppleHealthKit');
