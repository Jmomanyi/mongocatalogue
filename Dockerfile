# Build Stage
FROM mongo:3.6 AS build-stage

RUN mkdir -p /data/db
RUN mkdir -p /home/import

COPY import/videos.json /home/import/videos.json
COPY import/categories.json /home/import/categories.json

# Create an entrypoint script for initializing data
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Final Stage
FROM softinstigate/restheart

# Copy the data from the build stage
COPY --from=build-stage /home/import /home/import

# Copy the entrypoint script
COPY --from=build-stage /entrypoint.sh /entrypoint.sh

# Expose ports and set the entrypoint
EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
