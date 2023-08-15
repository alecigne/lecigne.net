(require 'ox-publish)

(setq make-backup-files nil
      org-html-validation-link nil
      org-latex-packages-alist '(("margin=2cm" "geometry" nil))
      org-latex-compiler "xelatex")

(setq alc-html-preamble
      (org-babel-with-temp-filebuffer "./top-menu.html" (buffer-string)))

(setq alc-org-export-html-head
      (concat "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://lecigne.net/style.css\"/>\n"
              "<link rel=\"icon\" href=\"https://lecigne.net/favicon.ico\"/>"
              "<link href=\"https://fonts.googleapis.com/css2?family=Roboto&display=swap\" rel=\"stylesheet\">\n"
              "<link href=\"https://fonts.googleapis.com/css2?family=Baloo+Chettan+2&display=swap\" rel=\"stylesheet\">"))

(setq org-publish-project-alist
      `(("org-html"
         :base-directory "./"
         :base-extension "org"
         :publishing-directory "./"
         :recursive t
         :publishing-function org-html-publish-to-html
	 :headline-levels 4
         :with-toc nil
         :with-author nil
         :time-stamp-file nil
         :section-numbers t
         :html-head ,alc-org-export-html-head
         :html-preamble ,alc-html-preamble)
	("website" :components ("org-html"))))

(defun alc-publish ()
  (org-publish "website" t))
