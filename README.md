# Google Cloud Tools Container

[![Bagde: Google Cloud](https://img.shields.io/badge/Google%20Cloud-%234285F4.svg?logo=google-cloud&logoColor=white)](#readme)
[![Bagde: Ubuntu](https://img.shields.io/badge/Ubuntu-E95420.svg?logo=ubuntu&logoColor=white)](#readme)
[![Badge: Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?logo=terraform&logoColor=white)](#readme)
[![Badge: Ansible](https://img.shields.io/badge/Ansible-%231A1918.svg?logo=ansible&logoColor=white)](#readme)
[![Bagde: Docker](https://img.shields.io/badge/Docker-%230db7ed.svg?logo=docker&logoColor=white)](#readme)
[![Bagde: Kubernetes](https://img.shields.io/badge/Kubernetes-%23326ce5.svg?logo=kubernetes&logoColor=white)](#readme)
[![Bagde: GNU Bash](https://img.shields.io/badge/GNU%20Bash-4EAA25.svg?logo=gnubash&logoColor=white)](#readme)
[![Bagde: Perl](https://img.shields.io/badge/Perl-%2339457E.svg?logo=perl&logoColor=white)](#readme)
[![Bagde: Python](https://img.shields.io/badge/Python-3670A0?logo=python&logoColor=ffdd54)](#readme)
[![Badge: GitLab](https://img.shields.io/badge/GitLab-FC6D26.svg?logo=gitlab&logoColor=white)](#readme)
[![Badge: Bitbucket](https://img.shields.io/badge/Bitbucket-0052CC.svg?logo=bitbucket&logoColor=white)](#readme)
[![Latest image](https://github.com/Cyclenerd/google-cloud-gcp-tools-container/actions/workflows/docker-latest.yml/badge.svg)](https://github.com/Cyclenerd/google-cloud-gcp-tools-container/actions/workflows/docker-latest.yml)
[![Latest build](https://img.shields.io/badge/Last%20build-2023--09--15-blue)](https://github.com/Cyclenerd/google-cloud-gcp-tools-container/actions/workflows/docker-latest.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/cyclenerd/google-cloud-gcp-tools-container)](https://hub.docker.com/r/cyclenerd/google-cloud-gcp-tools-container)
[![License](https://img.shields.io/github/license/cyclenerd/google-cloud-gcp-tools-container)](https://github.com/Cyclenerd/google-cloud-gcp-tools-container/blob/master/LICENSE)

Ready-to-use Docker container image for Google Cloud Build, Bitbucket Pipelines and GitLab runner jobs.

## Software

This [Docker container image](https://hub.docker.com/r/cyclenerd/google-cloud-gcp-tools-container) is based on the latest **Ubuntu** release (regardless of LTS status) (`ubuntu:rolling`).

The following software is included and tested:

* [Google Cloud CLI](https://cloud.google.com/cli) (`gcloud`, `gsutil` and `bq`)
* Kubernetes
	* [Kubernetes cluster manager](https://kubernetes.io/docs/reference/kubectl/) (`kubectl`)
	* [Helm](https://helm.sh/) (`helm`)
* [Terraform](https://developer.hashicorp.com/terraform/cli) (`terraform`)
	* [terraform-docs](https://github.com/terraform-docs/terraform-docs#readme) generates documentation from Terraform modules (`terraform-docs`)
	* [tfsec](https://github.com/aquasecurity/tfsec#readme) analysis security scanner for Terraform code (`tfsec`)
	* [tflint](https://github.com/terraform-linters/tflint) linting tool for Terraform code (`tflint`)
* [Ansible](https://docs.ansible.com/ansible/latest/getting_started/index.html) (`ansible` and `ansible-playbook`)
* [skopeo](https://github.com/containers/skopeo) command line utility that performs various operations on container images and repositories (`skopeo`)
* [GCR Cleaner](https://github.com/GoogleCloudPlatform/gcr-cleaner#readme) deletes old container images on registries (`gcr-cleaner-cli`)
* [fuego](https://github.com/sgarciac/fuego#readme) command line firestore client (`fuego`)
* [ShellCheck](https://www.shellcheck.net/) analysis and linting tool for Shell/Bash scripts (`shellcheck`)
* Base
	* GNU bash 5 (`bash`)
	* [apt-utils](https://packages.ubuntu.com/lunar/apt-utils)
		* [Advanced Packaging Tool](https://ubuntu.com/server/docs/package-management) package manager (`apt`, `apt-get`)
	* [build-essential](https://packages.ubuntu.com/lunar/build-essential)
		* GNU C compiler `gcc`
		* [make](https://www.gnu.org/software/make/) utility for directing compilation (`make`)
	* [Common CA certificates](https://ubuntu.com/server/docs/security-trust-store)
	* [curl](https://curl.se/docs/manpage.html) tool for transferring data with URL syntax (`curl`)
	* [DiG](https://en.wikipedia.org/wiki/Dig_(command)) DNS lookup utility (`dig`)
	* [FIGlet](http://www.figlet.org/) prints its input using large characters (`figlet`)
	* [git](https://git-scm.com/) distributed revision control system (`git`)
	* [jq](https://jqlang.github.io/jq/) JSON processor (`jq`)
	* [Mutt](https://wiki.archlinux.org/title/Mutt) command line email client (`mutt`)
	* [OpenSSL](https://www.openssl.org/) cryptography toolkit (`openssl`)
	* [OpenSSH](https://www.openssh.com/) remote login client (`ssh`)
	* Perl 5 (`perl`)
		* [cpanm](https://metacpan.org/dist/App-cpanminus/view/bin/cpanm) modules installer for Perl (`cpanm`)
	* Python 3 (`python3`)
		* [pip](https://pypi.org/project/pip/) package installer for Python (`pip3`)
	* GNU tar archiving utility (`tar`)
	* De-archiver for .zip files (`unzip`)
	* Archiver for .zip files (`zip`)

## HOWTO

Docker pull command:

```shell
docker pull cyclenerd/google-cloud-gcp-tools-container:latest
```

Example run command:

```shell
docker run cyclenerd/google-cloud-gcp-tools-container:latest gcloud
```

## Examples

### Google Cloud Build

Google Cloud Build (`cloudbuild.yml`) configuration file:

```yml
steps:
  - name: 'cyclenerd/google-cloud-gcp-tools-container:latest'
    entrypoint: 'gcloud'
    args: ['--version']
```

### GitLab CI/CD

#### Service Account Key

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

#### Workload Identity Federation

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


### Bitbucket Pipelines

#### Workload Identity Federation

Bitbucket pipeline configuration (`bitbucket-pipelines.yml`) with [Workload Identity Federation](https://github.com/Cyclenerd/google-workload-identity-federation) login:

```yml
image: cyclenerd/google-cloud-gcp-tools-container:latest

pipelines:
  default:
    - step:
        name: "Workload Identity Federation"
        # Enable OIDC
        oidc: true
        max-time: 5
        script:
          # Set variables
          - export WIF_PROVIDER='projects/753695557698/locations/global/workloadIdentityPools/bitbucket-org/providers/bitbucket-org-oidc'
          - export SERVICE_ACCOUNT='bitbucket-pipeline@nkn-it-wif-demo-0.iam.gserviceaccount.com'
          - export GOOGLE_CREDENTIALS='gcp_temp_cred.json'
          # Configure Workload Identity Federation via a credentials file.
          - echo ${BITBUCKET_STEP_OIDC_TOKEN} > .ci_job_jwt_file
          - gcloud iam workload-identity-pools create-cred-config "${WIF_PROVIDER}"
            --service-account="${SERVICE_ACCOUNT}"
            --output-file="${GOOGLE_CREDENTIALS}"
            --credential-source-file=.ci_job_jwt_file
          - gcloud config set auth/credential_file_override "${GOOGLE_CREDENTIALS}"
          # Now you can run gcloud commands authenticated as the impersonated service account.
```


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