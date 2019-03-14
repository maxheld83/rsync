#!/usr/bin/env bats

@test "deployed assets are identical to local assets" {
  # TODO this isn't , I just can't get GITHUB_SHA to work in here as per https://github.com/maxheld83/rsync/issues/9
  GITHUB_SHA=$(cat index.html)
  # curl is not available here, so this is from prior step
  result="$(cat index2.html)"
  # and should be the same as from env var
  [ ! -z "($GITHUB_SHA)" ]
  [ "$result" = "$GITHUB_SHA" ]
}
