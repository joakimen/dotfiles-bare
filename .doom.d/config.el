
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Joakim Lindeng Engeset"
      user-mail-address "joakim.engeset@gmail.com")

(setq evil-escape-key-sequence "fd"
      evil-escape-delay 0.3)

(setq default-directory "~/")
(setq display-line-numbers-type t)
(setq compilation-scroll-output t)
(setq which-key-idle-delay 0.2)
(setq confirm-kill-emacs nil)
(setq mac-option-modifier nil)

;; automatically update buffer from filesystem
(global-auto-revert-mode t)
(add-hook 'dired-mode-hook 'auto-revert-mode)

(setq doom-font (font-spec :family "Iosevka Custom" :size 15)
      doom-theme 'doom-one-light)


(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

(defun jle/indent-buffer ()
  "removes trailing whitespace, indents buffer and replaces tabs with spaces" (interactive)
  (save-excursion
    (delete-trailing-whitespace)
    (indent-region (point-min) (point-max) nil)
    (untabify (point-min) (point-max))))

(after! counsel
  ;; open magit status buffer as default action when switching projects
  (setcar counsel-projectile-switch-project-action 13))

;; keybindings
(define-key evil-normal-state-map (kbd "C-e") 'er/expand-region)
(define-key evil-visual-state-map (kbd "C-e") 'er/expand-region)
(define-key evil-insert-state-map (kbd "C-e") 'er/expand-region)
(define-key evil-normal-state-map (kbd "C-l") 'jle/indent-buffer)
(define-key evil-normal-state-map (kbd "s--") 'evilnc-comment-or-uncomment-lines)

(global-set-key (kbd "s-!") 'shell-command)
(global-set-key (kbd "s--") 'evilnc-comment-or-uncomment-lines)

(setq projectile-project-search-path '("~/dev/oslo-kommune/projects"))

(after! forge
  :config
  (push '("github.oslo.kommune.no" "github.oslo.kommune.no/api/v3"
          "github.oslo.kommune.no" forge-github-repository)
        forge-alist))
