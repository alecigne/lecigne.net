.DEFAULT_GOAL := export

export:
	@echo "Exporting..."
	@emacs --script publish.el -f alc-publish

publish:
	@echo "Publishing..."
	@rclone -v sync --exclude "/.git/" --exclude "/.htaccess" . OVH:www/
