.PHONY: help setup install-deps web android android-emulator android-kill linux clean new-project fix-gradle fix-androidx

# Environment Variables
JAVA_HOME ?= /usr/lib/jvm/java-17-openjdk
ANDROID_SDK_ROOT ?= /home/dan13615/Android/Sdk
ANDROID_HOME ?= /home/dan13615/Android/Sdk
CHROME_EXECUTABLE ?= /var/lib/flatpak/exports/bin/com.google.Chrome
AVD_NAME ?= flutter_device
PROJECT ?= my_app
PORT ?= 8081

# Export for use in recipes
export JAVA_HOME
export ANDROID_SDK_ROOT
export ANDROID_HOME
export CHROME_EXECUTABLE
export PATH := $(JAVA_HOME)/bin:$(PATH)

help:
	@echo "╔════════════════════════════════════════════════════════════════╗"
	@echo "║         Flutter Multiplatform Development Makefile             ║"
	@echo "╚════════════════════════════════════════════════════════════════╝"
	@echo ""
	@echo "Setup & Installation:"
	@echo "  make setup              - Configure environment variables"
	@echo "  make install-deps       - Install/verify all dependencies"
	@echo ""
	@echo "Development (Run in project directory):"
	@echo "  make web                - Run on Chrome (localhost:8081)"
	@echo "  make android            - Run on Android emulator"
	@echo "  make linux              - Run on Linux desktop"
	@echo ""
	@echo "Android Emulator:"
	@echo "  make android-emulator   - Start Android emulator (flutter_device)"
	@echo "  make android-kill       - Stop Android emulator"
	@echo ""
	@echo "Project Management:"
	@echo "  make new-project PROJECT=<name> - Create new Flutter project with auto-fixes"
	@echo "  make fix-gradle         - Update Gradle to 8.13 (run in project dir)"
	@echo "  make fix-androidx       - Add AndroidX support (run in project dir)"
	@echo "  make clean              - Clean current project"
	@echo "  make clean-all          - Clean all projects in workspace"
	@echo ""
	@echo "Debug:"
	@echo "  make doctor             - Run flutter doctor"
	@echo "  make devices            - List available devices"
	@echo ""

# ═══════════════════════════════════════════════════════════════
# SETUP & INSTALLATION
# ═══════════════════════════════════════════════════════════════

setup:
	@echo "✓ Setting up Flutter environment variables..."
	@echo ""
	@echo "JAVA_HOME: $(JAVA_HOME)"
	@echo "ANDROID_SDK_ROOT: $(ANDROID_SDK_ROOT)"
	@echo "ANDROID_HOME: $(ANDROID_HOME)"
	@echo "CHROME_EXECUTABLE: $(CHROME_EXECUTABLE)"
	@echo ""
	@echo "Add to ~/.bashrc for persistence:"
	@echo ""
	@echo "export JAVA_HOME=\"$(JAVA_HOME)\""
	@echo "export ANDROID_SDK_ROOT=\"$(ANDROID_SDK_ROOT)\""
	@echo "export ANDROID_HOME=\"$(ANDROID_HOME)\""
	@echo "export CHROME_EXECUTABLE=\"$(CHROME_EXECUTABLE)\""
	@echo "export PATH=\$$JAVA_HOME/bin:\$$PATH"
	@echo ""

install-deps:
	@echo "Verifying Flutter installation..."
	@flutter --version
	@echo ""
	@echo "Verifying Java..."
	@java -version
	@echo ""
	@echo "Running flutter doctor..."
	@flutter doctor

# ═══════════════════════════════════════════════════════════════
# DEVELOPMENT TARGETS (run in project directory)
# ═══════════════════════════════════════════════════════════════

web:
	@echo "🌐 Running Flutter web on Chrome (http://localhost:$(PORT))..."
	flutter run -d chrome --web-port=$(PORT)

android:
	@echo "📱 Running Flutter on Android emulator..."
	flutter run -d android

linux:
	@echo "🐧 Running Flutter on Linux desktop..."
	flutter run -d linux

# ═══════════════════════════════════════════════════════════════
# ANDROID EMULATOR
# ═══════════════════════════════════════════════════════════════

android-emulator:
	@echo "Starting Android emulator: $(AVD_NAME)..."
	@echo "This takes 2-3 minutes on first launch..."
	$(ANDROID_SDK_ROOT)/emulator/emulator -avd $(AVD_NAME) &
	@echo "✓ Emulator starting (PID: $!)"
	@echo "To verify it's running: make devices"

android-kill:
	@echo "Stopping Android emulator..."
	@pkill -f "emulator-5554" || echo "No emulator process found"
	@adb kill-server 2>/dev/null || true
	@echo "✓ Emulator stopped"

# ═══════════════════════════════════════════════════════════════
# PROJECT MANAGEMENT
# ═══════════════════════════════════════════════════════════════

new-project:
	@if [ -z "$(PROJECT)" ]; then \
		echo "❌ Error: PROJECT name not specified"; \
		echo "Usage: make new-project PROJECT=my_app"; \
		exit 1; \
	fi
	@echo "📦 Creating new Flutter project: $(PROJECT)..."
	@mkdir -p $(PROJECT)
	@cd $(PROJECT) && flutter create . --platforms android,web,linux
	@echo "✓ Project created"
	@echo ""
	@echo "Applying automatic fixes..."
	@$(MAKE) -C $(PROJECT) fix-gradle fix-androidx
	@echo ""
	@echo "✅ Project ready!"
	@echo "Next steps:"
	@echo "  cd $(PROJECT)"
	@echo "  make web              # Test on web"
	@echo "  make android          # Test on Android (emulator must be running)"

fix-gradle:
	@if [ ! -f "android/gradle/wrapper/gradle-wrapper.properties" ]; then \
		echo "❌ Error: Not in a Flutter project directory"; \
		exit 1; \
	fi
	@echo "📝 Updating Gradle to 8.13..."
	@sed -i 's|gradle-.*-all.zip|gradle-8.13-all.zip|' android/gradle/wrapper/gradle-wrapper.properties
	@echo "✓ Gradle updated"

fix-androidx:
	@if [ ! -f "android/gradle.properties" ]; then \
		echo "❌ Error: Not in a Flutter project directory"; \
		exit 1; \
	fi
	@echo "📝 Configuring AndroidX support..."
	@if grep -q "android.useAndroidX" android/gradle.properties; then \
		echo "  ✓ android.useAndroidX already set"; \
	else \
		echo "android.useAndroidX=true" >> android/gradle.properties; \
		echo "  ✓ Added android.useAndroidX=true"; \
	fi
	@if grep -q "org.gradle.java.home" android/gradle.properties; then \
		echo "  ✓ org.gradle.java.home already set"; \
	else \
		echo "org.gradle.java.home=$(JAVA_HOME)" >> android/gradle.properties; \
		echo "  ✓ Added org.gradle.java.home"; \
	fi

clean:
	@echo "🧹 Cleaning current project..."
	flutter clean
	@echo "✓ Project cleaned"

clean-all:
	@echo "🧹 Cleaning all projects..."
	@for dir in */; do \
		if [ -f "$$dir/pubspec.yaml" ]; then \
			echo "  Cleaning $$dir"; \
			cd "$$dir" && flutter clean && cd ..; \
		fi; \
	done
	@echo "✓ All projects cleaned"

# ═══════════════════════════════════════════════════════════════
# DIAGNOSTICS
# ═══════════════════════════════════════════════════════════════

doctor:
	@echo "🏥 Running Flutter doctor..."
	flutter doctor -v

devices:
	@echo "📱 Available devices..."
	flutter devices
