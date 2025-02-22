import { View, StyleSheet, Button } from 'react-native';
import {
  getStepsCountForCurrentDay,
  getStepsCountForLast30Days,
  requestHealthKitPermissions,
} from 'react-native-apple-health-kit';

export default function App() {
  const handleGetStepsCountFor30Days = async () => {
    try {
      const steps = await getStepsCountForLast30Days();
      console.log(steps);
    } catch (error) {
      console.log(error);
    }
  };

  const handleGetStepsCountForCurrentDay = async () => {
    try {
      const steps = await getStepsCountForCurrentDay();
      console.log(steps);
    } catch (error) {
      console.log(error);
    }
  };

  const handleRequestPermissions = async () => {
    const result = await requestHealthKitPermissions();
    console.log(result);
  };

  return (
    <View style={styles.container}>
      <Button
        title="getStepsCountForCurrentDay"
        onPress={handleGetStepsCountForCurrentDay}
      />
      <Button
        title="getStepsCountForLast30Days"
        onPress={handleGetStepsCountFor30Days}
      />
      <Button
        title="requestHealthKitPermissions"
        onPress={handleRequestPermissions}
      />
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
