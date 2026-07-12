(function () {
  var languageAliases = {
    'bash': 'bash',
    'conf': 'ini',
    'elisp': 'lisp',
    'emacs-lisp': 'lisp',
    'fennel': 'lisp',
    'lisp': 'lisp',
    'sh': 'bash'
  };

  function highlightOrgBlocks() {
    document.querySelectorAll('pre.src').forEach(function (block) {
      var orgLanguage;

      block.classList.forEach(function (className) {
        if (className.indexOf('src-') === 0) {
          orgLanguage = className.slice(4);
        }
      });

      var language = languageAliases[orgLanguage] || orgLanguage;
      if (language && hljs.getLanguage(language)) {
        block.classList.add('language-' + language);
      }

      hljs.highlightElement(block);
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', highlightOrgBlocks);
  } else {
    highlightOrgBlocks();
  }
}());
