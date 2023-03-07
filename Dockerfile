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

FROM ubuntu:22.04

# Download URLs
ENV GCR_CLEANER_URL "https://github.com/GoogleCloudPlatform/gcr-cleaner/releases/download/v0.11.1/gcr-cleaner-cli_0.11.1_linux_amd64.tar.gz"
ENV FUEGO_URL       "https://github.com/sgarciac/fuego/releases/download/0.33.0/fuego_0.33.0_Linux_64-bit.tar.gz"

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

RUN set -eux; \
# Update list of available packages and upgrade
	apt-get update -yqq && apt-get upgrade -yqq; \
# Install base packages
	apt-get install -yqq apt-transport-https apt-utils build-essential ca-certificates curl git jq lsb-release tar mutt dnsutils; \
# Add Google Cloud repo
	curl "https://packages.cloud.google.com/apt/doc/apt-key.gpg" | apt-key --keyring "/usr/share/keyrings/cloud.google.gpg" add -; \
	echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a "/etc/apt/sources.list.d/google-cloud-sdk.list"; \
# Add Hashicorp/Terraform repo
	curl -fsSL "https://apt.releases.hashicorp.com/gpg" | apt-key --keyring "/usr/share/keyrings/releases-hashicorp.gpg" add -; \
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/releases-hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee -a "/etc/apt/sources.list.d/releases-hashicorp.list"; \
# Add Helm
	curl -fsSL "https://baltocdn.com/helm/signing.asc" | apt-key --keyring "/usr/share/keyrings/baltocdn-helm.gpg" add -; \
	echo "deb [signed-by=/usr/share/keyrings/baltocdn-helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee -a "/etc/apt/sources.list.d/helm-stable-debian.list"; \
# Install other tools
	apt-get update -yqq && apt-get install -yqq \
		google-cloud-cli \
		google-cloud-sdk-gke-gcloud-auth-plugin \
		terraform \
		ansible \
		kubectl \
		helm; \
# GCR Cleaner (https://github.com/GoogleCloudPlatform/gcr-cleaner)
	curl -L "$GCR_CLEANER_URL" -o "gcr-cleaner-cli.tar.gz"; \
	tar -xvf "gcr-cleaner-cli.tar.gz" "gcr-cleaner-cli"; \
	mv "gcr-cleaner-cli" "/usr/bin/gcr-cleaner-cli"; \
	rm "gcr-cleaner-cli.tar.gz"; \
	#git clone "https://github.com/GoogleCloudPlatform/gcr-cleaner.git"; \
	#cd gcr-cleaner; \
	#go build -a \
	#	-trimpath \
	#	-ldflags "-s -w -extldflags '-static'" \
	#	-tags 'osusergo netgo static_build' \
	#	-o /usr/bin/gcrcleaner \
	#	./cmd/gcr-cleaner-cli; \
	#cd .. ; \
	#rm -rf gcr-cleaner; \
# Fuego (https://github.com/sgarciac/fuego)
	curl -L "$FUEGO_URL" -o "fuego.tar.gz"; \
	tar -xvf "fuego.tar.gz" "fuego"; \
	mv "fuego" "/usr/bin/fuego"; \
	rm "fuego.tar.gz"; \
# Google Cloud CLI config
	gcloud config set "core/disable_usage_reporting" "true"; \
	gcloud config set "component_manager/disable_update_check" "true"; \
	gcloud config set "survey/disable_prompts" "true"; \
# Basic smoke test
	lsb_release -a; \
	gcloud --version; \
	terraform --version; \
	ansible --version; \
	mutt -v; \
	dig -v; \
	gcr-cleaner-cli -version; \
	fuego --version; \
# Delete apt cache
	apt-get clean; \
	rm -rf /var/lib/apt/lists/*

# If you're reading this and have any feedback on how this image could be
# improved, please open an issue or a pull request so we can discuss it!
#
#   https://github.com/Cyclenerd/google-cloud-gcp-tools-container