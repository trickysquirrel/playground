import { Link } from 'expo-router';
import { StyleSheet, Text, View } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { useLayoutEffect } from 'react';

export default function DetailsScreen() {
  const navigation = useNavigation();

  // Set the header title for this screen when it's mounted
  useLayoutEffect(() => {
    navigation.setOptions({ title: 'Details' });
  }, [navigation]);

  return (
    <View style={styles.container}>
      <Text style={styles.text}>Details screen</Text>
      <Link href="/about" style={styles.button}>
        Go to About screen
      </Link>
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
  button: {
    fontSize: 20,
    textDecorationLine: 'underline',
    color: '#fff',
  },
});
