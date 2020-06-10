echo "> ElasticSearch URI: ${ELASTICSEARCH_URI}"
echo "> Configuring kibana.yml with uri..."

sed "s/elasticsearch\.url:/elasticsearch.url:${ELASTICSEARCH_URI}/" /etc/kibana/kibana.yml

echo "Kibana.yml configured. Starting Kibana..."

bash /usr/share/kibana/bin/kibana