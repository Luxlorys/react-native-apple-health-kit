export interface Step {
  dateString: string;
  stepCount: number;
}

export interface HeartRateValue {
  time: string;
  heartRate: number;
}

export interface HeartRate {
  date: string;
  value: HeartRateValue[];
}

export interface Measurement {
  bodyMass: number | null;
  height: number | null;
  biologicalSex: string | null;
  dateOfBirth: string | null;
}
