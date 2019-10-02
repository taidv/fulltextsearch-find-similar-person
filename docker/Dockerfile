
FROM elasticsearch:7.4.0

COPY --chown=elasticsearch:elasticsearch config/elasticsearch.yml /usr/share/elasticsearch/config/
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch analysis-kuromoji
