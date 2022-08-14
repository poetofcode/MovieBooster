# Run gradle task & then copy dir

# Step 1: assemble
./gradlew :kmmshare:assembleXCFramework

# Step 2: Clean dest
rm -rf ../moviebooster-ios/kmmshared.xcframework

# Spep 2: copy
cp -r ./kmmshared/build/XCFrameworks/debug/kmmshared.xcframework ../moviebooster-ios/