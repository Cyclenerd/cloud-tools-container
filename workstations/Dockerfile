# Copyright 2024 Nils Knieling. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Cloud Workstations base editor, Code OSS for Cloud Workstations, based on Code-OSS
# https://cloud.google.com/workstations/docs/preconfigured-base-images
FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest

# https://github.com/GoogleCloudPlatform/gcr-cleaner/releases
ENV GCR_CLEANER_VERSION="0.12.0"
# https://github.com/sgarciac/fuego/releases
ENV FUEGO_VERSION="0.34.0"
ENV FUEGO_URL="https://github.com/sgarciac/fuego/archive/refs/tags/${FUEGO_VERSION}.tar.gz"
# https://github.com/terraform-docs/terraform-docs/releases
ENV TFDOC_VERSION="0.17.0"
# https://github.com/aquasecurity/tfsec/releases
ENV TFSEC_VERSION="1.28.6"
# https://github.com/terraform-linters/tflint/releases
ENV TFLINT_VERSION="0.51.1"
# Default to UTF-8 file.encoding
ENV LANG="C.UTF-8"
# Set debconf frontend to noninteractive
ENV DEBIAN_FRONTEND="noninteractive"

# Download URLs for AMD64 (X86/64)
ENV AWS_CLI_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
ENV GCR_CLEANER_URL="https://github.com/GoogleCloudPlatform/gcr-cleaner/releases/download/v${GCR_CLEANER_VERSION}/gcr-cleaner-cli_${GCR_CLEANER_VERSION}_linux_amd64.tar.gz"
ENV OPA_URL="https://github.com/open-policy-agent/opa/releases/latest/download/opa_linux_amd64_static"
ENV TERRAGRUNT_URL="https://github.com/gruntwork-io/terragrunt/releases/latest/download/terragrunt_linux_amd64"
ENV TFDOC_URL="https://github.com/terraform-docs/terraform-docs/releases/download/v${TFDOC_VERSION}/terraform-docs-v${TFDOC_VERSION}-linux-amd64.tar.gz"
ENV TFLINT_URL="https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip"
ENV TFSEC_URL="https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec_${TFSEC_VERSION}_linux_amd64.tar.gz"

# Install tools
RUN uname -m && \
	apt-get update -yq && \
	apt-get install -yqq \
		apt-transport-https \
		apt-utils \
		build-essential \
		ca-certificates \
		cpanminus \
		curl \
		dnsutils \
		figlet \
		git \
		golang-go \
		gpg \
		htop \
		jq \
		lsb-release \
		mutt \
		python3-pip \
		shellcheck \
		skopeo \
		software-properties-common \
		tar \
		unzip \
		zip && \
# Add Hashicorp repository
	curl -fsSL "https://apt.releases.hashicorp.com/gpg" | gpg --dearmor -o "/usr/share/keyrings/releases-hashicorp.gpg" && \
	echo "deb [signed-by=/usr/share/keyrings/releases-hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee -a "/etc/apt/sources.list.d/releases-hashicorp.list" && \
# Add Ansible PPA repository
	add-apt-repository "ppa:ansible/ansible" && \
# Install tools
	apt-get update -yq && \
	apt-get install -yqq \
		google-cloud-cli \
		google-cloud-sdk-gke-gcloud-auth-plugin \
		terraform \
		packer \
		vault \
		sentinel \
		ansible \
		kubectl \
		helm && \
# Fix "vault: Operation not permitted" error
# https://github.com/hashicorp/vault/issues/10924
	setcap -r "/usr/bin/vault" && \
# AWS CLI (https://github.com/GoogleCloudPlatform/gcr-cleaner)
	echo "AWS CLI URL: '$AWS_CLI_URL'"                        && \
	curl -L "$AWS_CLI_URL" -o "awscliv2.zip"                  && \
	unzip -qq "awscliv2.zip"                                  && \
	./aws/install -b "/usr/local/bin" -i "/usr/local/aws-cli" && \
	rm -rf aws*                                               && \
# GCR Cleaner (https://github.com/GoogleCloudPlatform/gcr-cleaner)
	curl -L "$GCR_CLEANER_URL" -o "gcr-cleaner-cli.tar.gz" && \
	tar -xf "gcr-cleaner-cli.tar.gz" "gcr-cleaner-cli"     && \
	mv "gcr-cleaner-cli" "/usr/bin/gcr-cleaner-cli"        && \
	rm "gcr-cleaner-cli.tar.gz"                            && \
# Fuego (https://github.com/sgarciac/fuego)
	curl -L "$FUEGO_URL" -o "fuego.tar.gz" && \
	tar -xf "fuego.tar.gz"                 && \
	cd "fuego-${FUEGO_VERSION}"            && \
	go build                               && \
	mv "fuego" "/usr/bin/fuego"            && \
	cd "../"                               && \
	rm -rf fuego*                          && \
# terraform-docs (https://github.com/terraform-docs/terraform-docs)
	curl -L "$TFDOC_URL" -o "terraform-docs.tar.gz"   && \
	tar -xf "terraform-docs.tar.gz" "terraform-docs"  && \
	mv "terraform-docs" "/usr/bin/terraform-docs"     && \
	rm "terraform-docs.tar.gz"                        && \
# tfsec (https://github.com/aquasecurity/tfsec)
	curl -L "$TFSEC_URL" -o "tfsec.tar.gz" && \
	tar -xf "tfsec.tar.gz" "tfsec"         && \
	mv "tfsec" "/usr/bin/tfsec"            && \
	rm "tfsec.tar.gz"                      && \
# tflint (https://github.com/terraform-linters/tflint)
	curl -L "$TFLINT_URL" -o "tflint.zip" && \
	unzip -qq "tflint.zip"                && \
	chmod +x "tflint"                     && \
	mv "tflint" "/usr/bin/tflint"         && \
	rm "tflint.zip"                       && \
# Terragrunt (https://terragrunt.gruntwork.io/)
	curl -L "$TERRAGRUNT_URL" -o "terragrunt" && \
	chmod +x "terragrunt"                     && \
	mv "terragrunt" "/usr/bin/terragrunt"     && \
# Open Policy Agent (https://www.openpolicyagent.org/)
	curl -L "$OPA_URL" -o "opa" && \
	chmod +x "opa"              && \
	mv "opa" "/usr/bin/opa"     && \
# Delete caches
	apt-get clean               && \
	rm -rf /var/lib/apt/lists/* && \
	pip3 cache purge            && \
	go clean -cache             && \
	go clean -modcache          && \
	go clean -testcache         && \
	go clean -fuzzcache         && \
# Disable Python virtual environments warning
	rm "/usr/lib/python3.12/EXTERNALLY-MANAGED" && \
# Basic smoke test
	ansible --version          && \
	ansible-playbook --version && \
	aws --version              && \
	bash --version             && \
	cpanm --version            && \
	curl --version             && \
	dig -v                     && \
	figlet -v                  && \
	fuego --version            && \
	gcloud --version           && \
	gcr-cleaner-cli -version   && \
	git --version              && \
	go version                 && \
	helm version               && \
	kubectl help               && \
	lsb_release -a             && \
	mutt -v                    && \
	opa version                && \
	openssl version            && \
	packer --version           && \
	perl --version             && \
	pip3 --version             && \
	python3 --version          && \
	sentinel --version         && \
	shellcheck --version       && \
	skopeo -v                  && \
	ssh -V                     && \
	tar --version              && \
	terraform --version        && \
	terraform-docs --version   && \
	terragrunt --version       && \
	tflint --version           && \
	tfsec --version            && \
	unzip -v                   && \
	vault --version            && \
	zip -v

# If you're reading this and have any feedback on how this image could be
# improved, please open an issue or a pull request so we can discuss it!
#
#   https://github.com/Cyclenerd/cloud-tools-container