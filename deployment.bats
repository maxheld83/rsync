#!/usr/bin/env bats

@test "payload gets deployed to fau" {
  # read in sha from file
  # TODO this is redundant, I just can't get GITHUB_SHA to work in here as https://github.com/maxheld83/rsync/issues/9
  GITHUB_SHA=$(cat index.html)
  # read out sha deploy from previous step
  result="$(curl http://datascience.phil.fau.de/rsync)"
  # and should be the same as from env var
  [ ! -z "($GITHUB_SHA)" ]
  [ "$result" = "$GITHUB_SHA" ]
}
