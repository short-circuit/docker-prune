# Docker Prune
Prune docker images, container, volumes and build cache

## READ CAREFULLY
Running this script will DELETE everything that has been managed with Docker. Seriously. In an irreversible way. So no going back. Not even with a time machine.

## Usage
```
./docker-prune.sh --<action>
Options:
  --container           Perform container pruning
  --volume              Perform volume pruning
  --image               Perform image pruning
  --network             Perform network pruning
  --build               Perform Docker build pruning
  --all                 Run all pruning actions
  --no-container         Run all pruning actions except container pruning
```
