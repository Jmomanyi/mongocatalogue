# Build Stage
FROM mongo:3.6 AS build-stage

RUN mkdir -p /data/db
RUN mkdir -p /home/import

COPY import/videos.json /home/import/videos.json
COPY import/categories.json /home/import/categories.json

# Run the import commands during the build stage
RUN mongod --fork --logpath /var/log/mongod.log && \
    mongoimport -u restheart -p R3ste4rt! --authenticationDatabase admin --db myflix --collection videos --drop --file /home/import/videos.json && \
    mongoimport -u restheart -p R3ste4rt! --authenticationDatabase admin --db myflix --collection categories --drop --file /home/import/categories.json && \
    mongod --shutdown

# Final Stage
FROM softinstigate/restheart

# ... (rest of the Dockerfile)
