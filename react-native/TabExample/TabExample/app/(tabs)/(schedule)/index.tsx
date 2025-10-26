import { useNavigation } from '@react-navigation/native';
import { router } from 'expo-router';
import { useLayoutEffect } from 'react';
import { Pressable, StyleSheet, Text, View } from 'react-native';

export default function ScheduleScreen() {
  const navigation = useNavigation();

  // Show a header for this tab and add a right-side button that routes to the nested details screen
  useLayoutEffect(() => {
    navigation.setOptions({
      headerShown: true,
      headerLeft: () => (
        <Pressable
          style={styles.headerButton}
          accessibilityRole="button"
          accessibilityLabel="Open details"
          onPress={() => router.push('/(tabs)/(schedule)/modal')}
        >
          <Text style={styles.headerButtonText}>Modal</Text>
        </Pressable>
      ),
      headerRight: () => (
        <Pressable
          style={styles.headerButton}
          accessibilityRole="button"
          accessibilityLabel="Open details"
          onPress={() => router.push('/(tabs)/(schedule)/profile')}
        >
          <Text style={styles.headerButtonText}>Profile</Text>
        </Pressable>
      ),
    });
  }, [navigation]);

  return (
    <View style={styles.container}>
      <Text style={styles.text}>Schedule screen</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#25292e',
    alignItems: 'center',
    justifyContent: 'center',
  },
  text: {
    color: '#fff',
  },
  headerButton: {
    paddingHorizontal: 12,
    paddingVertical: 6,
    marginRight: 8,
  },
  headerButtonText: {
    color: '#0a84ff',
    fontWeight: '600',
  },
});

