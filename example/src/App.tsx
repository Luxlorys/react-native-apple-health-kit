import { View, StyleSheet, Button } from 'react-native';
import { requestHealthKitPermissions } from '@gromozeqa/react-native-apple-health-kit';

export default function App() {
  return (
    <View style={styles.container}>
      <Button
        title="requestHealthKitPermissions"
        onPress={requestHealthKitPermissions}
      />
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
