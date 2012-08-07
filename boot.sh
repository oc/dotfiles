brew install $(cat brews | xargs)

git submodule update --init

VIMCLJ="vimclojure-$(date +%Y%m%d)"
hg clone https://bitbucket.org/kotarak/vimclojure $VIMCLJ
cp -r $VIMCLJ/vim/ .vim/bundle/vimclojure

rsync --exclude .git --exclude my.cnf --exclude boot.sh --exclude vimclojure-* -avz . /Users/oc/

echo "REMEMBER: sudo cp my.cnf /etc/my.cnf"
