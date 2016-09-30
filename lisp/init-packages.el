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
			  expand-region
			  iedit
			  org-pomodoro
			  helm-ag
			  auto-yasnippet
			  evil
			  evil-leader
			  window-numbering
			  evil-surround
			  evil-nerd-commenter
			  which-key
			  slime
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
(sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)

;; Config For swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

;; config for js2-mode
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode)
	 ("\\.html\\'" . web-mode))
       auto-mode-alist))

(global-company-mode t)

;; (load-theme 'monokai t)

(require 'moe-theme)
(moe-light)

(require 'popwin)
(popwin-mode t)

(evil-mode 1)
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map [escape] 'evil-normal-state)
(global-evil-leader-mode)

(evil-leader/set-key
  "ff" 'find-file
  "fr" 'recentf-open-files
  "bb" 'switch-to-buffer
  "bk" 'kill-buffer
  "pf" 'counsel-git
  "ps" 'helm-do-ag-project-root
  "wl" 'split-window-right
  "wb" 'split-window-below
  ":" 'counsel-M-x)

(window-numbering-mode 1)

(require 'evil-surround)
(global-evil-surround-mode 1)
(evilnc-default-hotkeys)
(define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
(which-key-mode)

(setq inferior-lisp-program "sbcl")
(setq slime-contribs '(slime-fancy))

(provide 'init-packages)
