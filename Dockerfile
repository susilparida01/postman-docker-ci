FROM postman/newman:alpine

WORKDIR /etc/newman

COPY collections collections

# IMPORTANT:
# postman/newman image already has ENTRYPOINT ["newman"]
# So we only specify sub-commands here
CMD ["run","collections/API-Demo.postman_collection.json","-r","cli,html","--reporter-html-export","reports/report.html"]
