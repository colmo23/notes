A pipeline consists of agent and one of more stages. Each stage has one or more steps.
  A pipeline can also have an options section and post section (run at the end)

An agent specificies where steps will be run, eg docker, label 'linux'

A jenkins controller can make use of external nodes to run tests on. Node needs an agent to communicate with jenkins

ssh node needs java installed to run agent

Artifacts: builds or test results files

Test reports - need to use junit format

Sample jenkins file: https://github.com/LinkedInLearning/essential-jenkins-2468076/blob/main/Ch05/05_03-using-test-results/Jenkinsfile

