workflow "Test rsync" {
  on= "push"
  resolves = ["Deploy with rsync"]
}

action "ssh" {
  uses = "maddox/actions/ssh@master"
  args = "/opt/deploy/run"
  secrets = [
    "PRIVATE_KEY",
    "PUBLIC_KEY",
    "HOST",
    "USER"
  ]
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
