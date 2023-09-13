# Memeorystore


https://github.com/infinite-Joy/retwis-py.git


```
#Â Set up the VM

sudo apt-get update
sudo apt-get install build-essential python3-dev libncurses5-dev virtualenv
virtualenv venv -p python 3.7
cd venv
source bin/activate

# Install Retwis

git clone https://github.com/infinite-Joy/retwis-py.git
cd retwis-py
pip install -r requirements.txt

# Now make changes to settings.py and runserver.py
# as specified in the video

# Run the server

python runserver.py

# Install Redis CLI

sudo apt-get install redis-tools

# Get the IP of your Redis instance from settings.py
# Then connect the CLI

redis-cli -h <your redis instance IP>

# Some basic redis-cli commands

INFO
INFO keyspace

```

```
sudo apt update
sudo apt-get install build-essential python3-dev libncurses5-dev virtualenv
virtualenv venv -p python3.9
cd venv/
source bin/activate
git clone https://github.com/infinite-Joy/retwis-py.git
sudo apt install git
git clone https://github.com/infinite-Joy/retwis-py.git
ls
cd retwis-py/
ls
cat requirements.txt 
pip install -r requirements.txt
ls
cd retwis/
ls
vim settings.py 
cd ..
ls
cat runserver.py 
vim runserver.py 
python runserver.py 
sudo apt-get install redis-tools
redis-cli -h 10.91.110.3
python runserver.py 
```