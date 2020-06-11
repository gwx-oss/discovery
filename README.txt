This branch will create a Kibana image configured to run on CloudFoundry and bind to the CF provided ElasticSearch service. You will need to create a Docker repository to hold the image. In this example, I will use a personal repo setup on Dockerhub, chinchalinchin/discovery-kibana:5.6. 

First clone the repository,

	git clone https://github.com/PSHCDevOps/discovery.git

Then, checkout the correct branch

	git checkout kibana_config

Build the docker image and tag it with your repo info,

	docker build -t chinchalinchin/discovery-kibana:5.6 .

After the image has been built, login into your Docker repo

	docker login

Enter your credentials. Next, push the image to the repo,

	docker push chinchalinchin/discovery-kibana:5.6

After the image has been pushed to the Docker repo, you will need to edit the CloudFoundry manifest to pull the correct Docker image. The manifest attribute should specify the Docker repository to pull the image from,

	docker:
		image: chinchalinchin/discovery-kibana:5.6

Then login into CloudFoundry and target the organization and space you want to push it to,

	cf login

Finally, you simply push to CloudFoundry,

	cf push 