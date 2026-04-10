#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ln -s "$SCRIPT_DIR/package-init.sh" /usr/local/bin/package-init
ln -s "$SCRIPT_DIR/hooks" /usr/local/bin/hooks
ln -s "$SCRIPT_DIR/configs" /usr/local/bin/configs