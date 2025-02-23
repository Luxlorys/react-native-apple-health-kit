import { useState } from 'react';
import { View, StyleSheet, Button, ActivityIndicator } from 'react-native';
import {
  getSteps,
  requestHealthKitPermissions,
} from 'react-native-apple-health-kit';

export default function App() {
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const handleGetStepsCountFor30Days = async () => {
    try {
      const steps = await getSteps(30);
      console.log(steps);
    } catch (error) {
      console.log(error);
    }
  };

  const handleRequestPermissions = async () => {
    setIsLoading(true);
    const result = await requestHealthKitPermissions();
    console.log(result);
    setIsLoading(false);
  };

  return (
    <View style={styles.container}>
      {isLoading && <ActivityIndicator size={'large'} color={'#000'} />}
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
