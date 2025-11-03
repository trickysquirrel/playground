import { IconSymbol } from '@/components/ui/icon-symbol';
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
        <View style={styles.headerLeftGroup}>
          <Pressable
            style={[styles.iconButton, styles.headerButton]}
            accessibilityRole="button"
            accessibilityLabel="Go to Map tab"
            onPress={() => router.push('/explore')}
          >
            <IconSymbol name="map.fill" size={22} color="#0a84ff" />
          </Pressable>
          <Pressable
            style={styles.headerButton}
            accessibilityRole="button"
            accessibilityLabel="Open modal"
            onPress={() => router.push('/(tabs)/(schedule)/modal')}
          >
            <IconSymbol name="info.circle" size={22} color="#0a84ff" />
          </Pressable>
        </View>
      ),
      headerRight: () => (
        <Pressable
          style={[styles.iconButton, styles.headerButton]}
          accessibilityRole="button"
          accessibilityLabel="Open schedule profile"
          onPress={() => router.push('/(tabs)/(schedule)/profile')}
        >
          <IconSymbol name="person.crop.circle" size={22} color="#0a84ff" />
        </Pressable>
      )
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
  headerLeftGroup: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingLeft: 8,
  },
  iconButton: {
    paddingHorizontal: 8,
    paddingVertical: 6,
    marginRight: 4,
  },
  headerButtonText: {
    color: '#0a84ff',
    fontWeight: '600',
  },
});
