import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_list/services/auth.dart';

import 'auth_test.mocks.dart';

@GenerateMocks([
  AuthCredential,
  Auth,
  AuthProviderManager,
  FirebaseAuth,
  GoogleSignInAccount,
  GoogleSignInAuthentication,
  GoogleSignIn,
  UserCredential,
  User
])
void main() {
  group('Auth', () {
    final MockFirebaseAuth firebaseAuth = MockFirebaseAuth();
    final MockGoogleSignIn googleSignIn = MockGoogleSignIn();

    final MockAuthProviderManager authProviderManager =
        MockAuthProviderManager();

    final MockUser user = MockUser();
    final MockUserCredential userCredential = MockUserCredential();

    final MockGoogleSignInAccount googleSignInAccount =
        MockGoogleSignInAccount();
    final MockAuthCredential authCredential = MockAuthCredential();
    final MockGoogleSignInAuthentication googleSignInAuthentication =
        MockGoogleSignInAuthentication();

    final Auth auth = Auth(
      firebaseAuth: firebaseAuth,
      googleSignIn: googleSignIn,
      authProviderManager: authProviderManager,
    );

    test('signInWithGoogle returns a user', () async {
      when(googleSignIn.signIn()).thenAnswer((_) async =>
          Future<MockGoogleSignInAccount>.value(googleSignInAccount));

      when(googleSignInAccount.authentication).thenAnswer((_) async =>
          Future<MockGoogleSignInAuthentication>.value(
              googleSignInAuthentication));

      when(authProviderManager
              .getGoogleAuthCredential(googleSignInAuthentication))
          .thenAnswer((_) => authCredential);

      when(firebaseAuth.signInWithCredential(
        authCredential,
      )).thenAnswer(
          (_) async => Future<MockUserCredential>.value(userCredential));

      when(userCredential.user).thenAnswer((_) => user);

      expect(await auth.signInWithGoogle(), user);

      verify(googleSignIn.signIn()).called(1);
      verify(googleSignInAccount.authentication).called(1);
      verify(firebaseAuth.signInWithCredential(
        authCredential,
      )).called(1);
    });
  });
}
