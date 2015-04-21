#!/bin/bash

export USERNAME=your_username


export FULLNAME=your_fullname


export PASSWORD=your_password

export SECONDARY_GROUPS="admin _lpadmin _appserveradm _appserverusr" # for an admin user

export USERID=490 #For hidde user in pref pane


dscl . -create /Users/$USERNAME
dscl . -create /Users/$USERNAME UserShell /dev/null
dscl . -create /Users/$USERNAME RealName "$FULLNAME"
dscl . -create /Users/$USERNAME UniqueID "$USERID"
dscl . -create /Users/$USERNAME PrimaryGroupID 20 #Staff groupID
dscl . -create /Users/$USERNAME NFSHomeDirectory /var/$USERNAME
dscl . -passwd /Users/$USERNAME $PASSWORD
dscl . -create /Users/$USERNAME IsHidden 1

for GROUP in $SECONDARY_GROUPS ; do
    dseditgroup -o edit -t user -a $USERNAME $GROUP
done

createhomedir -c 2>&1 | grep -v "shell-init"