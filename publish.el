(require 'ox-publish)

(setq make-backup-files nil
      org-html-validation-link nil
      org-latex-packages-alist '(("margin=2cm" "geometry" nil)
				 ("" "times" nil)))

(add-to-list 'org-latex-logfiles-extensions "tex")

(setq swanemacs-html-preamble
      (org-babel-with-temp-filebuffer "./top-menu.html" (buffer-string)))

(setq swanemacs-org-export-html-head
      (concat "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://lecigne.net/style.css\"/>\n"
              "<link rel=\"icon\" href=\"https://lecigne.net/favicon.ico\"/>"
              "<link href=\"https://fonts.googleapis.com/css2?family=Roboto&display=swap\" rel=\"stylesheet\">\n"
              "<link href=\"https://fonts.googleapis.com/css2?family=Baloo+Chettan+2&display=swap\" rel=\"stylesheet\">"))

(setq org-publish-project-alist
      `(("emacs"
         :base-directory ,user-emacs-directory
         :base-extension "org"
         :publishing-directory "./notes/emacs/"
         :recursive t
         :publishing-function org-org-publish-to-org
         :exclude "elpa")
	("org-html"
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
         :html-head ,swanemacs-org-export-html-head
         :html-preamble ,swanemacs-html-preamble)
	("org-pdf"
         :base-directory "./notes/"
         :base-extension "org"
         :exclude "notes.org" ; index
         :publishing-directory "./notes/"
         :recursive nil
         :publishing-function org-latex-publish-to-pdf
	 :headline-levels 4
         :with-toc nil
         :with-author t
         :time-stamp-file nil
         :section-numbers t)
	("org-txt"
         :base-directory "./notes/"
         :base-extension "org"
         :exclude "notes.org" ; index
         :publishing-directory "./notes/"
         :recursive nil
         :publishing-function org-ascii-publish-to-ascii
	 :headline-levels 4
         :with-toc nil
         :with-author t
         :time-stamp-file nil
         :section-numbers t)
	("website" :components ("emacs" "org-html" "org-pdf" "org-txt"))))

(defun swanemacs-publish ()
  (org-publish "website" t))
