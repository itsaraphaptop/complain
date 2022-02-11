import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CompainFirebaseUser {
  CompainFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

CompainFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CompainFirebaseUser> compainFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<CompainFirebaseUser>(
        (user) => currentUser = CompainFirebaseUser(user));
