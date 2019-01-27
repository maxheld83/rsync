# just to make docker run easier, just used for testing
docker run \
  --rm  `# make container ephemeral` \
  -it `# make container interactive` \
  -v /Users/max/GitHub/ghaction-rsync:/home/repo \
  3647404edf0c `# the image` \
