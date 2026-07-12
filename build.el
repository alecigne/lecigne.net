(require 'ox-publish)

(setq make-backup-files nil
      org-html-validation-link nil
      org-html-head-include-default-style nil
      org-html-htmlize-output-type 'nil)

(setq alc-html-preamble
      (org-babel-with-temp-filebuffer "./top-menu.html" (buffer-string)))

(setq alc-org-export-html-head
      (concat "<link rel=\"stylesheet\" type=\"text/css\" href=\"/style.css\"/>\n"
              "<link rel=\"stylesheet\" type=\"text/css\" href=\"/assets/highlight/github.min.css\"/>\n"
              "<link rel=\"preload\" href=\"/assets/fonts/roboto-latin.woff2\" as=\"font\" type=\"font/woff2\" crossorigin/>\n"
              "<link rel=\"icon\" href=\"/favicon.ico\"/>\n"
              "<script defer src=\"/assets/highlight/highlight.min.js\"></script>\n"
              "<script defer src=\"/assets/highlight/lisp.min.js\"></script>\n"
              "<script defer src=\"/assets/highlight/org.js\"></script>"))

(setq org-publish-project-alist
      `(("org-static"
         :base-directory "./"
         :base-extension "png\\|jpg\\|gif\\|ico\\|css\\|js\\|woff2\\|txt"
         :publishing-directory "./build/"
         :exclude "\\`build/"
         :recursive t
         :publishing-function org-publish-attachment)
        ("org-html"
         :base-directory "./"
         :base-extension "org"
         :publishing-directory "./build/"
         :exclude "\\`\\(?:build/\\|README\\.org\\'\\|todo\\.org\\'\\)"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :with-toc nil
         :with-author nil
         :time-stamp-file nil
         :section-numbers t
         :html-head ,alc-org-export-html-head
         :html-preamble ,alc-html-preamble)
        ("website" :components ("org-html" "org-static"))))

(defun alc-build ()
  (org-publish "website" t))
