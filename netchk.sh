#!/usr/bin/env bash
# netchk - a small network inspection utility
set -euo pipefail

VERSION="0.1.0"

usage() {
    cat <<EOF
netchk $VERSION

Usage: netchk.sh <command>

Commands:
  if    List network interfaces and their addresses
  ping HOST Check whether a host is reachable
  dns HOST  Look up the addresses for a hostname
  help      Show this message
EOF
}

cmd_if() {
    ip -brief address | awk '
        BEGIN {
            printf "%-16s %-8s %s\n", "INTERFACE", "STATUS", "ADDRESS"
            printf "%-16s %-8s %s\n", "---------", "------", "-------"
        }
        {
            addrs = ""
            for (i = 3; i <= NF; i++)
                addrs = addrs (i > 3 ? ", " : "") $i
            printf "%-16s %-8s %s\n", $1, $2, addrs
        }'
}

cmd_ping() {
    local host="${1:-}"

    if [[ -z "$host" ]]; then
        echo "netchk: ping needs a host, e.g. netchk.sh ping 1.1.1.1" >&2
        return 1
    fi

    if ping -c 3 -W 2 "$host" > /dev/null 2>&1; then
        echo "OK: $host is reachable"
    else
        echo "FAIL: $host is not reachable" >&2
        return 1
    fi
}

cmd_dns() {
    local host="${1:-}"

    if [[ -z "$host" ]]; then
        echo "netchk: dns needs a hostname, e.g. netchk.sh dns example.com" >&2
        return 1
    fi

    local result
    result=$(dig +short +time=2 +tries=1 "$host" 2>/dev/null) || result=""

    if [[ -z "$result" ]]; then
        echo "FAIL: $host did not resolve" >&2
        return 1
    fi

    echo "OK: $host resolves to:"
    echo "$result"
}

main() {
    local cmd="${1:-help}"

    case "$cmd" in
        if)       cmd_if ;;
        ping)     cmd_ping "${2:-}" ;;
        dns)      cmd_dns "${2:-}" ;;
        help|-h|--help) usage ;;
        *)
            echo "netchk: unknown command '$cmd'" >&2
            usage >&2
            exit 1
            ;;
    esac
}

main "$@"
