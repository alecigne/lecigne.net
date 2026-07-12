publish:
    emacs --script publish.el -f alc-publish

preview: publish
    python3 -m http.server --bind 127.0.0.1 --directory ~/pub/lecigne.net/ 8000

deploy:
    rclone -v sync --exclude "/.git/" . OVH:www/
