Infrastructure as code - linkedinlearning

declaritive - say what to do - eg terraform
imperative - say how to do it - eg scripts, ansible

terraform
kubespray
terraform validate
terraform plan # does a dry run of it
terraform apply # create the aws vms

terra-test and kitchen terraform can be used for CI/CD of terraform systems

ansible-playbook ansible_version.yml

helm lint
helm template --validate --debug wordcloud

Serverless framework provides automation of serverless application like those that run on aws lambda:
 https://www.serverless.com/pricing

Deploy as close as possible to production

https://en.wikipedia.org/wiki/Runbook - instructions for how to install/debug

https://rerun.github.io/rerun/ - bash scripting framework

github actions

https://opengitops.dev/   # gitops principles

Git pre-commit hooks - easy to check things before allowed a git push request like linter or having a ticket number
Use short living branhes, commit to master often. Use feature flags to turn off uncompleted stuff

git show <commit id>   - show all changes for a commit

./hooks/git-pre-commit.hook

datadog - 

shift left - move a much testing to the earlier stage of development. eg cheaper to run unit tests than integrations tests

Rundeck - alternative to ansible https://www.rundeck.com/

Devops foundations
Devops site reliability


