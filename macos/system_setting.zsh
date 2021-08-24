#!/usr/bin/env zsh

logger() {
  local variant="${1:-info}"
  local message="${2:-}"

  if [ -z "$message" ]; then
    return
  fi

  case "$variant" in
    info)
      printf "\033[34m%-8s\033[0m %s\n" "info" "$message"
      ;;
    success)
      printf "\033[32m%-8s\033[0m %s\n" "success" "$message"
      ;;
    warning)
      printf "\033[33m%-8s\033[0m %s\n" "warning" "$message"
      ;;
    error)
      printf "\033[31m%-8s\033[0m %s\n" "error" "$message"
      ;;
  esac
}

() {
  logger "info" "Setting macOS system ..."
  
  ## Dock & Menu Bar > Automatically hide and show the Dock (enable)
  logger "info" "✅ [Dock] Automatically hide and show the Dock"
  defaults write com.apple.dock autohide -bool true

  ## Mission Control > Automatically rearrange Spaces based on most recent use (disable)
  logger "info" "✅ [Mission Control] Disable Automatically rearrange Spaces based on most recent use"
  defaults write com.apple.dock mru-spaces -bool false

  ## Keyboard > Text > Correct spelling automatically (disable)
  logger "info" "✅ [Keyboard] Disable correct spelling automatically"
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

  ## Keyboard > Text > Capitalize words automatically (disable)
  logger "info" "✅ [Keyboard] Disable capitalize words automatically"
  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

  ## Keyboard > Text > Add period with double-space (disable)
  logger "info" "✅ [Keyboard] Disable add period with double-space"
  defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

  ## Keyboard > Text > Use smart quotes and dashes (disable)
  logger "info" "✅ [Keyboard] Disable use smart quotes and dashes"
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

  ## Keyboard > Shortcut > Use keyboard navigation to move focus between controls (enable)
  logger "info" "✅ [Keyboard] Use keyboard navigation to move focus between controls"
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

  ## Trackpad > Point & Click > Tab to click (enable)
  logger "info" "✅ [Trackpad] Enable tab to click"
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  # Enable tap at login as well
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

  ## Accessibility > Pointer Control > Trackpad options... (Enable dragging - three finger drag)
  logger "info" "✅ [Trackpad] Enable dragging - three finger drag"
  defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool false
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 0
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 0
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
  defaults -currentHost write .GlobalPreferences com.apple.trackpad.threeFingerHorizSwipeGesture -int 0
  defaults -currentHost write .GlobalPreferences com.apple.trackpad.threeFingerVertSwipeGesture -int 0
  defaults -currentHost write .GlobalPreferences com.apple.trackpad.threeFingerDragGesture -bool true

  logger "info" "Setting finder ..."

  # New Finder windows show (set home)
  logger "info" "✅ [Finder] Set New Finder windows show - Home"
  defaults write com.apple.finder NewWindowTarget -string 'PfHm'
  defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/"

  # Show all filename extensions (enable)
  logger "info" "✅ [Finder] Show all filename extensions"
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Show Path Bar (enable)
  logger "info" "✅ [Finder] Show Path Bar"
  defaults write com.apple.finder ShowPathbar -bool true

  logger "success" "Please restart macOS ..."
}
