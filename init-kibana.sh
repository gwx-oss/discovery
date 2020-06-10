es_uri="$(echo "${VCAP_SERVICES}" | jq -r .elasticsearch56[0].credentials.uri)"
es_url="$(echo "${VCAP_SERVICES}" | jq -r .elasticsearch56[0].credentials.hostname)"
es_username="$(echo "${VCAP_SERVICES}" | jq -r .elasticsearch56[0].credentials.username)"
es_password="$(echo "${VCAP_SERVICES}" | jq -r .elasticsearch56[0].credentials.password)"
es_port="$(echo "${VCAP_SERVICES}" | jq -r .elasticsearch56[0].credentials.port)"

echo "> ElasticSearch URI: \"${es_uri}\""
echo "> ElasticSearch URL: \"${es_url}\""
echo "> ElasticSearch Username: \"${es_username}\""
echo "> ElasticSearch Password: \"${es_password}\""
echo "> ElasticSearch Port:\"${es_port}\""

#uri = http://username:password@url:port
echo "> Configuring kibana.yml with uri..."

sed -i "s/elasticsearch.url:/elasticsearch.url: \"http:\/\/${es_username}:${es_password}@${es_url}:${es_port}\"/" /etc/kibana/kibana.yml

cat /etc/kibana/kibana.yml

echo "> Kibana.yml configured. Switching to kibana user..."

echo "> Starting kibana..."

bash /usr/share/kibana/bin/kibana