#!/bin/bash

LINE=$(grep '^version:' pubspec.yaml)
NAME=${LINE%%+*}
BUILD=${LINE##*+}
NEW=$((BUILD+1))

sed -i "s/^version:.*/$NAME+$NEW/" pubspec.yaml
