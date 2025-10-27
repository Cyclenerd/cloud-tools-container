# Cloud Tools Container

[![Badge: Ansible](https://img.shields.io/badge/Ansible-%231A1918.svg?logo=ansible&logoColor=white)](#readme)
[![Badge: AWS](https://img.shields.io/badge/AWS-%23232F3E.svg?logo=amazonwebservices&logoColor=white)](#readme)
[![Badge: Bitbucket](https://img.shields.io/badge/Bitbucket-0052CC.svg?logo=bitbucket&logoColor=white)](#readme)
[![Badge: CircleCI](https://img.shields.io/badge/CircleCI-343434.svg?logo=circleci&logoColor=white)](#readme)
[![Badge: Docker](https://img.shields.io/badge/Docker-%230db7ed.svg?logo=docker&logoColor=white)](#readme)
[![Badge: GitLab](https://img.shields.io/badge/GitLab-FC6D26.svg?logo=gitlab&logoColor=white)](#readme)
[![Badge: GNU Bash](https://img.shields.io/badge/GNU%20Bash-4EAA25.svg?logo=gnubash&logoColor=white)](#readme)
[![Badge: Go](https://img.shields.io/badge/Go-%2300ADD8.svg?logo=go&logoColor=white)](#readme)
[![Badge: Google Cloud](https://img.shields.io/badge/Google%20Cloud-%234285F4.svg?logo=google-cloud&logoColor=white)](#readme)
[![Badge: Hetzer Cloud](https://img.shields.io/badge/Hetzner-D50C2D.svg?logo=hetzner&logoColor=white)](#readme)
[![Badge: Kubernetes](https://img.shields.io/badge/Kubernetes-%23326ce5.svg?logo=kubernetes&logoColor=white)](#readme)
[![Badge: Packer](https://img.shields.io/badge/Packer-02A8EF.svg?logo=packer&logoColor=white)](#readme)
[![Badge: Perl](https://img.shields.io/badge/Perl-%2339457E.svg?logo=perl&logoColor=white)](#readme)
[![Badge: Python](https://img.shields.io/badge/Python-3670A0?logo=python&logoColor=ffdd54)](#readme)
[![Badge: Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?logo=terraform&logoColor=white)](#readme)
[![Badge: Ubuntu](https://img.shields.io/badge/Ubuntu-E95420.svg?logo=ubuntu&logoColor=white)](#readme)
[![Badge: Vault](https://img.shields.io/badge/Vault-FFEC6E.svg?logo=vault&logoColor=black)](#readme)
[![Badge:Last release](https://github.com/Cyclenerd/cloud-tools-container/actions/workflows/podman-release.yml/badge.svg)](https://github.com/Cyclenerd/cloud-tools-container/actions/workflows/podman-release.yml)
[![Badge:Last release](https://img.shields.io/badge/Last%20release-2025--10--27-blue)](https://github.com/Cyclenerd/cloud-tools-container/actions/workflows/podman-release.yml)
[![Badge: Docker pulls](https://img.shields.io/docker/pulls/cyclenerd/cloud-tools-container)](https://hub.docker.com/r/cyclenerd/cloud-tools-container)
[![Badge: License](https://img.shields.io/github/license/cyclenerd/cloud-tools-container)](https://github.com/Cyclenerd/cloud-tools-container/blob/master/LICENSE)

Ready-to-use Docker container image for
AWS CodeBuild/CodePipeline,
Bitbucket Pipelines,
CircleCI,
GitHub Actions,
GitLab runner jobs and
Google Cloud Build.

**Image:**
```text
cyclenerd/cloud-tools-container:latest
```

**Multiarch support:**
  * `amd64` : Intel or AMD 64-Bit CPU (x86-64)
  * `arm64` : Arm-based 64-Bit CPU (i.e. Apple silicon, AWS Graviton, Ampere Altra)

> [!NOTE]
> This project leverages GitHub Actions (https://github.com/Cyclenerd/cloud-tools-container/actions) for streamlined automated builds and deployments.
> The Container image is rebuilt on a weekly basis, every Monday.


## Software

This [Docker container image](https://hub.docker.com/r/cyclenerd/cloud-tools-container) is based on the **Ubuntu 24.04** release (`ubuntu:noble`).

The following software is included and tested:

* [Ansible](https://docs.ansible.com/ansible/latest/getting_started/index.html) infrastructure as configuration (IaC) software tool (`ansible` and `ansible-playbook`)
* [AWS](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html) command line interface (CLI) tools (`aws`)
* [fuego](https://github.com/sgarciac/fuego#readme) command line firestore client (`fuego`)
* [Hetzner Cloud CLI](https://github.com/hetznercloud/cli) (`hcloud`)
* [GCR Cleaner](https://github.com/GoogleCloudPlatform/gcr-cleaner#readme) deletes old container images on registries (`gcr-cleaner-cli`)
* [Google Cloud](https://cloud.google.com/cli) command line interface (CLI) tools (`gcloud`, `gsutil` and `bq`)
* [Open Policy Agent](https://www.openpolicyagent.org/) general-purpose policy engine, context-aware policy enforcement (`opa`)
* [Packer](https://developer.hashicorp.com/packer) (`packer`)
* [ShellCheck](https://www.shellcheck.net/) analysis and linting tool for Shell/Bash scripts (`shellcheck`)
* [skopeo](https://github.com/containers/skopeo) command line utility that performs various operations on container images and repositories (`skopeo`)
* [Terraform](https://developer.hashicorp.com/terraform/cli) infrastructure as configuration (IaC) software tool (`terraform`)
  * [terraform-docs](https://github.com/terraform-docs/terraform-docs#readme) generates documentation from Terraform modules (`terraform-docs`)
  * [Terragrunt](https://terragrunt.gruntwork.io/) thin wrapper that provides extra tools (`terragrunt`)
  * [tflint](https://github.com/terraform-linters/tflint) linting tool for Terraform code (`tflint`)
  * [tfsec](https://github.com/aquasecurity/tfsec#readme) analysis security scanner for Terraform code (`tfsec`)
* Kubernetes
  * [Helm](https://helm.sh/) package manager for Kubernetes (`helm`)
  * [Kubernetes cluster manager](https://kubernetes.io/docs/reference/kubectl/) command line tool for communicating with a Kubernetes cluster (`kubectl`)
* [Vault](https://developer.hashicorp.com/vault) password manager and authentication tool (`vault`)
* [yq](https://github.com/mikefarah/yq) command-line YAML, JSON and XML processor (`yq`)
* Base packages
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
  * [Node.js](https://nodejs.org/) JavaScript runtime environment (`node`)
    * [npm](https://www.npmjs.com/) package manager for the JavaScript (`npm`)
  * [OpenSSL](https://www.openssl.org/) cryptography toolkit (`openssl`)
  * [OpenSSH](https://www.openssh.com/) remote login client (`ssh`)
  * [Perl 5](https://www.perl.org/) programming language (`perl`)
    * [cpanm](https://metacpan.org/dist/App-cpanminus/view/bin/cpanm) modules installer for Perl (`cpanm`)
  * [Python 3](https://www.python.org/) programming language (`python3`)
    * [pip](https://pypi.org/project/pip/) package installer for Python (`pip3`)
    * [flake8](https://flake8.pycqa.org/en/latest/) code checker using pycodestyle and pyflakes (`flake8`)
  * [Go](https://go.dev/) programming language (`go`)
  * GNU tar archiving utility (`tar`)
  * De-archiver for .zip files (`unzip`)
  * Archiver for .zip files (`zip`)

## Run

Runs a command in the container, pulling the image if needed and starting the container.

### Docker 🐳

Docker run command:

```shell
docker run cyclenerd/cloud-tools-container:latest aws --version
```

### Podman 🦭

Podman run command:

```shell
podman run docker.io/cyclenerd/cloud-tools-container:latest aws --version
```

## Examples

Example configurations for various CI/CD tools.

### AWS CodeBuild

AWS CodeBuild configuration:

```json
{
  "environment": {
    "type": "LINUX_CONTAINER",
    "image": "cyclenerd/cloud-tools-container:latest",
    "computeType": "BUILD_GENERAL1_SMALL"
  },
}
```

### Google Cloud Build

Google Cloud Build (`cloudbuild.yaml`) configuration file:

```yml
steps:
  - name: 'cyclenerd/cloud-tools-container:latest'
    entrypoint: 'gcloud'
    args: ['--version']
```

### GitLab CI/CD

#### Google Cloud Service Account Key

GitLab CI/CD (`.gitlab-ci.yml`) configuration with Google Cloud Service Account Key:

```yml
variables:
  GOOGLE_APPLICATION_CREDENTIALS: "/tmp/service_account_key.json"

default:
  image: cyclenerd/cloud-tools-container:latest
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

#### Google Cloud Workload Identity Federation

GitLab CI/CD (`.gitlab-ci.yml`) configuration with Google Cloud [Workload Identity Federation](https://github.com/Cyclenerd/google-workload-identity-federation) login:

```yml
variables:
  WIF_PROVIDER: projects/1057256049272/locations/global/workloadIdentityPools/gitlab-com/providers/gitlab-com-oidc
  SERVICE_ACCOUNT: gitlab-ci@nkn-it-wif-demo.iam.gserviceaccount.com
  GOOGLE_CREDENTIALS: gcp_temp_cred.json

default:
  image: cyclenerd/cloud-tools-container:latest
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

#### Google Cloud Workload Identity Federation

Bitbucket pipeline configuration (`bitbucket-pipelines.yml`) with Google Cloud [Workload Identity Federation](https://github.com/Cyclenerd/google-workload-identity-federation) login:

```yml
image: cyclenerd/cloud-tools-container:latest

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

### GitHub Actions

GitHub Actions configuration:

```yaml
jobs:
  cloud-tools-container:
    runs-on: 'ubuntu-latest'
    # Use container to run the steps in a job
    container:
      image: 'docker://cyclenerd/cloud-tools-container:latest'
    steps:
      - name: "Terraform"
        run: terraform --version
```

### CircleCI

CircleCI configuration:

```yml
jobs:
  cloud-tools-container:
    docker:
      - image: cyclenerd/cloud-tools-container:latest
    steps:
      - run:
          name: Google Cloud CLI
          command: gcloud --version
```

## Build

**Multi-Platform Image (AMD64 and ARM64)**

To build a container image that can run on both AMD64 and ARM64 architectures, use the following command:

```bash
podman manifest create "cloud-tools-container"
podman build . \
  --manifest "cloud-tools-container" \
  --platform "linux/amd64,linux/arm64" \
  --tag "cloud-tools-container:multi"
```

**Platform-Specific Images**

Create a container image only for Intel or AMD 64-Bit CPU (x86-64):

```bash
podman build . \
  --platform "linux/amd64" \
  --tag "cloud-tools-container:amd64"
```

Create a container image only for Arm-based 64-Bit CPU:

```bash
podman build . \
  --platform "linux/arm64" \
  --tag "cloud-tools-container:arm64"
```

**(Alternative) Combining Images into a Multi-Platform Image**

To combine platform-specific images into one multi-platform image:

```bash
podman manifest create "cloud-tools-container:multi" \
  --amend "cloud-tools-container:amd64" \
  --amend "cloud-tools-container:arm64"
podman manifest inspect "cloud-tools-container:multi" | jq
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
