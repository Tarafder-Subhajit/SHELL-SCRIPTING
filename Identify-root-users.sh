#!/bin/bash

echo "Checking users with root privileges..."
#-------------------------------------------------------------------------------------COMMENTS-----------------------------------------------------------------------------------------------------------------------------------------------------------------

# person whose user id is 0 , is a root user
# The /etc/passwd file is a plain-text database containing essential information about all user accounts on a Linux system. It is world-readable but only writable by the root user. Each line represents one user and contains seven colon-separated fields.
: <<'COMMENT'
Example:
'sudo cat /etc/passwd'
Sample output:
root:x:0:0:root:/root:/bin/bash
mark:x:1001:1001:Mark Smith:/home/mark:/bin/bash
Copy
Field Breakdown (colon : separated):
Username – Login name (e.g., mark).
Password – Usually x, meaning the encrypted password is stored in /etc/shadow.
UID – User ID number (0 for root, 1–999 for system accounts, 1000+ for normal users).
GID – Primary group ID, linked to /etc/group.
GECOS – Optional comment field (full name, contact info).
Home Directory – Path to the user’s home folder.
Login Shell – Default shell executed at login (e.g., /bin/bash).
COMMENT
#-------------------------------------------------------------------------------------COMMENTS-----------------------------------------------------------------------------------------------------------------------------------------------------------------
# 1. Users with UID 0 (direct root access)
echo "Users with UID 0 (direct root access):"
awk -F: '$3 == 0 {print $1}' /etc/passwd
# '-F:' means that field separator is colon(;)
# '$3 == 0' checks if the third field (which is the UID) equals 0.
# '{print $1}' prints the first field (which is the username).

# 2. Users in the 'sudo' group (indirect root access via sudo).
echo "Users in the 'sudo' group:"
getent group sudo | awk -F: '{print $4}' | tr ',' '\n'
# getent group sudo retrieves the entry for the sudo group from the system's group database.
# awk -F: sets the field separator to : and {print $4} prints the fourth field, which contains the list of users in that group.
# tr ',' '\n' converts commas into newlines, so each username appears on its own line.

# 3. Users explicitly granted sudo privileges in the sudoers file
echo "Users with explicit sudo privileges in /etc/sudoers:"
awk '/^[^#].*ALL=\(ALL\)/ {print $1}' /etc/sudoers
# The regex /^[^#].*ALL=\(ALL\)/ matches non-comment lines (i.e., lines not starting with #) that contain ALL=(ALL) (the '\(' and '\)' escape literal parentheses).
# {print $1} prints the first field on the matched line — in sudoers syntax, that first token is typically the user specification

# 4. Users in files under /etc/sudoers.d (additional sudo privileges)
echo "Users with sudo privileges in /etc/sudoers.d:"
for file in /etc/sudoers.d/*; do
  [ -f "$file" ] && awk '/^[^#].*ALL=\(ALL\)/ {print $1}' "$file"
done
