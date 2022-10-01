#!/bin/bash

VAL="$1"

echo "${VAL}" | sed -E 's|[^0-9]+||g'
