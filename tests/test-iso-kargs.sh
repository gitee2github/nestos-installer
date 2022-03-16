#!/bin/bash
set -xeuo pipefail

fatal() {
    echo "$@" >&2
    exit 1
}

iso=$1; shift
iso=$(realpath "${iso}")

tmpd=$(mktemp -d)
trap 'rm -rf "${tmpd}"' EXIT
cd "${tmpd}"

cp --reflink=auto "${iso}" "test.iso"
iso=test.iso
stdout_iso="${iso}.out"
orig_hash=$(sha256sum "${iso}")

# Sanity-check the ISO doesn't somehow already have the karg we're testing with.
if nestos-installer iso kargs show "${iso}" | grep -q foobar; then
    fatal "Unexpected foobar karg in iso kargs"
fi

# Stream modification to stdout.
stdout_hash=$(nestos-installer iso kargs modify -a foobar=oldval -a dodo -o - "${iso}" | tee "${stdout_iso}" | sha256sum)
nestos-installer iso kargs show "${stdout_iso}" | grep -q 'foobar=oldval dodo'
nestos-installer iso kargs modify -d foobar=oldval -d dodo -o - "${stdout_iso}" > "${iso}"
if nestos-installer iso kargs show "${iso}" | grep -q 'foobar'; then
    fatal "Unexpected foobar karg in iso kargs"
fi
hash=$(sha256sum "${iso}")
if [ "${orig_hash}" != "${hash}" ]; then
    fatal "Hash doesn't match original hash: ${hash} vs ${orig_hash}"
fi

# Test all the modification operations.
nestos-installer iso kargs modify -a foobar=oldval -a dodo "${iso}"
nestos-installer iso kargs show "${iso}" | grep -q 'foobar=oldval dodo'
hash=$(sha256sum < "${iso}")
if [ "${stdout_hash}" != "${hash}" ]; then
    fatal "Streamed hash doesn't match modified hash: ${stdout_hash} vs ${hash}"
fi
nestos-installer iso kargs modify -r foobar=oldval=newval "${iso}"
nestos-installer iso kargs show "${iso}" | grep -q 'foobar=newval dodo'
nestos-installer iso kargs modify -d foobar=newval -d dodo "${iso}"
if nestos-installer iso kargs show "${iso}" | grep -q 'foobar'; then
    fatal "Unexpected foobar karg in iso kargs"
fi

hash=$(sha256sum "${iso}")
if [ "${orig_hash}" != "${hash}" ]; then
    fatal "Hash doesn't match original hash: ${hash} vs ${orig_hash}"
fi

# Test the largest karg; we get the full area length from --header and subtract
# the default kargs size to get the size of the overflow embed area.
embed_size=$(nestos-installer iso kargs show --header "${iso}" | jq .length)
embed_default_kargs_size=$(nestos-installer iso kargs show --default "${iso}" | wc -c)
embed_usable_size=$((${embed_size} - ${embed_default_kargs_size} - 1))

long_karg=$(printf '%*s' $((embed_usable_size)) | tr ' ' "k")
nestos-installer iso kargs modify -a "${long_karg}" "${iso}"
nestos-installer iso kargs show "${iso}" | grep -q " ${long_karg}\$"
nestos-installer iso kargs reset "${iso}"
long_karg=$(printf '%*s' $((embed_usable_size + 1)) | tr ' ' "k")
if nestos-installer iso kargs modify -a "${long_karg}" "${iso}" 2>err.txt; then
    fatal "Was able to put karg longer than area?"
fi
grep -q 'kargs too large for area' err.txt

# And finally test `reset`.
nestos-installer iso kargs reset "${iso}"

hash=$(sha256sum "${iso}")
if [ "${orig_hash}" != "${hash}" ]; then
    fatal "Hash doesn't match original hash: ${hash} vs ${orig_hash}"
fi
