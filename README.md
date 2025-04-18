﻿# Velp Lite ReadMe
A Flutter mobile app simulating pet care features—authentication, pet management, appointment booking, and vet chat—built with MVVM, Riverpod, and a focus on clean, responsive design.

## Table of Contents

- [Features](#features)

- [Screenshots](#screenshots)

- [Installation](#installation)

- [Clone the Repository](#clone-the-repository)

- [Configuration](#configuration)

- [Build and Run](#build-and-run)

- [Architecture](#architecture)

- [Contributing](#contributing)

## Features
## Features

Velp Lite App simulates core pet care functionalities using Flutter, MVVM architecture, and Riverpod for state management. Below are the key features, designed with clean code, separation of concerns, and a responsive Material Design UI:

- **Authentication**
    - Mock login system with form validation (email/password).
    - User state managed via Riverpod’s `StateNotifierProvider`.
    - Error handling for invalid credentials with user-friendly feedback.

- **Pet Management**
    - Add, view, and delete pets with details (name, breed, species, etc.).
    - Local SQLite storage via `PetRepository` for persistent data.
    - Responsive pet list (`HomeScreen`) and detailed view (`PetDetailsScreen`) with Material components.

- **Appointment Booking**
    - Schedule appointments with vets, selecting pets and dates.
    - Form validation and async loading states (e.g., `CircularProgressIndicator`).
    - Appointment list with status indicators (pending, done, cancelled), stored locally in SQLite.

- **Chat with Vets**
    - Simulated real-time chat with vets using mock replies.
    - Message persistence in SQLite via `ChatRepository`.

- **State Management**
    - Idiomatic Riverpod usage: `Provider` for static data (e.g., mock vets), `StateNotifierProvider` for dynamic state (e.g., pets, appointments).
    - Reactive UI updates with `ref.watch` and `ref.read`.

- **Technical Highlights**
    - Full null safety for robust code.
    - Clean MVVM structure: Models (data), Repositories (data access), ViewModels (logic), Views (UI).
    - Error handling (e.g., retry buttons) and async loading across features.
    - Responsive layouts with Material Design components (e.g., `AppScaffold`, `AppListview`).

### Screenshots

Here are some visuals of the mobile app:

<div>
  <table>
    <tr>
      <td><img src="screenshots/login.jpg" alt="Login Screen" width="200"></td>
      <td><img src="screenshots/empty_home.jpg" alt="Empty Home Screen" width="200"></td>
      <td><img src="screenshots/home.jpg" alt="Home Screen" width="200"></td>
      <td><img src="screenshots/sidebar.jpg" alt="Sidebar" width="200"></td>
    </tr>
    <tr>
      <td><img src="screenshots/pet_details.jpg" alt="Pet Details Screen" width="200"></td>
      <td><img src="screenshots/add_pet1.jpg" alt="Add Pet Screen(1)" width="200"></td>
      <td><img src="screenshots/add_pet2.jpg" alt="Add Pet Screen(2)" width="200"></td>
      <td><img src="screenshots/delete_pet.jpg" alt="Delete Pet" width="200"></td>
    </tr>
    <tr>
      <td><img src="screenshots/empty_chat.jpg" alt="Empty Chat Screen" width="200"></td>
      <td><img src="screenshots/chat.jpg" alt="Chat Screen" width="200"></td>
      <td><img src="screenshots/empty_conversation.jpg" alt="Empty Conversation Screen" width="200"></td>
      <td><img src="screenshots/conversation.jpg" alt="Conversation Screen" width="200"></td>
    </tr>
    <tr>
      <td><img src="screenshots/empty_appointments.jpg" alt="Empty Appointments Screen" width="200"></td>
      <td><img src="screenshots/appointments.jpg" alt="Appointments Screen" width="200"></td>
      <td><img src="screenshots/add_appointment_dropdown.jpg" alt="Add Appointment Dropdown" width="200"></td>
      <td><img src="screenshots/add_appointment.jpg" alt="Add Appointment Screen" width="200"></td>
    </tr>
  </table>
</div>

## Installation

Follow these steps to install and run this project on your system.

### Clone the Repository

1. Open your terminal or command prompt.

2. Use the following command to clone the ProjectName repository:
```
git clone https://github.com/MariemAbdi/Velp-Lite.git
```
### Configuration

1. Change your working directory to the cloned repository:
```
cd Velp-Lite
```
2. Install the required dependencies using:
```
flutter pub get
```
### Build and Run

1. Connect your device or start an emulator.

2. To build and run the project, use the following command:
```
flutter run
```
This will build the project and install it on your connected device or emulator.

## Architecture
- **MVVM**: Model (data), View (UI), ViewModel (logic).
- **Riverpod**: State management with Providers and StateNotifiers.
- **Local Storage**: SQLite via `DatabaseService`.

## Contributing
Feel free to submit issues or PRs!