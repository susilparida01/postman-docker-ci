FROM postman/newman:alpine

WORKDIR /etc/newman

COPY collections collections

CMD ["run", "collections/API-Demo.postman_collection.json", "-r", "cli,html", "--reporter-html-export", "reports/report.html"]