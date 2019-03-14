#!/bin/bash

# Stop and remove test enviornment
docker container stop test-web && docker container rm test-web 

exit 0
