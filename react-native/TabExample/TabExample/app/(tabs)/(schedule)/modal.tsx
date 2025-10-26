import { router } from 'expo-router';
import { StyleSheet, Text, View, Pressable } from 'react-native';

export default function ScheduleModal() {
  return (
    <View style={styles.container}>
      <Text style={styles.text}>Schedule Modal</Text>
      <Pressable
        style={styles.button}
        accessibilityRole="button"
        accessibilityLabel="Dismiss modal"
        onPress={() => router.back()}
      >
        <Text style={styles.buttonText}>Dismiss</Text>
      </Pressable>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#25292e',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 24,
  },
  text: {
    color: '#fff',
    marginBottom: 16,
  },
  button: {
    backgroundColor: '#0a84ff',
    paddingHorizontal: 16,
    paddingVertical: 10,
    borderRadius: 8,
  },
  buttonText: {
    color: '#fff',
    fontWeight: '600',
  },
});

