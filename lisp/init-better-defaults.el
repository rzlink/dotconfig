;;(setq ring-bell-function 'ignore)

;; show line number
(global-linum-mode t)

(global-auto-revert-mode t)

;; disable auto-save and auto-backup
(setq auto-save-default nil)
(setq make-backup-files nil)

(recentf-mode t)
(setq recentf-max-menu-items 25)

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; add delete section mode
(delete-selection-mode t)

(provide 'init-better-defaults)
