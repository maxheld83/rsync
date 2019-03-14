#!/bin/sh

set -e

# SSH auth ===
SSH_PATH="$HOME/.ssh"

mkdir "$SSH_PATH"
touch "$SSH_PATH/known_hosts"

echo "$SSH_PRIVATE_KEY" > "$SSH_PATH/deploy_key"
echo "$SSH_PUBLIC_KEY" > "$SSH_PATH/deploy_key.pub"

chmod 700 "$SSH_PATH"
chmod 600 "$SSH_PATH/known_hosts"
chmod 600 "$SSH_PATH/deploy_key"
chmod 600 "$SSH_PATH/deploy_key.pub"

eval "$(ssh-agent -s)"
ssh-add "$SSH_PATH/deploy_key"
echo "$HOST_NAME,$HOST_IP $HOST_FINGERPRINT" \
  >> "$SSH_PATH/known_hosts"
# $HOST_NAME is used in the above as well as in the below; that's why it is an env

# "args" from main.workflow get append to below call
# these include source, user, $HOST and target
sh -c "rsync --verbose --recursive --delete-after --quiet $*"
