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

# Cloud Workstations base editor, Code OSS for Cloud Workstations, based on Code-OSS
# https://cloud.google.com/workstations/docs/preconfigured-base-images
FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest

# Set environment variables
ENV LANG="C.UTF-8" \
	DEBIAN_FRONTEND="noninteractive" \
	NONINTERACTIVE=1 \
# https://github.com/sgarciac/fuego/releases
	FUEGO_VERSION="0.35.0" \
# https://github.com/GoogleCloudPlatform/gcr-cleaner/releases
	GCR_CLEANER_VERSION="0.12.2" \
# https://github.com/terraform-docs/terraform-docs/releases
	TFDOC_VERSION="0.19.0" \
# https://github.com/terraform-linters/tflint/releases
	TFLINT_VERSION="0.54.0" \
# https://github.com/aquasecurity/tfsec/releases
	TFSEC_VERSION="1.28.11" \
# https://open-vsx.org/extension/dracula-theme/theme-dracula
	VSX_DRACULA_VERSION="2.25.1" \
# https://open-vsx.org/extension/GitLab/gitlab-workflow
	VSX_GITLAB_VERSION="5.15.0" \
# https://open-vsx.org/extension/hashicorp/terraform
	VSX_TERRAFORM_VERSION="2.32.3" \
# https://open-vsx.org/extension/vscode-icons-team/vscode-icons
	VSX_ICONS_VERSION="12.9.0" \
# https://open-vsx.org/extension/ms-azuretools/vscode-docker
	VSX_DOCKER_VERSION="1.29.3"

# Download URLs for AMD64 (X86/64)
ENV AWS_CLI_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
	FUEGO_URL="https://github.com/sgarciac/fuego/archive/refs/tags/${FUEGO_VERSION}.tar.gz" \
	GCR_CLEANER_URL="https://github.com/GoogleCloudPlatform/gcr-cleaner/releases/download/v${GCR_CLEANER_VERSION}/gcr-cleaner-cli_${GCR_CLEANER_VERSION}_linux_amd64.tar.gz" \
	HCLOUD_URL="https://github.com/hetznercloud/cli/releases/latest/download/hcloud-linux-amd64.tar.gz" \
	OPA_URL="https://github.com/open-policy-agent/opa/releases/latest/download/opa_linux_amd64_static" \
	TERRAGRUNT_URL="https://github.com/gruntwork-io/terragrunt/releases/latest/download/terragrunt_linux_amd64" \
	TFDOC_URL="https://github.com/terraform-docs/terraform-docs/releases/download/v${TFDOC_VERSION}/terraform-docs-v${TFDOC_VERSION}-linux-amd64.tar.gz" \
	TFLINT_URL="https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip" \
	TFSEC_URL="https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec_${TFSEC_VERSION}_linux_amd64.tar.gz" \
	VSX_DRACULA_URL="https://open-vsx.org/api/dracula-theme/theme-dracula/${VSX_DRACULA_VERSION}/file/dracula-theme.theme-dracula-${VSX_DRACULA_VERSION}.vsix" \
	VSX_GITLAB_URL="https://open-vsx.org/api/GitLab/gitlab-workflow/${VSX_GITLAB_VERSION}/file/GitLab.gitlab-workflow-${VSX_GITLAB_VERSION}.vsix" \
	VSX_TERRAFORM_URL="https://open-vsx.org/api/hashicorp/terraform/linux-x64/${VSX_TERRAFORM_VERSION}/file/hashicorp.terraform-${VSX_TERRAFORM_VERSION}@linux-x64.vsix" \
	VSX_ICONS_URL="https://open-vsx.org/api/vscode-icons-team/vscode-icons/${VSX_ICONS_VERSION}/file/vscode-icons-team.vscode-icons-${VSX_ICONS_VERSION}.vsix" \
	VSX_DOCKER_URL="https://open-vsx.org/api/ms-azuretools/vscode-docker/${VSX_DOCKER_VERSION}/file/ms-azuretools.vscode-docker-${VSX_DOCKER_VERSION}.vsix"

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
# Add Hashicorp repository
	curl -fsSL "https://apt.releases.hashicorp.com/gpg" | gpg --dearmor -o "/usr/share/keyrings/releases-hashicorp.gpg" && \
	echo "deb [signed-by=/usr/share/keyrings/releases-hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee -a "/etc/apt/sources.list.d/releases-hashicorp.list" && \
# Install tools
	apt-get update -yq && \
	apt-get install -yqq \
		helm \
		kubectl \
		packer \
		terraform \
		vault && \
# Install Google Cloud CLI without Anthos
	apt-get install -yqq --no-install-recommends \
		google-cloud-cli \
		google-cloud-sdk-gke-gcloud-auth-plugin && \
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
# Firebase (https://firebase.tools/)
	curl -L "https://firebase.tools/bin/linux/latest" -o "/usr/bin/firebase" && \
	chmod +x "/usr/bin/firebase" && \
# Fuego (https://github.com/sgarciac/fuego)
	curl -L "$FUEGO_URL" -o "fuego.tar.gz" && \
	tar -xf "fuego.tar.gz"                 && \
	cd "fuego-${FUEGO_VERSION}"            && \
	go build                               && \
	mv "fuego" "/usr/bin/fuego"            && \
	cd "../"                               && \
	rm -rf fuego*                          && \
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
# Code OSS extensions
# Terraform
	curl -L "$VSX_TERRAFORM_URL" -o "hashicorp.terraform.vsix" && \
	unzip "hashicorp.terraform.vsix" "extension/*" && \
	mv "extension" "/opt/code-oss/extensions/hashicorp.terraform-${VSX_TERRAFORM_VERSION}}-linux-x64" && \
# GitLab
	curl -L "$VSX_GITLAB_URL" -o "GitLab.gitlab-workflow.vsix" && \
	unzip "GitLab.gitlab-workflow.vsix" "extension/*" && \
	mv "extension" "/opt/code-oss/extensions/gitlab.gitlab-workflow-${VSX_GITLAB_VERSION}}" && \
# Dracula Theme
	curl -L "$VSX_DRACULA_URL" -o "dracula-theme.theme-dracula.vsix" && \
	unzip "dracula-theme.theme-dracula.vsix" "extension/*" && \
	mv "extension" "/opt/code-oss/extensions/dracula-theme.theme-dracula-${VSX_DRACULA_VERSION}}" && \
# Docker
	curl -L "$VSX_DOCKER_URL" -o "ms-azuretools.vscode-docker.vsix" && \
	unzip "ms-azuretools.vscode-docker.vsix" "extension/*" && \
	mv "extension" "/opt/code-oss/extensions/ms-azuretools.vscode-docker-${VSX_DOCKER_VERSION}" && \
# vscode-icons
	curl -L "$VSX_ICONS_URL" -o "vscode-icons-team.vscode-icons.vsix" && \
	unzip "vscode-icons-team.vscode-icons.vsix" "extension/*" && \
	mv "extension" "/opt/code-oss/extensions/vscode-icons-team.vscode-icons-${VSX_ICONS_VERSION}" && \
# Delete Code OSS install files
	rm -rf "*.vsix" && \
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
	firebase --version         && \
	fuego --version            && \
	gcloud --version           && \
	gcr-cleaner-cli -version   && \
	git --version              && \
	go version                 && \
	hcloud version             && \
	helm version               && \
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
	zip -v

# If you're reading this and have any feedback on how this image could be
# improved, please open an issue or a pull request so we can discuss it!
#
#   https://github.com/Cyclenerd/cloud-tools-container
