#!/bin/bash

# Start MongoDB in the background
mongod --fork --logpath /var/log/mongod.log

# Import data
mongoimport -u restheart -p R3ste4rt! --authenticationDatabase admin --db myflix --collection videos --drop --file /home/import/videos.json
mongoimport -u restheart -p R3ste4rt! --authenticationDatabase admin --db myflix --collection categories --drop --file /home/import/categories.json

# Start Restheart
exec softinstigate/restheart