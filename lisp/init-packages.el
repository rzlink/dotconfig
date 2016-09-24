(require 'cl)

(when (>= emacs-major-version 24)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  )

;; add whatever packages you want here
(defvar davwei/packages '(
			  company
			  monokai-theme
			  swiper
			  counsel
			  smartparens
			  js2-mode
			  moe-theme
			  popwin
			  web-mode
			  ) "Default packages")

(setq package-selected-packages davwei/packages)

(defun davwei/packages-installed-p()
  (loop for pkg in davwei/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (davwei/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg davwei/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

(smartparens-global-mode t)
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)

;; Config For swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

;; config for js2-mode
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

(global-company-mode t)

;; (load-theme 'monokai t)

(require 'moe-theme)
(moe-light)

(require 'popwin)
(popwin-mode t)

(provide 'init-packages)
