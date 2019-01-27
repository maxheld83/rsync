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
    HOST = "karli.rrze.uni-erlangen.de"
  }
  args = [
    "_site/",
    "pfs400wm@$HOST:/proj/websource/docs/FAU/fakultaet/phil/www.datascience.phil.fau.de/websource/ghaction-rsync"
  ]
}
