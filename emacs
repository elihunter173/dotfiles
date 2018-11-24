(require 'package)

; list of 'places' where emacs packages are. think of this as a list of repositories.
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

; enable evil-mode
(require 'evil)
(evil-mode t)
