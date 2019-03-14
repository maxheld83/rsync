#!/usr/bin/env bats

@test "deployed assets equal commit SHA" {
  # curl is not available here, so this is from prior step
  result="$(head -1 index2.html)"
  [ "$result" = "$GITHUB_SHA" ]
}
