import { Stack } from 'expo-router';

// Stack for the Schedule tab. Pushing screens here keeps the bottom tabs visible.
export default function ScheduleStackLayout() {
  return (
    <Stack screenOptions={{ headerShown: true }}>
      <Stack.Screen name="index" options={{ title: 'Schedule' }} />
      <Stack.Screen name="details" options={{ title: 'Details' }} />
      // fullScreenModal or modal
      <Stack.Screen name="modal" options={{ presentation: 'modal', title: 'Modal' }} />
    </Stack>
  );
}

