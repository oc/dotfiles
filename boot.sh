brew install $(cat brews | xargs)

git submodule update --init

rsync --exclude .git --exclude my.cnf --exclude boot.sh -avz . /Users/oc/

echo "REMEMBER: sudo cp my.cnf /etc/my.cnf"
