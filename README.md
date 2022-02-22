# Nowly

A Flutter based project.

## Project Description

Nowly is the user platform for the NOWLY Software. This app allows users to create profiles, manage accounts, connect with personal trainers for Virtual sessions as well as In Person training sessions. Nowly App is designed to be easy to navigate, user friendly and provide th e convienince of training with a professional a seemless experience.

### File structure

```dart
../lib
- Bindings/
- Configs/
- Controllers/
- Models/
- Routes/
- Screens
- Services/
- Utils/
- Widgets/
```

---

## Controllers

### _- Agora controller_

`../lib/Controllers/Agora/agora_controller.dart`

Nowly uses **agora_rtc_engine** to control all virtual sessions. Specifically utilizing the ONE on ONE video call functionality.

<details>
<summary> Core Agora Functions: </summary>

- `startSession(BuildContext context, SessionModel session)`: This function initiates a virtual session. It awaits result from `initTrainerSearch()`, if true `updateSession()` is called.

- `initTrainerSearch(BuildContext context, SessionModel session)`: initiates the search for a trainer available via Session Services (`findVirtualTrainer()`).

- `updateSession()`: creates a stream of the current session.

- -`initAgora()`: initiates the agora engine. awaits generated token for the video call via Agora Services (`generateAgoraToken()`).

- `kill()`: terminates video call, navigates to _SessionCompleteScreen()_.

- `startTimer()`: starts the session timer.

- `checkSessionTimer()`: keeps track of session time. Kills the session when timer hits 0:00.

- `trainerJoined()`: called when trainer joins the video call. Calls `startTimer()`.

- `isAccepted()`: Called when trainer accepts the session call.

- `cancel()`: cancels the active search for a trainer.

- `toggleAudio()`: mutes audio.

- `toggleVideo()`: mutes video.

</details>

### _- Auth controller_

`../lib/Controllers/Auth/auth_controller.dart`

Nowly utilized _Firebase Auth_ for all authentication services.

<details>
<summary> Core Auth Functions:</summary>

- `createAccount()` : creates account in firebase auth.

- `login()`: logs user in via firebase.

- `signOut()`: signs user out of nowly account.

- `deleteAccount()`: delete account in firebase.

- `sendResetPasswordLink()`: send reset password link to user.

- `emailOption()`: _BottomSheet_ that allows user to sign up or log in using their email address and password.

- `openPDF()`: opens Terms of Service and Privacy Policy.

</details>

#### _- Maps_

`../lib/Controllers/Maps/maps_navigator_controller.dart`

Nowly utilized the _GoogleMaps API_

- Map Naviagator Controller
  <details>
  <summary> Core Map Navigator functions </summary>

      - `openNavigator()`: opens device navigation to route user to session location

  </details>

`../lib/Controllers/Maps/map_controller.dart`

- Map Controller
  <details>
  <summary>
    Core Map functions
  </summary>
      - `onMapCreate(GoogleMapController controller)` : called when map is created in map view.

      - `getMyLocation()`: get location permissions, sets users location in Firebase.

      - `focusMe()`: animates maps to users location.

      - `changeTravelMode()` : when trainer is selceted, toggle mode between **_Walking and Driving_** depending on users method of travel.

      - `initiateMyLocation()` : called the set users Locality(city and state) by calling `getCityandState()`.

  </details>

#### _- Messaging_

`../lib/Controllers/Agora/agora_controller.dart`

<details>
<summary>
Core Messaging Functions
</summary>

    - `fetchChat()` : chats loaded when messaging is active.

    - `sendMessage()`: send message to firebase via `FirebaseFurtures().sendMessage()`.

</details>

#### _- Registration/OnBoarding_

`../lib/Controllers/Agora/agora_controller.dart`

<details>

</details>
#### _- Session_

`../lib/Controllers/Agora/agora_controller.dart`

#### _- Stripe_

`../lib/Controllers/Agora/agora_controller.dart`

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
