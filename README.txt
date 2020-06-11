Clone git repo and checkout correct branch,


	git clone https://github.com/PSHCDevOps/discovery.git
	git checkout zookeeper_config

Build docker image

	docker build -t <docker repo name>/discovery-zookeeper:<version number> .

Push docker image to docker repo,

	docker push <docker repo name>/discovery-zookeeper:<version-number>

Push application to CloudFoundry

	cf push 