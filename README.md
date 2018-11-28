# Scaffold ECS Service boilterplate

- Sample dockerized Go app with /service-status endpoint
- Infrastrure template inside ./Infrastructure folder

**Owner:** Team0 Infra Team / sameer@cloudfactory.com
rohit.joshi@cloudfactory.com kaji@cloudfactory.com


# Layout on IAC

```
Sub-System
  |
  |- Infrastructure
  | |- cluster.yaml # ECS cluster, load balancers, service discovery domains
  | |- resources.yaml # databases, buckets, caches, sns/sqs etc resources shared between the services
  | |- Makefile
  |
  |- Service1 <-- YOU ARE HERE
  | |
  | |- Infrastructure
  | | |
  | | |- resources.yaml # ECR repos, service specific resources
  | | |- service.yaml # Services defn
  | | |- pipeline.yaml # CI/CD stuff #TODO
  | |
  | |- Makefile
  |
  ```

# Environment variable requirements

All make file looks for environment variables namely `AWS_PROFILE`, `AWS_REGION` and `AWS_LABEL`.
While AWS_PROFILE and AWS_REGION are quite straight forward, basically which AWS profile and region should be used to create stacks,
AWS_LABEL on the otherhand is a personalization label that can be added to create stacks. It can be any string that best describes the user/owner of the stack; `beta`, `staging`, `rikesh` are all valid labels. This helps to isolate stacks and stack resources from each other and allows us to create multiple stackset for diffeerent audiende at the same time.

# Setup and Deployments

```shell
  # clone this repository and cd into

  # configure Makefile as per your requirement
  # Variables that needs to be changed
  #
  # SUB_SYSTEM # Sub system code
  # ENV_TYPE # Environment type
  # SERVICE_NAME # Name of the service/component
  # APP_PORT  # App port number
  # HEALTH_CHECK_PATH # Health check path
  # Note APP_PORT and HEALTH_CHECK_PATH changes needs to be propagated in Dockerfile as well
  # URL_PATTERN # path on the load balancer that this service should be connected to, can be set to /* to catch all
  # PRIORITY # Priority of listner rule on load balancer, must be unique, refer to other existing listerner rules on the load balancer to make sure it is unique
  # DESIRED_COUNT # desired count of the number of containers for this service

  # Change Service.Name value in resource/config/config.yaml to your given name for the service/component

  # application check
  $ make build
  $ make run
  # curl localhost:3000/service-status
  # This is the default health check endpoint, make sure health check endpoint is up and behaving correctly, health check failure can lead to deploy failures

  # export our required environment variables
  # export AWS_PROFILE=team0
  # export AWS_REGION=us-east-1
  # export AWS_LABEL=alpha

  # setup service specific resources
  $ make create resources

  # push image to ECR
  $ make ecr-push SERVICE_VERSION=0.0.0

  # service create
  $ make create-service SERVICE_VERSION=0.0.0

  # make changes
  # service update
  $ make ecr-push SERVICE_VERSION=0.0.1
  $ make update-service SERVICE_VERSION=0.0.1
```


