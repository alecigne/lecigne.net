build:
    rm -rf build
    emacs --script build.el -f alc-build
    cp .htaccess build/.htaccess

preview: build
    python3 -m http.server --bind 127.0.0.1 --directory build/ 8000

deploy: build
    rclone -v copy build/ OVH:www/
