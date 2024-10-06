To run a web application on google cloud do the follows

Start a Cloud Shell Editor

Copy from git, eg
```
git clone ...
```
Make sure entrypoint is called main.py:
```
cp git/pcap-maker/pcap_maker/*py .
cp runner.py main.py
```
Set the project:
```
gcloud config set project pcap-generate
```
To deploy run:
```
gcloud app deploy
```
