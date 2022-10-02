#!/bin/bash

VAL="$*"

echo -n "${VAL}" | xxd -i | tr -d ' ' | tr -d ',' | tr -d '[:space:]' | sed -E 's/0x/%/g' | tr -d '[:space:]'
