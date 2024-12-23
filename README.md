# Currency Converter App

## Overview

This project is a simple currency converter application built using Swift and UIKit. It uses SnapKit for UI layout management and integrates it through Swift Package Manager (SPM).

## Requirements

- **Xcode**: 16.1 or later
- **Swift**: 6.0
- **iOS Deployment Target**: 18.0 or later

## Features

- Currency conversion using a real-time API
- Clean architecture
- Programmatic UI built with SnapKit

## Clone the Repository

To get started, clone the repository from GitHub to your local machine:

```bash
git clone <repository-url>
```

Replace `<repository-url>` with the actual URL of the repository.

## Open the Project

1. Navigate to the project directory:
   ```bash
   cd <project-directory>
   ```
2. Open the `.xcodeproj` file:
   ```bash
   open CurrencyConverter.xcodeproj
   ```

## Install Dependencies

Dependencies are managed using Swift Package Manager (SPM). SnapKit is already configured in the project.

1. Open the project in Xcode.
2. Go to **File > Packages > Reset Package Caches**.
3. Navigate to **File > Packages > Resolve Package Versions** to ensure all dependencies are properly installed.

## Build and Run

1. Select a simulator or a physical device with iOS 18 or later.
2. Build the project by pressing **Command + B** or selecting **Product > Build** from the menu.
3. Run the project by pressing **Command + R** or selecting **Product > Run**.

## Troubleshooting

If you encounter issues:

- Make sure you are using the correct version of Xcode (16.1 or later).
- Ensure your macOS has internet access to fetch dependencies.
- Verify that your iOS simulator or device meets the minimum deployment target (iOS 18).

## License

This project is licensed under the MIT License. See the LICENSE file for details.
