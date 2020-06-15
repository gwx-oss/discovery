es_uri="$(echo "${VCAP_SERVICES}" | jq -r .elasticsearch56[0].credentials.uri)"
es_url="$(echo "${VCAP_SERVICES}" | jq -r .elasticsearch56[0].credentials.hostname)"
es_username="$(echo "${VCAP_SERVICES}" | jq -r .elasticsearch56[0].credentials.username)"
es_password="$(echo "${VCAP_SERVICES}" | jq -r .elasticsearch56[0].credentials.password)"
es_port="$(echo "${VCAP_SERVICES}" | jq -r .elasticsearch56[0].credentials.port)"

echo "> ElasticSearch URL: \"${es_url}\""
echo "> ElasticSearch Username: \"${es_username}\""
echo "> ElasticSearch Password: \"${es_password}\""
echo "> ElasticSearch Port:\"${es_port}\""

echo "> Configuring Logstash With ElasticSearch URI..."

sed -i "s/REPLACE_WITH_ES_URI/http:\/\/${es_username}:${es_password}@${es_url}:${es_port}/" /home/log.conf

echo "> Logstash configured. Echoing Pipeline Configuration..."
echo ">>"
echo ">>>"
cat /home/log.conf
echo ">>>"
echo ">>"

echo "> Starting Logstash. Hold onto your pants..."

/home/logstash-6.0.0/bin/logstash -f log.conf
