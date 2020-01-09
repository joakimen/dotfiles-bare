(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(org-babel-load-file "~/.emacs.d/configuration.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
	 [default bold shadow italic underline bold bold-italic bold])
 '(beacon-color "#cc6666")
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(fci-rule-color "#5E5E5E")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
	 (--map
		(solarized-color-blend it "#002b36" 0.25)
		(quote
		 ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
	 (quote
		(("#073642" . 0)
		 ("#546E00" . 20)
		 ("#00736F" . 30)
		 ("#00629D" . 50)
		 ("#7B6000" . 60)
		 ("#8B2C02" . 70)
		 ("#93115C" . 85)
		 ("#073642" . 100))))
 '(hl-bg-colors
	 (quote
		("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
	 (quote
		("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(nrepl-message-colors
	 (quote
		("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
	 (quote
		(ripgrep forge doom-themes minions avy plan9-theme flatui-theme markdown-mode projectile solarized-theme nord-theme zerodark-theme gruvbox-theme hc-zenburn-theme evil-magit evil-leader yasnippet which-key use-package smex rainbow-delimiters paredit org-bullets magit flycheck flx exec-path-from-shell evil-surround evil-org evil-escape counsel company color-theme-sanityinc-tomorrow auto-compile ag)))
 '(pdf-view-midnight-colors (quote ("#fdf4c1" . "#1d2021")))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background "#202020")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
	 (quote
		((20 . "#C99090")
		 (40 . "#D9A0A0")
		 (60 . "#ECBC9C")
		 (80 . "#DDCC9C")
		 (100 . "#EDDCAC")
		 (120 . "#FDECBC")
		 (140 . "#6C8C6C")
		 (160 . "#8CAC8C")
		 (180 . "#9CBF9C")
		 (200 . "#ACD2AC")
		 (220 . "#BCE5BC")
		 (240 . "#CCF8CC")
		 (260 . "#A0EDF0")
		 (280 . "#79ADB0")
		 (300 . "#89C5C8")
		 (320 . "#99DDE0")
		 (340 . "#9CC7FB")
		 (360 . "#E090C7"))))
 '(vc-annotate-very-old-color "#E090C7")
 '(weechat-color-list
	 (quote
		(unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(window-divider-mode nil)
 '(xterm-color-names
	 ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
	 ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
