;;(setq ring-bell-function 'ignore)

;; show line number
(global-linum-mode t)

(global-auto-revert-mode t)

;; disable auto-save and auto-backup
(setq auto-save-default nil)
(setq make-backup-files nil)

(recentf-mode t)
(setq recentf-max-menu-items 25)

(define-advice show-paren-function (:around (fn) fix-showparen-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (function fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn)))))

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; add delete section mode
(delete-selection-mode t)

(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)

	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indent selected region."))
      (progn
	(indent-buffer)
	(message "Indent buffer.")))))

(setq hippie-expand-try-functions-list '(try-expand-dabbrev
					 try-expand-dabbrev-all-buffers
					 try-expand-dabbrev-from-kill
					 try-complete-file-name-partially
					 try-complete-file-name
					 try-expand-all-abbrevs
					 try-expand-list
					 try-expand-line
					 try-complete-lisp-symbol-partially
					 try-complete-lisp-symbol))

(fset 'yes-or-no-p 'y-or-n-p)

;; always delete and copy recursively
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)

;; if there is a dired buffer displayed in the next window, use its
;; current subdir, instead of the current subdir of this dired buffer
(put 'dired-find-alternate-file 'disabled nil)

;; use C-x C-j to open current directory
(require 'dired-x)
(setq dired-dwim-target t)

(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;; dwim = do what i mean
(defun occur-dwim ()
  "Call 'occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	     (let ((sym (thing-at-point 'symbol)))
	       (when (stringp sym)
		 (regexp-quote sym))))
	  regexp-history)
	(call-interactively 'occur))



(provide 'init-better-defaults)
