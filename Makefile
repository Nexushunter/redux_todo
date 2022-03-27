.PHONY: generate ci build-android build-ios build-linux build-mac build-web build-windows

generate:
	flutter pub run build_runner build --delete-conflicting-outputs

ci:
	flutter test --coverage

build-android:
	flutter build apk
	flutter build appbundle

build-ios:
	flutter build ios --release --no-codesign

build-mac:
	flutter config --enable-macos-desktop
	flutter build macos

build-windows:
	flutter config --enable-windows-desktop
	flutter build windows

build-linux:
	flutter build linux

build-web:
	flutter build web
	## TODO: Host on the nexushunterdev.github.io/redux_todo
