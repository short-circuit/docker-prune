#!/bin/bash

PRUNE_CONTAINERS=false
PRUNE_VOLUMES=false
PRUNE_IMAGES=false
PRUNE_NETWORKS=false
PRUNE_DOCKER_BUILDs=false
DEFAULT_ACTIONS=""
PRUNE_ALL=false
PRUNE_EXCEPT_CONTAINERS=false

function print_usage {
    cat <<USAGE
Usage: $0 [--<action>] ... [--all] [--no-container]
Options:
  --container           Perform container pruning
  --volume              Perform volume pruning
  --image               Perform image pruning
  --network             Perform network pruning
  --build               Perform Docker build pruning
  --all                 Run all pruning actions
  --no-container         Run all pruning actions except container pruning
USAGE
    exit 1
}

function print_actions {
    echo "Performing the following actions:$DEFAULT_ACTIONS"
}

function prune_containers() {
    echo "Stopping and removing containers..."
    docker stop $(docker ps -aq) && docker rm $(docker ps -aq)
}

function prune_volumes() {
    echo "Removing unused volumes..."
    docker volume prune --all --force
}

function prune_images() {
    echo "Removing dangling images..."
    docker image prune --all --force
}

function prune_networks() {
    echo "Removing unused networks..."
    docker network prune --force
}

function prune_docker_builds() {
    echo "Removing old Docker builds..."
    docker system prune --all --force
}

function prune_all() {
    prune_containers
    prune_except_containers
}

function prune_except_containers() {
    prune_volumes
    prune_images
    prune_networks
    prune_docker_builds
}

if [ "$#" -eq 0 ]; then
    print_usage
fi

for arg in "$@"; do
    case "$arg" in
    --container) prune_containers ;;
    --volume) prune_volumes ;;
    --image) prune_images ;;
    --network) prune_networks ;;
    --build) prune_docker_builds ;;
    --all) prune_all ;;
    --no-container) prune_except_containers ;;
    *) print_usage ;;
    esac
done
