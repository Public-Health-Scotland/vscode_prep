set -euo pipefail

# setup for GitHub SSH using ed25519 WITHOUT creating ~/.ssh/config.
EMAIL=""
KEY_FILE="$HOME/.ssh/id_ed25519"
NON_INTERACTIVE="false"
PASSPHRASE=""
QUIET="false"
FORCE_OVERWRITE="false"

usage() {
  cat <<'EOF'
Usage: setup_github_ssh_min.sh [options]

Options:
  -e, --email <email>       Label for the key (use your GitHub email).
  -k, --key-file <path>     Key path (default: ~/.ssh/id_ed25519).
  -f, --force-overwrite     Overwrite existing key at path.
  -n, --non-interactive     Do not prompt; empty passphrase unless -p used.
  -p, --passphrase <text>   Passphrase for key (use with caution).
  -q, --quiet               Reduce output.
  -h, --help                Show help.

Examples:
  bash setup_github_ssh_min.sh -e "you@example.com"
  bash setup_github_ssh_min.sh -e "you@example.com" -n
EOF
}

log() { [ "$QUIET" = "true" ] || echo -e "$*"; }
err() { echo -e "ERROR: $*" >&2; }

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    -e|--email) EMAIL="$2"; shift 2 ;;
    -k|--key-file) KEY_FILE="$2"; shift 2 ;;
    -f|--force-overwrite) FORCE_OVERWRITE="true"; shift ;;
    -n|--non-interactive) NON_INTERACTIVE="true"; shift ;;
    -p|--passphrase) PASSPHRASE="$2"; shift 2 ;;
    -q|--quiet) QUIET="true"; shift ;;
    -h|--help) usage; exit 0 ;;
    *) err "Unknown option: $1"; usage; exit 1 ;;
  esac
done

need() { command -v "$1" >/dev/null 2>&1 || { err "Required command not found: $1"; exit 1; }; }
need ssh
need ssh-keygen
need ssh-agent
need ssh-add

# Ensure ~/.ssh exists with safe permissions
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# Email/label handling
if [[ -z "$EMAIL" ]]; then
  if [[ "$NON_INTERACTIVE" = "true" ]]; then
    EMAIL="$(whoami)@$(hostname -f 2>/dev/null || hostname)"
    log "No email provided; using label: $EMAIL"
  else
    read -rp "GitHub email (label for key): " EMAIL
    EMAIL="${EMAIL:-$(whoami)@$(hostname -f 2>/dev/null || hostname)}"
  fi
fi

# Generate key if needed
if [[ -f "$KEY_FILE" && "$FORCE_OVERWRITE" != "true" ]]; then
  log "Key exists at $KEY_FILE. Use -f to overwrite, or reuse it."
else
  if [[ -f "$KEY_FILE" && "$FORCE_OVERWRITE" = "true" ]]; then
    rm -f "$KEY_FILE" "$KEY_FILE.pub"
  fi

  log "Generating ed25519 key at $KEY_FILE ..."
  if [[ -n "$PASSPHRASE" ]]; then
    ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_FILE" -N "$PASSPHRASE"
  else
    if [[ "$NON_INTERACTIVE" = "true" ]]; then
      ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_FILE" -N ""
    else
      ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_FILE"
    fi
  fi
fi

# Tighten permissions
chmod 600 "$KEY_FILE"
chmod 644 "$KEY_FILE.pub"

# Start ssh-agent and add key
# shellcheck disable=SC2046
eval "$(ssh-agent -s)" >/dev/null
ssh-add "$KEY_FILE"
log "Key added to ssh-agent."

# Show/copy public key
PUB="$(cat "$KEY_FILE.pub")"
copied="false"
if command -v wl-copy >/dev/null 2>&1; then
  echo -n "$PUB" | wl-copy && copied="true"
elif command -v xclip >/dev/null 2>&1; then
  echo -n "$PUB" | xclip -selection clip && copied="true"
elif command -v clip.exe >/dev/null 2>&1; then
  echo -n "$PUB" | clip.exe && copied="true"
fi

if [[ "$copied" = "true" ]]; then
  log "Public key copied to clipboard."
else
  log "\nYour public key (copy and add to GitHub → Settings → SSH and GPG keys):\n"
  echo "$PUB"
fi

log "\nDone. You can now use SSH with GitHub, e.g.:"
log "  git clone git@github.com:<owner>/<repo>.git"
