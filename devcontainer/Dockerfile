# Copyright 2024 - 2025 Nils Knieling. All Rights Reserved.
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

# Cloud Tools container image optimized for Development Containers (https://containers.dev/)

# Architecture component of TARGETPLATFORM. Eg. amd64, arm64
# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
ARG TARGETARCH

# Ubuntu Development Containers container image with Git and other common utilities installed
# https://github.com/devcontainers/images/tree/main/src/base-ubuntu
FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04 AS base

# Set environment variables
ENV LANG="C.UTF-8" \
	DEBIAN_FRONTEND="noninteractive" \
	NONINTERACTIVE=1 \
# https://cloud.google.com/sdk/gcloud/reference/topic/startup
	PATH="/usr/bin/google-cloud-sdk/bin:$PATH" \
	CLOUDSDK_PYTHON="/usr/bin/python3" \
# https://github.com/sgarciac/fuego/releases
	FUEGO_VERSION="0.35.0" \
# https://github.com/GoogleCloudPlatform/gcr-cleaner/releases
	GCR_CLEANER_VERSION="0.12.2" \
# https://github.com/terraform-docs/terraform-docs/releases
	TFDOC_VERSION="0.19.0" \
# https://github.com/aquasecurity/tfsec/releases
	TFSEC_VERSION="1.28.11" \
# https://github.com/terraform-linters/tflint/releases
	TFLINT_VERSION="0.54.0"

FROM base AS amd64
# Download URLs for AMD64 (X86/64)
ENV AWS_CLI_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
	FUEGO_URL="https://github.com/sgarciac/fuego/archive/refs/tags/${FUEGO_VERSION}.tar.gz" \
	GCLOUD_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz" \
	GCR_CLEANER_URL="https://github.com/GoogleCloudPlatform/gcr-cleaner/releases/download/v${GCR_CLEANER_VERSION}/gcr-cleaner-cli_${GCR_CLEANER_VERSION}_linux_amd64.tar.gz" \
	HCLOUD_URL="https://github.com/hetznercloud/cli/releases/latest/download/hcloud-linux-amd64.tar.gz" \
	K9S_URL="https://github.com/derailed/k9s/releases/latest/download/k9s_linux_amd64.deb" \
	OPA_URL="https://github.com/open-policy-agent/opa/releases/latest/download/opa_linux_amd64_static" \
	TERRAGRUNT_URL="https://github.com/gruntwork-io/terragrunt/releases/latest/download/terragrunt_linux_amd64" \
	TFDOC_URL="https://github.com/terraform-docs/terraform-docs/releases/download/v${TFDOC_VERSION}/terraform-docs-v${TFDOC_VERSION}-linux-amd64.tar.gz" \
	TFLINT_URL="https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip" \
	TFSEC_URL="https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec_${TFSEC_VERSION}_linux_amd64.tar.gz" \
	YQ_URL="https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64"

FROM base AS arm64
# Download URLs for ARM64
ENV AWS_CLI_URL="https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" \
	FUEGO_URL="https://github.com/sgarciac/fuego/archive/refs/tags/${FUEGO_VERSION}.tar.gz" \
	GCLOUD_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-arm.tar.gz" \
	GCR_CLEANER_URL="https://github.com/GoogleCloudPlatform/gcr-cleaner/releases/download/v${GCR_CLEANER_VERSION}/gcr-cleaner-cli_${GCR_CLEANER_VERSION}_linux_arm64.tar.gz" \
	HCLOUD_URL="https://github.com/hetznercloud/cli/releases/latest/download/hcloud-linux-arm64.tar.gz" \
	K9S_URL="https://github.com/derailed/k9s/releases/latest/download/k9s_linux_arm64.deb" \
	OPA_URL="https://github.com/open-policy-agent/opa/releases/latest/download/opa_linux_arm64_static" \
	TERRAGRUNT_URL="https://github.com/gruntwork-io/terragrunt/releases/latest/download/terragrunt_linux_arm64" \
	TFDOC_URL="https://github.com/terraform-docs/terraform-docs/releases/download/v${TFDOC_VERSION}/terraform-docs-v${TFDOC_VERSION}-linux-arm64.tar.gz" \
	TFLINT_URL="https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_arm64.zip" \
	TFSEC_URL="https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec_${TFSEC_VERSION}_linux_arm64.tar.gz" \
	YQ_URL="https://github.com/mikefarah/yq/releases/latest/download/yq_linux_arm64"

FROM ${TARGETARCH} AS tools
# Install tools
RUN uname -m && \
	apt-get update -yq && \
	apt-get install -yqq \
		apt-transport-https \
		apt-utils \
		bind9-dnsutils \
		btop \
		build-essential \
		ca-certificates \
		cmatrix \
		cpanminus \
		curl \
		dnsutils \
		figlet \
		flake8 \
		git \
		golang-go \
		gpg \
		htop \
		iperf3 \
		iputils-ping \
		jq \
		linuxlogo \
		lsb-release \
		mc \
		mtr \
		mutt \
		nano \
		nodejs \
		npm \
		nyancat \
		openssh-client \
		python3-crcmod \
		python3-openssl \
		python3-pip \
		python3-venv \
		screen \
		shellcheck \
		skopeo \
		software-properties-common \
		tar \
		telnet \
		unzip \
		wget \
		zip && \
# Disable Python virtual environments warning
	printf "[global]\nbreak-system-packages = true" > "/etc/pip.conf" && \
# Add Google Cloud repository
	curl -fsSL "https://packages.cloud.google.com/apt/doc/apt-key.gpg" | gpg --dearmor -o "/usr/share/keyrings/cloud.google.gpg" && \
	echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a "/etc/apt/sources.list.d/google-cloud-sdk.list" && \
# Add Hashicorp repository
	curl -fsSL "https://apt.releases.hashicorp.com/gpg" | gpg --dearmor -o "/usr/share/keyrings/releases-hashicorp.gpg" && \
	echo "deb [signed-by=/usr/share/keyrings/releases-hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee -a "/etc/apt/sources.list.d/releases-hashicorp.list" && \
# Add Ansible PPA repository
	add-apt-repository "ppa:ansible/ansible" && \
# Add Helm repository
	curl -fsSL "https://baltocdn.com/helm/signing.asc" | gpg --dearmor -o "/usr/share/keyrings/baltocdn-helm.gpg" && \
	echo "deb [signed-by=/usr/share/keyrings/baltocdn-helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee -a "/etc/apt/sources.list.d/helm-stable-debian.list" && \
# Install tools
	apt-get update -yq && \
	apt-get install -yqq \
		helm \
		kubectl \
		packer \
		terraform \
		vault && \
# Fix "vault: Operation not permitted" error
# https://github.com/hashicorp/vault/issues/10924
	setcap -r "/usr/bin/vault" && \
# Ansible (https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible-with-pip)
	pip3 install ansible      && \
	pip3 install ansible-core && \
# AWS CLI (https://github.com/GoogleCloudPlatform/gcr-cleaner)
	echo "AWS CLI URL: '$AWS_CLI_URL'"                        && \
	curl -L "$AWS_CLI_URL" -o "awscliv2.zip"                  && \
	unzip -qq "awscliv2.zip"                                  && \
	./aws/install -b "/usr/local/bin" -i "/usr/local/aws-cli" && \
	rm -rf aws*                                               && \
# Fuego (https://github.com/sgarciac/fuego)
	curl -L "$FUEGO_URL" -o "fuego.tar.gz" && \
	tar -xf "fuego.tar.gz"                 && \
	cd "fuego-${FUEGO_VERSION}"            && \
	go build                               && \
	mv "fuego" "/usr/bin/fuego"            && \
	cd "../"                               && \
	rm -rf fuego*                          && \
# Google Cloud CLI (https://cloud.google.com/sdk/docs/install#linux)
	echo "Google Cloud CLI URL: '$GCLOUD_URL'"                && \
	curl -L "$GCLOUD_URL" -o "gcloud.tar.gz"                  && \
	tar -C "/usr/bin/" -xf "gcloud.tar.gz" "google-cloud-sdk" && \
	rm "gcloud.tar.gz"                                        && \
	if [ -d "/usr/bin/google-cloud-sdk/platform/bundledpythonunix" ]; then \
		rm -rf "/usr/bin/google-cloud-sdk/platform/bundledpythonunix"; \
	fi && \
	if [ -d "/usr/bin/google-cloud-sdkgoogle-cloud-sdk/.install" ]; then \
		rm -rf "/usr/bin/google-cloud-sdkgoogle-cloud-sdk/.install"; \
	fi && \
	gcloud components install -q "gke-gcloud-auth-plugin" && \
# GCR Cleaner (https://github.com/GoogleCloudPlatform/gcr-cleaner)
	curl -L "$GCR_CLEANER_URL" -o "gcr-cleaner-cli.tar.gz" && \
	tar -xf "gcr-cleaner-cli.tar.gz" "gcr-cleaner-cli"     && \
	mv "gcr-cleaner-cli" "/usr/bin/gcr-cleaner-cli"        && \
	rm "gcr-cleaner-cli.tar.gz"                            && \
# Hetzner Cloud CLI (https://github.com/hetznercloud/cli)
	echo "Hetzner Cloud CLI URL: '$HCLOUD_URL'"    && \
	curl -L "$HCLOUD_URL" -o "hcloud-linux.tar.gz" && \
	tar -xf "hcloud-linux.tar.gz" "hcloud"         && \
	mv "hcloud" "/usr/bin/hcloud"                  && \
	rm "hcloud-linux.tar.gz"                       && \
# K9s (https://k9scli.io/)
	echo "K9s URL: '$K9S_URL'"             && \
	curl -L "$K9S_URL" -o "k9s_linux.deb"  && \
	apt-get install -yqq "./k9s_linux.deb" && \
	rm "k9s_linux.deb"                     && \
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
	echo "Terragrunt URL: '$TERRAGRUNT_URL'"           && \
	curl -L "$TERRAGRUNT_URL" -o "/usr/bin/terragrunt" && \
	chmod +x "/usr/bin/terragrunt"                     && \
# Open Policy Agent (https://www.openpolicyagent.org/)
	curl -L "$OPA_URL" -o "opa" && \
	chmod +x "opa"              && \
	mv "opa" "/usr/bin/opa"     && \
# yq (https://github.com/mikefarah/yq)
	echo "yq URL: '$YQ_URL'"           && \
	curl -L "$YQ_URL" -o "/usr/bin/yq" && \
	chmod +x "/usr/bin/yq"             && \
# Delete caches
	echo "Clean up..." && \
	apt-get clean               && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/*               && \
	rm -rf "$HOME/.cache"       && \
	pip3 cache purge            && \
	go clean -cache             && \
	go clean -modcache          && \
	go clean -testcache         && \
	go clean -fuzzcache         && \
	npm cache clean --force     && \
# Delete all log file
	find /var/log -type f -delete && \
# Disable Python virtual environments warning
	printf "[global]\nbreak-system-packages = true" > "/etc/pip.conf" && \
# Basic smoke test
	echo "Versions..."         && \
	ansible --version          && \
	ansible-playbook --version && \
	aws --version              && \
	bash --version             && \
	cpanm --version            && \
	curl --version             && \
	dig -v                     && \
	figlet -v                  && \
	flake8 --version           && \
	fuego --version            && \
	gcloud --version           && \
	gcr-cleaner-cli -version   && \
	git --version              && \
	go version                 && \
	hcloud version             && \
	helm version               && \
	jq --version               && \
	k9s version --short        && \
	kubectl version --client   && \
	lsb_release -a             && \
	mutt -v                    && \
	node -v                    && \
	npm -v                     && \
	opa version                && \
	openssl version            && \
	packer --version           && \
	perl --version             && \
	pip3 --version             && \
	python3 --version          && \
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
	yq --version               && \
	zip -v

# If you're reading this and have any feedback on how this image could be
# improved, please open an issue or a pull request so we can discuss it!
#
#   https://github.com/Cyclenerd/cloud-tools-container
