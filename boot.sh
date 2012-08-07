brew install $(cat brews | xargs)

git submodule update --init

hg clone https://bitbucket.org/kotarak/vimclojure .vim/bundle/vimclojure

rsync --exclude .git --exclude my.cnf --exclude boot.sh -avz . /Users/oc/

echo "REMEMBER: sudo cp my.cnf /etc/my.cnf"
