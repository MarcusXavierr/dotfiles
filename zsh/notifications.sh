# Notification system for personal scripts
# Supports desktop, sound, and terminal notifications with flexible usage patterns

# Check for available notification tools
NOTIFY_DESKTOP_AVAILABLE=false
NOTIFY_SOUND_PULSEAUDIO=false
NOTIFY_SOUND_ALSA=false

# Tool detection
if command -v notify-send >/dev/null 2>&1; then
    NOTIFY_DESKTOP_AVAILABLE=true
fi

if command -v paplay >/dev/null 2>&1; then
    NOTIFY_SOUND_PULSEAUDIO=true
fi

if command -v aplay >/dev/null 2>&1; then
    NOTIFY_SOUND_ALSA=true
fi

# Configuration defaults
NOTIFY_DEFAULT_TYPE="${NOTIFY_DEFAULT_TYPE:-all}"
NOTIFY_DURATION="${NOTIFY_DURATION:-2}"
NOTIFY_URGENCY="${NOTIFY_URGENCY:-normal}"
NOTIFY_SOUND_FILE="${NOTIFY_SOUND_FILE:-}"

# Main notification function
# Usage: notify "message" [type] [sound_file] [options]
function notify() {
    local message="$1"
    local type="${2:-$NOTIFY_DEFAULT_TYPE}"
    local sound_file="${3:-$NOTIFY_SOUND_FILE}"

    # Parameter validation
    if [ -z "$message" ]; then
        echo "Usage: notify \"message\" [type] [sound_file] [options]"
        echo "  message: Required text to display"
        echo "  type: desktop, sound, terminal, all (default: $NOTIFY_DEFAULT_TYPE)"
        echo "  sound_file: Optional path to custom audio file"
        echo "  options: Additional options (urgency=critical, style=dragon, etc.)"
        return 1
    fi

    # Parse options for advanced usage
    local urgency="$NOTIFY_URGENCY"
    local cowsay_style="dragon"

    # Parse additional options from remaining arguments
    while [ $# -gt 3 ]; do
        case "$4" in
            urgency=*)
                urgency="${4#urgency=}"
                ;;
            style=*)
                cowsay_style="${4#style=}"
                ;;
            duration=*)
                NOTIFY_DURATION="${4#duration=}"
                ;;
        esac
        shift
    done

    # Dispatch to appropriate notification functions
    case "$type" in
        "desktop"|"d")
            notify_desktop "$message" "$urgency"
            ;;
        "sound"|"s")
            notify_sound "$sound_file"
            ;;
        "terminal"|"t")
            notify_terminal "$message" "$cowsay_style"
            ;;
        "all"|"a"|"")
            notify_desktop "$message" "$urgency"
            notify_sound "$sound_file"
            notify_terminal "$message" "$cowsay_style"
            ;;
        *)
            echo "Error: Unknown notification type '$type'"
            echo "Valid types: desktop, sound, terminal, all"
            return 1
            ;;
    esac
}

# Desktop notification function
function notify_desktop() {
    local message="$1"
    local urgency="${2:-$NOTIFY_URGENCY}"

    if [ "$NOTIFY_DESKTOP_AVAILABLE" = true ]; then
        # Use notify-send with configurable urgency
        notify-send -u "$urgency" -i dialog-information "Notification" "$message" 2>/dev/null || \
        notify-send "Notification" "$message" 2>/dev/null
    else
        # Fallback to terminal if desktop notifications not available
        echo "Desktop notifications not available (install libnotify)"
        notify_terminal "$message" "default"
    fi
}

# Sound notification function with fallback chain
function notify_sound() {
    local sound_file="${1:-}"

    if [ -n "$sound_file" ] && [ -f "$sound_file" ]; then
        # Try custom sound file first
        if [ "$NOTIFY_SOUND_PULSEAUDIO" = true ]; then
            paplay "$sound_file" 2>/dev/null &
        elif [ "$NOTIFY_SOUND_ALSA" = true ]; then
            aplay "$sound_file" 2>/dev/null &
        fi
        return 0
    fi

    # Fallback chain: paplay -> aplay -> system bell
    if [ "$NOTIFY_SOUND_PULSEAUDIO" = true ]; then
        # Try system sounds first (varies by distribution)
        local system_sounds=(
            "/usr/share/sounds/freedesktop/stereo/complete.oga"
            "/usr/share/sounds/alsa/Front_Left.wav"
            "/usr/share/sounds/alsa/Front_Right.wav"
        )

        for sound in "${system_sounds[@]}"; do
            if [ -f "$sound" ]; then
                paplay "$sound" 2>/dev/null &
                return 0
            fi
        done

        # Generate a simple beep if no system sounds found
        paplay </dev/null 2>/dev/null &
    elif [ "$NOTIFY_SOUND_ALSA" = true ]; then
        # ALSA fallback
        aplay </dev/null 2>/dev/null &
    else
        # Final fallback: system bell
        echo -ne '\a' 2>/dev/null
    fi
}

# Terminal notification function extending existing _say() pattern
function notify_terminal() {
    local message="$1"
    local cowsay_style="${2:-dragon}"

    # Check if cowsay and lolcat are available (from existing _say function)
    if command -v cowsay >/dev/null 2>&1 && command -v lolcat >/dev/null 2>&1; then
        clear
        echo -e "\033[1;32m✓ Notification:\033[0m" | lolcat
        cowsay -f "$cowsay_style" "$message" | lolcat
        sleep "$NOTIFY_DURATION"
        clear
    else
        # Fallback if cowsay/lolcat not available
        echo -e "\033[1;32m✓ Notification:\033[0m $message"
        sleep "$NOTIFY_DURATION"
    fi
}

# Configuration function for user preferences
function notify_config() {
    local setting="$1"
    local value="$2"

    case "$setting" in
        "type")
            if [ -n "$value" ]; then
                export NOTIFY_DEFAULT_TYPE="$value"
                echo "Default notification type set to: $value"
            else
                echo "Current default type: $NOTIFY_DEFAULT_TYPE"
            fi
            ;;
        "duration")
            if [ -n "$value" ] && [[ "$value" =~ ^[0-9]+$ ]]; then
                export NOTIFY_DURATION="$value"
                echo "Notification duration set to: ${value}s"
            else
                echo "Current duration: ${NOTIFY_DURATION}s"
                echo "Usage: notify_config duration <seconds>"
            fi
            ;;
        "urgency")
            if [ -n "$value" ]; then
                case "$value" in
                    "low"|"normal"|"critical")
                        export NOTIFY_URGENCY="$value"
                        echo "Desktop notification urgency set to: $value"
                        ;;
                    *)
                        echo "Invalid urgency. Use: low, normal, critical"
                        ;;
                esac
            else
                echo "Current urgency: $NOTIFY_URGENCY"
            fi
            ;;
        "status")
            echo "Notification System Status:"
            echo "  Desktop notifications: $([ "$NOTIFY_DESKTOP_AVAILABLE" = true ] && echo "Available (notify-send)" || echo "Not available")"
            echo "  Sound (PulseAudio): $([ "$NOTIFY_SOUND_PULSEAUDIO" = true ] && echo "Available (paplay)" || echo "Not available")"
            echo "  Sound (ALSA): $([ "$NOTIFY_SOUND_ALSA" = true ] && echo "Available (aplay)" || echo "Not available")"
            echo "  Default type: $NOTIFY_DEFAULT_TYPE"
            echo "  Duration: ${NOTIFY_DURATION}s"
            echo "  Urgency: $NOTIFY_URGENCY"
            ;;
        *)
            echo "Usage: notify_config <setting> [value]"
            echo "Settings: type, duration, urgency, status"
            echo "Examples:"
            echo "  notify_config type desktop"
            echo "  notify_config duration 5"
            echo "  notify_config urgency critical"
            echo "  notify_config status"
            ;;
    esac
}

# Helper function to create notification templates
function notify_template() {
    local template_name="$1"

    case "$template_name" in
        "build")
            notify "Build completed successfully!" "all" "" "style=eyes"
            ;;
        "deploy")
            notify "Deployment finished!" "all" "" "style=dragon" "urgency=critical"
            ;;
        "test")
            notify "Tests completed!" "all" "" "style=default"
            ;;
        "backup")
            notify "Backup completed successfully!" "all" "" "style=elephant"
            ;;
        "error")
            notify "Error occurred!" "all" "" "style=bud-frogs" "urgency=critical"
            ;;
        *)
            echo "Available templates: build, deploy, test, backup, error"
            echo "Usage: notify_template <template_name>"
            ;;
    esac
}

# Integration function to enhance existing _say function
function notify_with_say() {
    local message="$1"
    local type="${2:-all}"
    local sound_file="${3:-}"

    # Use existing _say function first (from workscripts.sh)
    if declare -f _say >/dev/null 2>&1; then
        _say "$message"
    fi

    # Then add additional notifications
    notify "$message" "$type" "$sound_file"
}

# Batch notification function for multiple messages
function notify_batch() {
    local messages=("$@")

    if [ ${#messages[@]} -eq 0 ]; then
        echo "Usage: notify_batch \"message1\" \"message2\" ..."
        return 1
    fi

    for message in "${messages[@]}"; do
        notify "$message" "terminal" ""
        sleep 1
    done
}

# Auto-setup function to check dependencies
function notify_setup() {
    echo "Checking notification dependencies..."

    local missing_deps=()

    if ! command -v notify-send >/dev/null 2>&1; then
        missing_deps+=("libnotify-bin (for desktop notifications)")
    fi

    if ! command -v paplay >/dev/null 2>&1 && ! command -v aplay >/dev/null 2>&1; then
        missing_deps+=("pulseaudio-utils or alsa-utils (for sound notifications)")
    fi

    if ! command -v cowsay >/dev/null 2>&1; then
        missing_deps+=("cowsay (for terminal notifications)")
    fi

    if ! command -v lolcat >/dev/null 2>&1; then
        missing_deps+=("lolcat (for colored terminal output)")
    fi

    if [ ${#missing_deps[@]} -eq 0 ]; then
        echo "✓ All dependencies are installed!"
        notify_config status
    else
        echo "Missing dependencies:"
        for dep in "${missing_deps[@]}"; do
            echo "  - $dep"
        done
        echo ""
        echo "Install with:"
        echo "  sudo apt install libnotify-bin pulseaudio-utils cowsay lolcat"
        echo "  # or"
        echo "  sudo apt install libnotify-bin alsa-utils cowsay lolcat"
    fi
}