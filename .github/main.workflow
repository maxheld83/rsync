workflow "Test rsync" {
  on = "push"
  resolves = ["Bats", "Shellcheck"]
}

action "Shellcheck" {
  uses = "actions/bin/shellcheck@1b3c130914f7b20890bf159306137d994a4c39d0"
  args = "*.sh"
}

action "Write sha" {
  uses = "actions/bin/sh@db72a46c8ce298e5d2c3a51861e20c455581524f"
  args = ["echo $GITHUB_SHA >> index.html"]
}

action "Deploy with rsync" {
  uses = "./"
  needs = "Write sha"
  secrets = [
    "SSH_PRIVATE_KEY",
    "SSH_PUBLIC_KEY"
  ]
  env = {
    HOST_NAME = "karli.rrze.uni-erlangen.de"
    HOST_IP = "131.188.16.138"
    HOST_FINGERPRINT = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFHJVSekYKuF5pMKyHe1jS9mUkXMWoqNQe0TTs2sY1OQj379e6eqVSqGZe+9dKWzL5MRFpIiySRKgvxuHhaPQU4="
  }
  args = [
    "$GITHUB_WORKSPACE/index.html",
    "pfs400wm@$HOST_NAME:/proj/websource/docs/FAU/fakultaet/phil/www.datascience.phil.fau.de/websource/rsync"
  ]
}

action "Download deployed assets" {
  needs = "Deploy with rsync"
  uses = "actions/bin/curl@dd02a4bc5ee52c16bbc916d162075370a83d755c"
  args = [
    "http://datascience.phil.fau.de/rsync",
    "--output index2.html"
  ]
}

action "Bats" {
  needs = "Download deployed assets"
  uses = "actions/bin/bats@bd85fd8c369e36eb918c888218aa95469b69daba"
  args = "*.bats"
}
