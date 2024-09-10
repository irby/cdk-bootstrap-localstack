# CDK Bootstrap LocalStack

A small Docker image to help you bootstrap your Localstack CDK stack.

This is helpful for projects using Localstack free tier and using the AWS CDK to provision infrastructure. Helps lessen the overhead of the ephemeral environments so developers spend more time focusing on other things.

## Include this container in your project!

See available Docker tags [on DockerHub](https://hub.docker.com/r/mirbs/cdk-bootstrap-localstack/tags).

```yaml
version: '3.8'
services:
  localstack:
    image: localstack/localstack:3.7.1
    ports:
      - "127.0.0.1:4566:4566"            # LocalStack Gateway
      - "127.0.0.1:4510-4559:4510-4559"  # external services port range
    environment:
      - DEBUG=0
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:4566"]
      interval: 2s
      timeout: 10s
      retries: 5
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
  cdk-bootstrap:
    depends_on:
      localstack:
        condition: service_healthy
    container_name: localstack-cdk-bootstrap
    environment:
      AWS_ENDPOINT_URL: http://localstack:4566
    image: mirbs/cdk-bootstrap-localstack
```
