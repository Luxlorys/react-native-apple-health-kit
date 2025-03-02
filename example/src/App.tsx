import { View, StyleSheet, Button } from 'react-native';
import { requestHealthKitPermissions } from '@gromozeqa/react-native-apple-health-kit';

export default function App() {
  const request = async () => {
    try {
      const res = await requestHealthKitPermissions();
      console.log(res);
    } catch (error) {
      console.log(error);
    }
  };
  return (
    <View style={styles.container}>
      <Button title="requestHealthKitPermissions" onPress={request} />
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
