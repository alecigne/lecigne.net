publish:
    emacs --script publish.el -f alc-publish

deploy:
    rclone -v sync --exclude "/.git/" --exclude "/.htaccess" . OVH:www/
