set dotenv-load := true

build:
    emacs --script build.el -f alc-build
    cp --preserve=timestamps .htaccess build/.htaccess

rebuild:
    rm -rf build
    emacs --script build.el -f alc-rebuild
    cp --preserve=timestamps .htaccess build/.htaccess

preview: build
    python3 -m http.server --bind 127.0.0.1 --directory build/ 8000

deploy-check: build
    rclone copy --config /dev/null --verbose --dry-run --sftp-ask-password --sftp-known-hosts-file "$HOME/.ssh/known_hosts" --sftp-host-key-algorithms ssh-ed25519 --sftp-shell-type none --sftp-host "${DEPLOY_TARGET#*@}" --sftp-user "${DEPLOY_TARGET%@*}" build/ ":sftp:${DEPLOY_PATH:?Set DEPLOY_PATH in .env}"

deploy: build
    rclone copy --config /dev/null --verbose --sftp-ask-password --sftp-known-hosts-file "$HOME/.ssh/known_hosts" --sftp-host-key-algorithms ssh-ed25519 --sftp-shell-type none --sftp-host "${DEPLOY_TARGET#*@}" --sftp-user "${DEPLOY_TARGET%@*}" build/ ":sftp:${DEPLOY_PATH:?Set DEPLOY_PATH in .env}"
