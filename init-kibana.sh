es_uri="$(echo "${VCAP_SERVICES}" | jq -r .elasticsearch56[0].credentials.uri)"
es_url="$(echo "${VCAP_SERVICES}" | jq -r .elasticsearch56[0].credentials.hostname)"
es_username="$(echo "${VCAP_SERVICES}" | jq -r .elasticsearch56[0].credentials.username)"
es_password="$(echo "${VCAP_SERVICES}" | jq -r .elasticsearch56[0].credentials.password)"
es_port="$(echo "${VCAP_SERVICES}" | jq -r .elasticsearch56[0].credentials.port)"

echo "> ElasticSearch URL: \"${es_url}\""
echo "> ElasticSearch Username: \"${es_username}\""
echo "> ElasticSearch Password: \"${es_password}\""
echo "> ElasticSearch Port:\"${es_port}\""

#uri = http://username:password@url:port
echo "> Configuring kibana.yml with ElasticSearch URI..."

sed -i "s/elasticsearch.url:/elasticsearch.url: \"http:\/\/${es_username}:${es_password}@${es_url}:${es_port}\"/" /etc/kibana/kibana.yml
sed -i "s/elasticsearch.username:/elasticsearch.username: \"${es_username}\"/" /etc/kibana/kibana.yml
sed -i "s/elasticsearch.password:/elasticsearch.password: \"${es_password}\"/" /etc/kibana/kibana.yml

echo "> Kibana.yml configured. Echoing Kibana Configuration..."
echo ">>"
echo ">>>"
cat /etc/kibana/kibana.yml
echo ">>>"
echo ">>"
echo "> Starting Kibana. Hold onto your pants..."

bash /usr/share/kibana/bin/kibana