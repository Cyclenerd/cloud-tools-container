#!/usr/bin/env bash

# Test container

MY_COMMANDS=(
	"uname -m"
	"ansible --version"
	"ansible-playbook --version"
	"aws --version"
	"bash --version"
	"cpanm --version"
	"curl --version"
	"dig -v"
	"figlet -v"
	"fuego --version"
	"gcloud --version"
	"gcr-cleaner-cli -version"
	"git --version"
	"go version"
	"helm version"
	"kubectl help"
	"lsb_release -a"
	"mutt -v"
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
	"tflint --version"
	"tfsec --version"
	"unzip -v"
	"vault --version"
	"zip -v"
)

for MY_COMMAND in "${MY_COMMANDS[@]}"
do
	docker run cloud-tools-container "$MY_COMMAND" || exit 9
done