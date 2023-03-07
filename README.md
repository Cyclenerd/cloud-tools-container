# Google Cloud Tools Container

[![Bagde: Google Cloud](https://img.shields.io/badge/Google%20Cloud-%234285F4.svg?logo=google-cloud&logoColor=white)](#readme)
[![Bagde: Ubuntu](https://img.shields.io/badge/Ubuntu-E95420.svg?logo=ubuntu&logoColor=white)](#readme)
[![Badge: Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?logo=terraform&logoColor=white)](#readme)
[![Badge: Ansible](https://img.shields.io/badge/Ansible-%231A1918.svg?logo=ansible&logoColor=white)](#readme)
[![Bagde: Docker](https://img.shields.io/badge/Docker-%230db7ed.svg?logo=docker&logoColor=white)](#readme)
[![Bagde: Kubernetes](https://img.shields.io/badge/Kubernetes-%23326ce5.svg?logo=kubernetes&logoColor=white)](#readme)
[![Latest image](https://github.com/Cyclenerd/google-cloud-gcp-tools-container/actions/workflows/docker-latest.yml/badge.svg)](https://github.com/Cyclenerd/google-cloud-gcp-tools-container/actions/workflows/docker-latest.yml)
[![Latest build](https://img.shields.io/badge/Last%20build-2023--03--07-blue)](https://github.com/Cyclenerd/google-cloud-gcp-tools-container/actions/workflows/docker-latest.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/cyclenerd/google-cloud-gcp-tools-container)](https://hub.docker.com/r/cyclenerd/google-cloud-gcp-tools-container)
[![GitHub](https://img.shields.io/github/license/cyclenerd/google-cloud-gcp-tools-container)](https://github.com/Cyclenerd/google-cloud-gcp-tools-container/blob/master/LICENSE)

Ready-to-use Docker container image for Google Cloud Build and GitLab runner jobs.


<details>
<summary><b>➨ Docker</b></summary>

Docker:
```shell
docker pull cyclenerd/google-cloud-gcp-tools-container:latest && \
docker run cyclenerd/google-cloud-gcp-tools-container:latest gcloud --version
```

</details> <!-- // Docker  -->


<details>
<summary><b>➨ Google Cloud Build</b></summary>

Google Cloud Build (`cloudbuild.yml`) configuration file:
```yml
 - name: 'cyclenerd/google-cloud-gcp-tools-container:latest'
   entrypoint: 'gcloud'
   args: ['--version']
```

</details><!-- // Google Cloud Build -->

<details>
<summary><b>➨ GitLab CI/CD</b></summary>

<details>
<summary><b>➥ Service Account Key</b></summary>

GitLab CI/CD (`.gitlab-ci.yml`) configuration with Service Account Key:
```yml
variables:
  GOOGLE_APPLICATION_CREDENTIALS: "/tmp/service_account_key.json"

default:
  image: cyclenerd/google-cloud-gcp-tools-container:latest
  before_script:
    # Login
    - echo "$YOUR_GOOGLE_CLOUD_SERVICE_ACCOUNT_KEY" > "$GOOGLE_APPLICATION_CREDENTIALS"
    - gcloud auth activate-service-account --key-file="$GOOGLE_APPLICATION_CREDENTIALS"

stages:
  - auth

gcloud-auth-list:
  stage: auth
  script:
    - gcloud auth list
```

</details>

<details>
<summary><b>➥ Workload Identity Federation</b></summary>

GitLab CI/CD (`.gitlab-ci.yml`) configuration with [Workload Identity Federation](https://github.com/Cyclenerd/google-workload-identity-federation) login:
```yml
variables:
  WIF_PROVIDER: projects/1057256049272/locations/global/workloadIdentityPools/gitlab-com/providers/gitlab-com-oidc
  SERVICE_ACCOUNT: gitlab-ci@nkn-it-wif-demo.iam.gserviceaccount.com
  GOOGLE_CREDENTIALS: gcp_temp_cred.json

default:
  image: cyclenerd/google-cloud-gcp-tools-container:latest
  before_script:
    # Login
    - echo "${CI_JOB_JWT_V2}" > gitlab_jwt_token.txt
    - gcloud iam workload-identity-pools create-cred-config "${WIF_PROVIDER}"
      --service-account="${SERVICE_ACCOUNT}"
      --output-file=${GOOGLE_CREDENTIALS}
      --credential-source-file=gitlab_jwt_token.txt
    - gcloud config set auth/credential_file_override "${GOOGLE_CREDENTIALS}"
stages:
  - auth

gcloud-auth-list:
  stage: auth
  script:
    - gcloud auth list
```

</details>
</details><!-- // GitLab -->

## Software

This [Docker container image](https://hub.docker.com/r/cyclenerd/google-cloud-gcp-tools-container) is based on **Ubuntu GNU/Linux 22.04 LTS** (`ubuntu:22.04`).

The following software is included and tested:

* [Google Cloud CLI](https://cloud.google.com/cli) (`gcloud`, `gsutil` and `bq`)
* Kubernetes
	* [Kubernetes cluster manager](https://kubernetes.io/docs/reference/kubectl/) (`kubectl`)
	* [Helm](https://helm.sh/) (`helm`)
* [Terraform](https://developer.hashicorp.com/terraform/cli) (`terraform`)
* [Ansible](https://docs.ansible.com/ansible/latest/getting_started/index.html) (`ansible` and `ansible-playbook`)
* [GCR Cleaner](https://github.com/GoogleCloudPlatform/gcr-cleaner#readme) (`gcr-cleaner-cli`)
* [fuego](https://github.com/sgarciac/fuego#readme) command line firestore client (`fuego`)
* Base
	* GNU bash 5 (`bash`)
	* Perl 5 (`perl`)
	* Python 3 (`python3`)
	* OpenSSL 3 (`openssl`)
	* Mutt command line email client (`mutt`)
	* DiG DNS lookup utility (`dig`)
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