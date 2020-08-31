import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:turorientering/locator.dart';
import 'package:turorientering/models/user.dart';
import 'package:turorientering/services/firestore_service.dart';


class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();
  String errorMessage;

  User _currentUser;
  User get currentUser => _currentUser;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _populateCurrentUser(authResult.user);
      return authResult.user != null;
    } catch (e) {
      switch (e.code) {
        case "ERROR_NETWORK_REQUEST_FAILED":
          errorMessage = "Nettverksproblemer, venligst undersøk dine nettverksinstillinger.";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Ugyldig epostadresse.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Feil passord.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "Bruker med denne epostadressen eksisterer ikke.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "Bruker med denne epostadressen har blitt deaktivert.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "For mange forsøk. Venligst prøv igjen senere.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Innlogging med epost og passord er ikke aktivert.";
          break;
        default:
          errorMessage = "Generell innloggingsfeil. Venligst prøv på nytt.";
      }
      return errorMessage;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
    @required String mobile,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create a new user profile on firestore
      _currentUser = User(
        id: authResult.user.uid,
        email: email,
        fullName: fullName,
        phone: mobile,
      );

      await _firestoreService.createUser(_currentUser);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    await _populateCurrentUser(user);
    return user != null;
  }

  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }
}