#!/bin/sh
set -e
set -u
set -o pipefail

function on_error {
  echo "$(realpath -mq "${0}"):$1: error: Unexpected failure"
}
trap 'on_error $LINENO' ERR


# This protects against multiple targets copying the same framework dependency at the same time. The solution
# was originally proposed here: https://lists.samba.org/archive/rsync/2008-February/020158.html
RSYNC_PROTECT_TMP_FILES=(--filter "P .*.??????")


variant_for_slice()
{
  case "$1" in
  "CoreModules.xcframework/ios-arm64")
    echo ""
    ;;
  "CoreModules.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "cxxreact.xcframework/ios-arm64")
    echo ""
    ;;
  "cxxreact.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "DoubleConversion.xcframework/ios-arm64")
    echo ""
    ;;
  "DoubleConversion.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "fmt.xcframework/ios-arm64")
    echo ""
    ;;
  "fmt.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "folly.xcframework/ios-arm64")
    echo ""
    ;;
  "folly.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "glog.xcframework/ios-arm64")
    echo ""
    ;;
  "glog.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "jsi.xcframework/ios-arm64")
    echo ""
    ;;
  "jsi.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "jsinspector.xcframework/ios-arm64")
    echo ""
    ;;
  "jsinspector.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "jsireact.xcframework/ios-arm64")
    echo ""
    ;;
  "jsireact.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "libwebp.xcframework/ios-arm64")
    echo ""
    ;;
  "libwebp.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "logger.xcframework/ios-arm64")
    echo ""
    ;;
  "logger.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "Pods_RNSDK.xcframework/ios-arm64")
    echo ""
    ;;
  "Pods_RNSDK.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTAnimation.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTAnimation.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTBlob.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTBlob.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTImage.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTImage.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTLinking.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTLinking.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTNetwork.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTNetwork.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTSettings.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTSettings.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTText.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTText.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTTypeSafety.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTTypeSafety.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RCTVibration.xcframework/ios-arm64")
    echo ""
    ;;
  "RCTVibration.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "React.xcframework/ios-arm64")
    echo ""
    ;;
  "React.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "ReactCommon.xcframework/ios-arm64")
    echo ""
    ;;
  "ReactCommon.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "reactperflogger.xcframework/ios-arm64")
    echo ""
    ;;
  "reactperflogger.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "React_Codegen.xcframework/ios-arm64")
    echo ""
    ;;
  "React_Codegen.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "React_jsc.xcframework/ios-arm64")
    echo ""
    ;;
  "React_jsc.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "React_RCTAppDelegate.xcframework/ios-arm64")
    echo ""
    ;;
  "React_RCTAppDelegate.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNFastImage.xcframework/ios-arm64")
    echo ""
    ;;
  "RNFastImage.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "RNSDK.xcframework/ios-arm64")
    echo ""
    ;;
  "RNSDK.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "SDWebImage.xcframework/ios-arm64")
    echo ""
    ;;
  "SDWebImage.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "SDWebImageWebPCoder.xcframework/ios-arm64")
    echo ""
    ;;
  "SDWebImageWebPCoder.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  "yoga.xcframework/ios-arm64")
    echo ""
    ;;
  "yoga.xcframework/ios-arm64_x86_64-simulator")
    echo "simulator"
    ;;
  esac
}

archs_for_slice()
{
  case "$1" in
  "CoreModules.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "CoreModules.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "cxxreact.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "cxxreact.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "DoubleConversion.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "DoubleConversion.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "fmt.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "fmt.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "folly.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "folly.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "glog.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "glog.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "jsi.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "jsi.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "jsinspector.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "jsinspector.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "jsireact.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "jsireact.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "libwebp.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "libwebp.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "logger.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "logger.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "Pods_RNSDK.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "Pods_RNSDK.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTAnimation.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTAnimation.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTBlob.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTBlob.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTImage.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTImage.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTLinking.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTLinking.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTNetwork.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTNetwork.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTSettings.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTSettings.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTText.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTText.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTTypeSafety.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTTypeSafety.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RCTVibration.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RCTVibration.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "React.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "React.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "ReactCommon.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "ReactCommon.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "reactperflogger.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "reactperflogger.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "React_Codegen.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "React_Codegen.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "React_jsc.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "React_jsc.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "React_RCTAppDelegate.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "React_RCTAppDelegate.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNFastImage.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNFastImage.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "RNSDK.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "RNSDK.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "SDWebImage.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "SDWebImage.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "SDWebImageWebPCoder.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "SDWebImageWebPCoder.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  "yoga.xcframework/ios-arm64")
    echo "arm64"
    ;;
  "yoga.xcframework/ios-arm64_x86_64-simulator")
    echo "arm64 x86_64"
    ;;
  esac
}

copy_dir()
{
  local source="$1"
  local destination="$2"

  # Use filter instead of exclude so missing patterns don't throw errors.
  echo "rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" --links --filter \"- CVS/\" --filter \"- .svn/\" --filter \"- .git/\" --filter \"- .hg/\" \"${source}*\" \"${destination}\""
  rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" --links --filter "- CVS/" --filter "- .svn/" --filter "- .git/" --filter "- .hg/" "${source}"/* "${destination}"
}

SELECT_SLICE_RETVAL=""

select_slice() {
  local xcframework_name="$1"
  xcframework_name="${xcframework_name##*/}"
  local paths=("${@:2}")
  # Locate the correct slice of the .xcframework for the current architectures
  local target_path=""

  # Split archs on space so we can find a slice that has all the needed archs
  local target_archs=$(echo $ARCHS | tr " " "\n")

  local target_variant=""
  if [[ "$PLATFORM_NAME" == *"simulator" ]]; then
    target_variant="simulator"
  fi
  if [[ ! -z ${EFFECTIVE_PLATFORM_NAME+x} && "$EFFECTIVE_PLATFORM_NAME" == *"maccatalyst" ]]; then
    target_variant="maccatalyst"
  fi
  for i in ${!paths[@]}; do
    local matched_all_archs="1"
    local slice_archs="$(archs_for_slice "${xcframework_name}/${paths[$i]}")"
    local slice_variant="$(variant_for_slice "${xcframework_name}/${paths[$i]}")"
    for target_arch in $target_archs; do
      if ! [[ "${slice_variant}" == "$target_variant" ]]; then
        matched_all_archs="0"
        break
      fi

      if ! echo "${slice_archs}" | tr " " "\n" | grep -F -q -x "$target_arch"; then
        matched_all_archs="0"
        break
      fi
    done

    if [[ "$matched_all_archs" == "1" ]]; then
      # Found a matching slice
      echo "Selected xcframework slice ${paths[$i]}"
      SELECT_SLICE_RETVAL=${paths[$i]}
      break
    fi
  done
}

install_xcframework() {
  local basepath="$1"
  local name="$2"
  local package_type="$3"
  local paths=("${@:4}")

  # Locate the correct slice of the .xcframework for the current architectures
  select_slice "${basepath}" "${paths[@]}"
  local target_path="$SELECT_SLICE_RETVAL"
  if [[ -z "$target_path" ]]; then
    echo "warning: [CP] $(basename ${basepath}): Unable to find matching slice in '${paths[@]}' for the current build architectures ($ARCHS) and platform (${EFFECTIVE_PLATFORM_NAME-${PLATFORM_NAME}})."
    return
  fi
  local source="$basepath/$target_path"

  local destination="${PODS_XCFRAMEWORKS_BUILD_DIR}/${name}"

  if [ ! -d "$destination" ]; then
    mkdir -p "$destination"
  fi

  copy_dir "$source/" "$destination"
  echo "Copied $source to $destination"
}

install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/CoreModules.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/cxxreact.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/DoubleConversion.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/fmt.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/folly.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/glog.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/jsi.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/jsinspector.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/jsireact.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/libwebp.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/logger.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/Pods_RNSDK.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/RCTAnimation.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/RCTBlob.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/RCTImage.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/RCTLinking.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/RCTNetwork.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/RCTSettings.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/RCTText.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/RCTTypeSafety.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/RCTVibration.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/React.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/ReactCommon.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/reactperflogger.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/React_Codegen.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/React_jsc.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/React_RCTAppDelegate.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/RNFastImage.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/RNSDK.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/SDWebImage.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/SDWebImageWebPCoder.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"
install_xcframework "${PODS_ROOT}/../../RNSDKExample/ios/SDKOutput/Frameworks/yoga.xcframework" "RNSDK" "framework" "ios-arm64" "ios-arm64_x86_64-simulator"

