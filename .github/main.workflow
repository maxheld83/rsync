workflow "Test rsync" {
  on= "push"
  resolves = ["Deploy with rsync"]
}

action "Deploy with rsync" {
  uses = "./rsync"
  secrets = [
    "PRIVATE_KEY",
    "PUBLIC_KEY"
  ]
  env = {
    USER = "pfs400wm"
    HOST = "karli.rrze.uni-erlangen.de"
  }
  args = [
    "$USER@$HOST:/proj/websource/docs/FAU/fakultaet/phil/www.datascience.phil.fau.de/websource/ghaction-rsync"
  ]
}
