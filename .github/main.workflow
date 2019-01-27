workflow "Test rsync" {
  on= "push"
  resolves = ["Deploy with rsync"]
}

action "Deploy with rsync" {
  uses = "./rsync"
  secrets = [
    "PRIVATE_KEY",
    "PUBLIC_KEY",
    "HOST",
    "USER"
  ]
}
