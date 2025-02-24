import { View, StyleSheet, Button } from 'react-native';
import {
  getSteps,
  requestHealthKitPermissions,
  getHeartRate,
  getMeasurement,
} from 'react-native-apple-health-kit';

export default function App() {
  const requestPermissions = async () => {
    await requestHealthKitPermissions();
  };

  const stepsCount = async () => {
    try {
      const result = await getSteps(30);
      console.log(result);
    } catch (error) {
      console.log(error);
    }
  };
  const heartRate = async () => {
    try {
      const result = await getHeartRate(30);
      console.log(result);
    } catch (error) {
      console.log(error);
    }
  };

  const measurement = async () => {
    try {
      const result = await getMeasurement();
      console.log(result);
    } catch (error) {
      console.log(error);
    }
  };

  return (
    <View style={styles.container}>
      <Button
        title="requestHealthKitPermissions"
        onPress={requestPermissions}
      />
      <Button title="measurement" onPress={measurement} />
      <Button title="heartRate" onPress={heartRate} />
      <Button title="stepsCount" onPress={stepsCount} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    gap: 24,
  },
});
