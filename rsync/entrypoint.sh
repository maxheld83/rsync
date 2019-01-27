#!/bin/sh

set -e

SSH_PATH="$HOME/.ssh"

mkdir "$SSH_PATH"
touch "$SSH_PATH/known_hosts"

echo "$SSH_PRIVATE_KEY" > "$SSH_PATH/deploy_key"
echo "$SSH_PUBLIC_KEY" > "$SSH_PATH/deploy_key.pub"

chmod 700 "$SSH_PATH"
chmod 600 "$SSH_PATH/known_hosts"
chmod 600 "$SSH_PATH/deploy_key"
chmod 600 "$SSH_PATH/deploy_key.pub"

eval $(ssh-agent -s)
ssh-add "$SSH_PATH/deploy_key"

# below key was created by running the below line from inside karli.rrze
# ssh-keyscan -t ecdsa-sha2-nistp256 karli.rrze.uni-erlangen.de
# below line actually seems ineffectual; we still get "host key verification failed"
echo '$HOST,131.188.16.138 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFHJVSekYKuF5pMKyHe1jS9mUkXMWoqNQe0TTs2sY1OQj379e6eqVSqGZe+9dKWzL5MRFpIiySRKgvxuHhaPQU4=' \
  >> "$SSH_PATH/known_hosts"
# $HOST is used in the above as well as in the below; that's why it is an env

# "args" from main.workflow get append to below call
# these include source, user, $HOST and target
sh -c "rsync -r --delete-after --quiet -e 'ssh -o StrictHostKeyChecking=no' $*"
