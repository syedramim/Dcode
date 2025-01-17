# Dcode – A SwiftUI Encryption & Decryption Tool

This project showcases several classical and modern cipher implementations using SwiftUI. It demonstrates how to encrypt and decrypt text using Caesar, Atbash, ROT13, Vigenère, and XOR ciphers.

---

## Table of Contents
1. [Overview](#overview)
2. [Demo](#demo)
3. [Screenshots](#screenshots)
4. [Key Features](#key-features)
5. [Installation](#installation)
6. [Usage](#usage)
7. [Project Structure](#project-structure)

---

## Overview
**Dcode** leverages SwiftUI’s declarative approach to build a clean user interface for exploring various encryption methods. Each cipher is defined in its own function within `CipherViewModel`, and the UI allows users to switch between ciphers, toggle encryption or decryption, and configure parameters like shift values or keys.

---

## Demo

<img src="demofiles/DcodeDemo.gif" height="500">

--- 

## Screenshots

<p float="left">
  <img src="demofiles/CipherView_b.png" height="400">
  <img src="demofiles/CipherView.png" height="400">
  <img src="demofiles/DetailView.png" height="400">
</p>

---

## Key Features
- **Multiple Ciphers**: Caesar, Atbash, ROT13, Vigenère, and XOR.
- **Parameter Configuration**: Easily change shift values or keys through a dedicated parameter view.
- **Modular Architecture**: SwiftUI views are separated into logical components for better maintainability.
- **ObservableObject**: `CipherViewModel` uses `@Published` properties to auto-update the UI.

---

## Installation
1. **Clone or Download** the repository from GitHub.
2. **Open** the project in Xcode (version 14.0 or newer recommended).
3. **Build and Run** the project on a simulator or physical device running iOS 16.0 or later.

---

## Usage
1. **Select a Cipher**: Use the picker at the bottom of the main screen to switch between ciphers.
2. **Enter Text**: Type the text you want to encrypt or decrypt in the text field.
3. **Toggle Mode**: Press the lock icon to switch between encryption and decryption.
4. **Edit Parameters**: Choose “Change Parameters” to adjust shift values or keys. For ciphers that do not require parameters, no input is necessary.

---

## Project Structure
- **Models**  
  - `Cipher`: Holds parameters for a single cipher instance, including type, shift, and key.
  - `CipherType`: Enum listing the available ciphers.
- **ViewModels**  
  - `CipherViewModel`: Manages cipher logic and exposes properties to the views.
- **Views**  
  - `CipherView`: Main screen for user input, output, and cipher selection.
  - `CipherDetailView`: Allows configuration of cipher parameters.
- **Utilities**  
  - `Parameters`: Utility for handling text field inputs for cipher parameters.


