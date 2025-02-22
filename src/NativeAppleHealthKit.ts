import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  requestHealthKitPermissions(): Promise<string>;
  getStepsCountForCurrentDay(): Promise<number | null>;
  getStepsCountForLast30Days(): Promise<number[] | null>;
}

export default TurboModuleRegistry.getEnforcing<Spec>('AppleHealthKit');
