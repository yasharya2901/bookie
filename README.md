# bookie

The app that connects you with the ones that matches your taste in books.

## Getting Started

1. Clone the repository
    ```bash
    git clone https://github.com/yasharya2901/bookie.git
    ```

2. Create a copy of `.env.example` and rename it to `.env`
    ```bash
    cp .env.example .env
    ```
    Update the environment variables in `.env` file.

3. Update the dependencies
    ```bash
    flutter pub get
    ```

4. Run the app
    ```bash
    flutter run --dart-define=APPWRITE_ENDPOINT=<YOUR_ENDPOINT> --dart-define=APPWRITE_PROJECT_ID=<YOUR_PROJECT_ID>
    ```

5. (Optional) Change `launch.json` in `.vscode` folder to set the environment variables for debugging.
    ```json
    {
        "configurations": [
            {
                "name": "bookie",
                "request": "launch",
                "type": "dart",
                "toolArgs": ["--dart-define-from-file=.env"]
            },
            {
                "name": "bookie (profile mode)",
                "request": "launch",
                "type": "dart",
                "flutterMode": "profile",
                "toolArgs": ["--dart-define-from-file=.env"]
            },
            {
                "name": "bookie (release mode)",
                "request": "launch",
                "type": "dart",
                "flutterMode": "release",
                "toolArgs": ["--dart-define-from-file=.env"]
            }
        ]
    }
    ```

## Backend
Link to the backend repository: [bookie-backend-go](https://github.com/yasharya2901/bookie-backend-go)

## Known Issues

### Windows Build
The package [`geolocator`](https://pub.dev/packages/geolocator) uses [`Microsoft.Windows.CppWinRT`](https://www.nuget.org/packages/Microsoft.Windows.CppWinRT/) package to access the Windows Runtime APIs. If you face any error while building the app for Windows, you can install the [Nuget](https://www.nuget.org/downloads) package manager to install the required package. And, paste it under `build/windows/x64/packages` folder. Make sure to comment the line in the particular CMake file that throws any error related to `Microsoft.Windows.CppWinRT` package.