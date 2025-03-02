import { View, StyleSheet, Button } from 'react-native';
import {
  checkAvailability,
  getHeartRate,
  getMeasurement,
  getSteps,
  requestHealthKitPermissions,
} from '@gromozeqa/react-native-apple-health-kit';

export default function App() {
  const checkHealthKitAvaiability = async () => {
    try {
      const status = await checkAvailability();
      console.log(status);
    } catch (error) {
      console.log(error);
    }
  };

  const getUserMeasurement = async () => {
    try {
      const status = await getMeasurement();
      console.log(status);
    } catch (error) {
      console.log(error);
    }
  };

  const requestPermissions = async () => {
    try {
      const status = await requestHealthKitPermissions();
      console.log(status);
    } catch (error) {
      console.log(error);
    }
  };

  const getUsersHeartRate = async () => {
    try {
      const status = await getHeartRate(30);
      console.log(status);
    } catch (error) {
      console.log(error);
    }
  };

  const getUsersStepsCount = async () => {
    try {
      const status = await getSteps(30);
      console.log(status);
    } catch (error) {
      console.log(error);
    }
  };

  return (
    <View style={styles.container}>
      <Button
        title="checkHealthKitAvaiability"
        onPress={checkHealthKitAvaiability}
      />
      <Button title="getUserMeasurement" onPress={getUserMeasurement} />
      <Button title="getUsersHeartRate" onPress={getUsersHeartRate} />
      <Button title="getUsersStepsCount" onPress={getUsersStepsCount} />
      <Button title="requestPermissions" onPress={requestPermissions} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
