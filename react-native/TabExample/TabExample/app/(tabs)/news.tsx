
import { StyleSheet, Text, View } from 'react-native';


export default function NewsScreen() {
  return (
    <View style={styles.container}>
      <Text style={styles.text}>News screen</Text>
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