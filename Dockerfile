FROM mongo:3.6

RUN mkdir -p /data/db 
RUN mkdir -p /home/import
COPY videos.json /home/import/videos.json
COPY categories.json /home/import/categories.json

CMD ["mongod", "--bind_ip_all", "--auth"]

RUN mongoimport -u restheart -p R3ste4rt! --authenticationDatabase admin --db myflix --collection videos --drop --file /home/import/videos.json
RUN mongoimport -u restheart -p R3ste4rt! --authenticationDatabase admin --db myflix --collection categories --drop --file /home/import/categories.json

FROM softinstigate/restheart

# RUN echo "stopping services" && \
#     docker stop restheart && \
#     docker stop mongodb && \
#     docker rm restheart && \
#     docker rm mongodb && \
#     echo "services stopped"

CMD ["--link", "mongodb:mongodb"]
