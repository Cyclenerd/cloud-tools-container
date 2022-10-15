# Google Cloud Tools Container

[![Latest image](https://github.com/Cyclenerd/google-cloud-gcp-tools-container/actions/workflows/docker-latest.yml/badge.svg)](https://github.com/Cyclenerd/google-cloud-gcp-tools-container/actions/workflows/docker-latest.yml)
[![Latest build](https://img.shields.io/badge/Last%20build-2022--10--15-blue)](https://github.com/Cyclenerd/google-cloud-gcp-tools-container/actions/workflows/docker-latest.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/cyclenerd/google-cloud-gcp-tools-container)](https://hub.docker.com/r/cyclenerd/google-cloud-gcp-tools-container)
[![GitHub](https://img.shields.io/github/license/cyclenerd/google-cloud-gcp-tools-container)](https://github.com/Cyclenerd/google-cloud-gcp-tools-container/blob/master/LICENSE)

Ready-to-use Docker container image for Google Cloud Build and GitLab runner jobs.

Docker:
```shell
docker pull cyclenerd/google-cloud-gcp-tools-container:latest && \
docker run cyclenerd/google-cloud-gcp-tools-container:latest gcloud --version
```

Google Cloud Build (`cloudbuild.yml`) configuration file:
```yml
 - name: 'cyclenerd/google-cloud-gcp-tools-container:latest'
   entrypoint: 'gcloud'
   args: ['--version']
```

GitLab CI/CD (`.gitlab-ci.yml`) with Google Cloud SDK/CLI login:
```yml
variables:
  GOOGLE_APPLICATION_CREDENTIALS: "/tmp/service_account_key.json"
default:
  image: cyclenerd/google-cloud-gcp-tools-container:latest
  before_script:
    - echo "$YOUR_GOOGLE_CLOUD_SERVICE_ACCOUNT_KEY" > "$GOOGLE_APPLICATION_CREDENTIALS"
    - gcloud auth activate-service-account --key-file="$GOOGLE_APPLICATION_CREDENTIALS"
stages:
  - version
gcloud-version:
  stage: version
  script:
    - gcloud --version
```

## Software

This [Docker container image](https://hub.docker.com/r/cyclenerd/google-cloud-gcp-tools-container) based is on **Ubuntu GNU/Linux 22.04 LTS** (`ubuntu:22.04`).

The following software is included and tested:

* Google Cloud CLI (`gcloud`, `gsutil` and `bq`)
* Kubernetes
	* Kubernetes cluster manager (`kubectl`)
	* [Helm](https://helm.sh/) (`helm`)
* Terraform (`terraform`)
* Ansible (`ansible` and `ansible-playbook`)
* Base
	* GNU bash 5 (`bash`)
	* Perl 5 (`perl`)
	* Python 3 (`python3`)
	* OpenSSL 3 (`openssl`)
	* apt-utils
	* build-essential
	* ca-certificates
	* curl
	* git
	* jq
	* tar

## Contributing

Have a patch that will benefit this project?
Awesome! Follow these steps to have it accepted.

1. Please read [how to contribute](CONTRIBUTING.md).
1. Fork this Git repository and make your changes.
1. Create a Pull Request.
1. Incorporate review feedback to your changes.
1. Accepted!


## License

All files in this repository are under the [Apache License, Version 2.0](LICENSE) unless noted otherwise.