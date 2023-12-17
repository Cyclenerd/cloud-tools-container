# Copyright 2022-2023 Nils Knieling. All Rights Reserved.
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

# See supported Ubuntu version of HashiCorp:
# https://www.hashicorp.com/official-packaging-guide?product_intent=terraform
# The ubuntu:lunar tag points to the 23.04 release
FROM ubuntu:lunar

# Download URLs
# https://github.com/GoogleCloudPlatform/gcr-cleaner/releases
ENV GCR_CLEANER_URL "https://github.com/GoogleCloudPlatform/gcr-cleaner/releases/download/v0.11.1/gcr-cleaner-cli_0.11.1_linux_amd64.tar.gz"
# https://github.com/sgarciac/fuego/releases
ENV FUEGO_URL "https://github.com/sgarciac/fuego/releases/download/0.34.0/fuego_0.34.0_Linux_64-bit.tar.gz"
# https://github.com/terraform-docs/terraform-docs/releases
ENV TFDOC_URL "https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-linux-amd64.tar.gz"
# https://github.com/aquasecurity/tfsec/releases
ENV TFSEC_URL "https://github.com/aquasecurity/tfsec/releases/download/v1.28.4/tfsec_1.28.4_linux_amd64.tar.gz"
# https://github.com/terraform-linters/tflint/releases
ENV TFLINT_URL "https://github.com/terraform-linters/tflint/releases/download/v0.49.0/tflint_linux_amd64.zip"

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# Set debconf frontend to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Labels
LABEL org.opencontainers.image.title         "Docker Container with Tools optimized Google Cloud"
LABEL org.opencontainers.image.description   "The following software and tools are included: gcloud, terraform, ansible, kubectl, helm"
LABEL org.opencontainers.image.url           "https://hub.docker.com/r/cyclenerd/google-cloud-gcp-tools-container"
LABEL org.opencontainers.image.authors       "https://github.com/Cyclenerd/google-cloud-gcp-tools-container/graphs/contributors"
LABEL org.opencontainers.image.documentation "https://github.com/Cyclenerd/google-cloud-gcp-tools-container/blob/master/README.md"
LABEL org.opencontainers.image.source        "https://github.com/Cyclenerd/google-cloud-gcp-tools-container"

# Disable any healthcheck inherited from the base image
HEALTHCHECK NONE

RUN apt-get update -yq && \
	apt-get upgrade -yq && \
# Install base packages
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
		gpg \
		jq \
		lsb-release \
		mutt \
		python3-pip \
		shellcheck \
		skopeo \
		tar \
		unzip \
		zip && \
# Add Google Cloud repo
	curl -fsSL "https://packages.cloud.google.com/apt/doc/apt-key.gpg" | gpg --dearmor -o "/usr/share/keyrings/cloud.google.gpg" && \
	echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a "/etc/apt/sources.list.d/google-cloud-sdk.list" && \
# Add Hashicorp/Terraform repo
	curl -fsSL "https://apt.releases.hashicorp.com/gpg" | gpg --dearmor -o "/usr/share/keyrings/releases-hashicorp.gpg" && \
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/releases-hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee -a "/etc/apt/sources.list.d/releases-hashicorp.list" && \
# Add Helm
	curl -fsSL "https://baltocdn.com/helm/signing.asc" | gpg --dearmor -o "/usr/share/keyrings/baltocdn-helm.gpg" && \
	echo "deb [signed-by=/usr/share/keyrings/baltocdn-helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee -a "/etc/apt/sources.list.d/helm-stable-debian.list" && \
# Install other tools
	apt-get update -yq && \
	apt-get install -yqq \
		google-cloud-cli \
		google-cloud-sdk-gke-gcloud-auth-plugin \
		terraform \
		packer \
		vault \
		ansible \
		kubectl \
		helm && \
# GCR Cleaner (https://github.com/GoogleCloudPlatform/gcr-cleaner)
	curl -L "$GCR_CLEANER_URL" -o "gcr-cleaner-cli.tar.gz" && \
	tar -xvf "gcr-cleaner-cli.tar.gz" "gcr-cleaner-cli"    && \
	mv "gcr-cleaner-cli" "/usr/bin/gcr-cleaner-cli"        && \
	rm "gcr-cleaner-cli.tar.gz"                            && \
# Fuego (https://github.com/sgarciac/fuego)
	curl -L "$FUEGO_URL" -o "fuego.tar.gz" && \
	tar -xvf "fuego.tar.gz" "fuego"        && \
	mv "fuego" "/usr/bin/fuego"            && \
	rm "fuego.tar.gz"                      && \
# terraform-docs (https://github.com/terraform-docs/terraform-docs)
	curl -L "$TFDOC_URL" -o "terraform-docs.tar.gz"   && \
	tar -xvf "terraform-docs.tar.gz" "terraform-docs" && \
	mv "terraform-docs" "/usr/bin/terraform-docs"     && \
	rm "terraform-docs.tar.gz"                        && \
# tfsec (https://github.com/aquasecurity/tfsec)
	curl -L "$TFSEC_URL" -o "tfsec.tar.gz" && \
	tar -xvf "tfsec.tar.gz" "tfsec"        && \
	mv "tfsec" "/usr/bin/tfsec"            && \
	rm "tfsec.tar.gz"                      && \
# tflint (https://github.com/terraform-linters/tflint)
	curl -L "$TFLINT_URL" -o "tflint.zip" && \
	unzip "tflint.zip"                    && \
	chmod +x "tflint"                     && \
	mv "tflint" "/usr/bin/tflint"         && \
	rm "tflint.zip"                       && \
# Google Cloud CLI config
	gcloud config set "core/disable_usage_reporting" "true"           && \
	gcloud config set "component_manager/disable_update_check" "true" && \
	gcloud config set "survey/disable_prompts" "true"                 && \
# Basic smoke test
	ansible --version        && \
	bash --version           && \
	cpanm --version          && \
	dig -v                   && \
	figlet -v                && \
	fuego --version          && \
	gcloud --version         && \
	gcr-cleaner-cli -version && \
	lsb_release -a           && \
	mutt -v                  && \
	openssl version          && \
	packer --version         && \
	perl --version           && \
	python3 --version        && \
	shellcheck --version     && \
	skopeo -v                && \
	ssh -V                   && \
	terraform --version      && \
	terraform-docs --version && \
	tflint --version         && \
	tfsec --version          && \
	vault --version          && \
# Delete apt cache
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# If you're reading this and have any feedback on how this image could be
# improved, please open an issue or a pull request so we can discuss it!
#
#   https://github.com/Cyclenerd/google-cloud-gcp-tools-container