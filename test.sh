#!/usr/bin/env bash

# Test container

MY_COMMANDS=(
	"ansible --version"
	"ansible-playbook --version"
	"aws --version"
	"bash --version"
	"cpanm --version"
	"curl --version"
	"dig -v"
	"figlet -v"
	"flake8 --version"
	"fuego --version"
	"gcloud --version"
	"gcr-cleaner-cli -version"
	"git --version"
	"go version"
	"hcloud version"
	"helm version"
	"jq --version"
	"kubectl help"
	"lsb_release -a"
	"mutt -v"
	"node -v"
	"npm -v"
	"opa version"
	"openssl version"
	"packer --version"
	"perl --version"
	"pip3 --version"
	"python3 --version"
	"shellcheck --version"
	"skopeo -v"
	"ssh -V"
	"tar --version"
	"terraform --version"
	"terraform-docs --version"
	"terragrunt --version"
	"tflint --version"
	"tfsec --version"
	"uname -m"
	"unzip -v"
	"vault --version"
	"yq --version"
	"zip -v"
)

for MY_COMMAND in "${MY_COMMANDS[@]}"
do
	# shellcheck disable=SC2086
	docker run cloud-tools-container $MY_COMMAND || exit 9
done
