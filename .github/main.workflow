workflow "Test rsync" {
  on = "push"
  resolves = ["Deploy with rsync"]
}

action "Write sha" {
  uses = "actions/bin/sh@db72a46c8ce298e5d2c3a51861e20c455581524f"
  args = ["echo $GITHUB_SHA >> index.html"]
}

action "Deploy with rsync" {
  uses = "./rsync"
  needs = "Write sha"
  secrets = [
    "SSH_PRIVATE_KEY",
    "SSH_PUBLIC_KEY"
  ]
  env = {
    HOST = "karli.rrze.uni-erlangen.de"
  }
  args = [
    "$GITHUB_WORKSPACE/index.html",
    "pfs400wm@$HOST:/proj/websource/docs/FAU/fakultaet/phil/www.datascience.phil.fau.de/websource/ghaction-rsync"
  ]
}
