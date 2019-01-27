#!/bin/sh

set -e

SSH_PATH="$HOME/.ssh"

mkdir "$SSH_PATH"
touch "$SSH_PATH/known_hosts"

echo "$PRIVATE_KEY" > "$SSH_PATH/deploy_key"
echo "$PUBLIC_KEY" > "$SSH_PATH/deploy_key.pub"

chmod 700 "$SSH_PATH"
chmod 600 "$SSH_PATH/known_hosts"
chmod 600 "$SSH_PATH/deploy_key"
chmod 600 "$SSH_PATH/deploy_key.pub"

eval $(ssh-agent -s)
# ssh-add "$SSH_PATH/deploy_key"
eval "$(ssh-add $SSH_PATH/deploy_key)"

# below key was created by running the below line from inside karli.rrze
# ssh-keyscan -t ecdsa-sha2-nistp256 karli.rrze.uni-erlangen.de
echo 'karli.rrze.uni-erlangen.de,131.188.16.138 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFHJVSekYKuF5pMKyHe1jS9mUkXMWoqNQe0TTs2sY1OQj379e6eqVSqGZe+9dKWzL5MRFpIiySRKgvxuHhaPQU4=' >> "$SSH_PATH/known_hosts"

rsync -r --delete-after --quiet home/repo/_site/ $USER@karli.rrze.uni-erlangen.de:/proj/websource/docs/FAU/fakultaet/phil/www.datascience.phil.fau.de/websource/ghaction-rsync
