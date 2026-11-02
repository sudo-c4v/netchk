#!/usr/bin/env bash
# netchk - a small network inspection utility
set -euo pipefail

VERSION="0.1.0"

usage() {
    cat <<EOF
netchk $VERSION

Usage: netchk.sh <command>

Commands:
  ifaces    List network interfaces and their addresses
  help      Show this message
EOF
}

cmd_ifaces() {
    ip -brief address
}

main() {
    local cmd="${1:-help}"

    case "$cmd" in
        ifaces)       cmd_ifaces ;;
        help|-h|--help) usage ;;
        *)
            echo "netchk: unknown command '$cmd'" >&2
            usage >&2
            exit 1
            ;;
    esac
}

main "$@"
