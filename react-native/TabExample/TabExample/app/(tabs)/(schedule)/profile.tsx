import { useNavigation } from '@react-navigation/native';
import { useLayoutEffect } from 'react';
import { StyleSheet, Text, View } from 'react-native';

export default function DetailsScreen() {
  const navigation = useNavigation();

  // Set the header title for this nested screen
  useLayoutEffect(() => {
    navigation.setOptions({ title: 'Profile' });
  }, [navigation]);

  return (
    <View style={styles.container}>
      <Text style={styles.text}>Profile screen (inside Schedule tab)</Text>
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
});

