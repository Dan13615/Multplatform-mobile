# Flutter Multiplatform Development Setup

## Quick Start

### 1. One-time Setup
```bash
cd /home/dan13615/delivery/Multplatform-mobile
make setup      # Show environment variables
make install-deps  # Verify all dependencies
```

### 2. Create a New Project
```bash
make new-project PROJECT=my_app
cd my_app
```

### 3. Start Android Emulator (if running for first time)
```bash
make android-emulator
# Wait 2-3 minutes for it to boot
make devices  # Verify it's running
```

### 4. Run Your App
From within your project directory:
```bash
make web        # Chrome on localhost:8081
make android    # Android emulator
make linux      # Linux desktop
```

---

## Available Commands

### Global (from workspace root)
```bash
make help              # Show all commands
make setup             # Show environment configuration
make install-deps      # Verify Flutter, Java, Android SDK
make doctor            # Run flutter doctor -v
make devices           # List available devices
make new-project PROJECT=name  # Create new project with auto-fixes
make clean-all         # Clean all projects
make android-emulator  # Start Android emulator
make android-kill      # Stop Android emulator
```

### Project-Specific (from project directory)
```bash
make web       # Run on Chrome web
make android   # Run on Android emulator
make linux     # Run on Linux desktop
make clean     # Clean project build
make fix-gradle    # Update Gradle to 8.13
make fix-androidx  # Add AndroidX support
```

---

## File Structure
```
/home/dan13615/delivery/Multplatform-mobile/
├── Makefile                 # Main build automation
├── .flutter-config          # Auto-configuration script
├── README.md               # This file
├── lab/                    # Hello World example
├── week4/                  # Flutter project
├── android_test/           # Flutter project
└── my_app/                 # Your new project (created with 'make new-project')
    ├── pubspec.yaml
    ├── lib/
    ├── android/
    │   ├── gradle/wrapper/gradle-wrapper.properties (auto-configured)
    │   └── gradle.properties (auto-configured)
    ├── web/
    └── linux/
```

---

## What's Auto-Configured in Each Project

When you create a new project with `make new-project PROJECT=name`, it automatically:

1. ✅ **Updates Gradle** from default to `8.13-all.zip`
2. ✅ **Sets Java Home** to `/usr/lib/jvm/java-17-openjdk`
3. ✅ **Enables AndroidX** with `android.useAndroidX=true`
4. ✅ **Configures JVM args** for proper memory allocation

---

## Environment Variables (in ~/.bashrc)

These are already configured:
```bash
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
export ANDROID_SDK_ROOT="/home/dan13615/Android/Sdk"
export ANDROID_HOME="/home/dan13615/Android/Sdk"
export CHROME_EXECUTABLE="/var/lib/flatpak/exports/bin/com.google.Chrome"
export PATH=$JAVA_HOME/bin:$PATH
```

---

## Example Workflow

### Create and Test a New Project
```bash
cd /home/dan13615/delivery/Multplatform-mobile

# Create new project
make new-project PROJECT=my_test_app
cd my_test_app

# Test on web
make web
# Opens http://localhost:8081

# Test on Android (emulator must be running)
make android

# Test on Linux desktop
make linux
```

### Using Existing Projects
```bash
cd /home/dan13615/delivery/Multplatform-mobile/android_test
make web      # Run web version
make android  # Run Android version
make clean    # Clean build
```

---

## Troubleshooting

### Emulator Won't Start
```bash
make android-emulator
# Wait 2-3 minutes, then verify:
make devices
```

### Gradle Errors
```bash
cd your-project
make fix-gradle    # Update Gradle version
make fix-androidx  # Add AndroidX support
flutter clean
make android       # Try again
```

### Java Version Issues
The environment already handles this. If issues persist:
```bash
source ~/.bashrc   # Reload environment
echo $JAVA_HOME    # Should show /usr/lib/jvm/java-17-openjdk
```

---

## Manual Project Configuration

If you need to manually configure an existing project:

```bash
cd existing-project

# Update Gradle
sed -i 's|gradle-.*-all.zip|gradle-8.13-all.zip|' android/gradle/wrapper/gradle-wrapper.properties

# Add to android/gradle.properties:
cat >> android/gradle.properties << EOF
android.useAndroidX=true
org.gradle.java.home=/usr/lib/jvm/java-17-openjdk
org.gradle.jvmargs=-Xmx4096m -XX:MaxMetaspaceSize=2G
EOF

flutter clean
flutter run -d android
```

---

## Key Fixes Applied

| Issue                              | Fix                                                                 |
| ---------------------------------- | ------------------------------------------------------------------- |
| "Could not determine java version" | Updated Gradle to 8.13                                              |
| "AndroidX dependencies" error      | Added `android.useAndroidX=true`                                    |
| Gradle permission issues           | Fixed `/usr/lib/flutter/packages/flutter_tools/gradle/` permissions |
| Environment variables not set      | Added to `~/.bashrc`                                                |

---

## Tips

- **Always run `make setup`** if you get environment errors
- **Keep Gradle at 8.13** for AGP 8.x compatibility
- **Android emulator takes 2-3 minutes** on first launch—be patient
- **Use `make web` first** to test your app before trying Android
- **Run `make doctor`** regularly to check dependency status

---

Enjoy Flutter development! 🚀
