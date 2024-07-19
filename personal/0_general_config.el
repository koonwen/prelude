;; Unset flycheck mode
(global-flycheck-mode -1)
(remove-hook 'prog-mode 'flycheck-mode)

(prelude-require-packages
 '(beacon
   twilight-bright-theme
   helm-swoop))

;; Default Zoom
(set-face-attribute 'default (selected-frame) :height 150)

;; Sane Defaults
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)

(blink-cursor-mode t)
(setq prelude-super-keybindings nil)
(setq crux-shell "/bin/bash")

(defun vsplit-other-window ()
  "Splits the window vertically and switches to that window."
  (interactive)
  (split-window-vertically)
  (other-window 1 nil))
(defun hsplit-other-window ()
  "Splits the window horizontally and switches to that window."
  (interactive)
  (split-window-horizontally)
  (other-window 1 nil))

;; Highlight line on point.
(global-hl-line-mode t)

;; Show line numbers on left column
(global-display-line-numbers-mode t)

;; Make sure use-package always downloads the package first
(require 'use-package)
(setq use-package-always-ensure t)

;; Themes
(use-package twilight-bright-theme)
(use-package flatland-theme)
(defun toggle-themes ()
  "Allow quick toggling between dark and light themes."
  (interactive)
  (if (member 'twilight-bright custom-enabled-themes)
      (progn
	(load-theme 'flatland t)
	(disable-theme 'twilight-bright))
    (load-theme 'twilight-bright t)
    (disable-theme 'flatland)))

;; Keybindings
(bind-key "C-x 2" #'vsplit-other-window)
(bind-key "C-x 3" #'hsplit-other-window)
(bind-key "M-S-C-<left>" #'shrink-window-horizontally)
(bind-key "M-S-C-<right>" #'enlarge-window-horizontally)
(bind-key "M-S-C-<down>" #'shrink-window)
(bind-key "M-S-C-<up>" #'enlarge-window)
(bind-key "<end>" 'scroll-lock-mode)

;; Automatic reloading of buffers
(global-auto-revert-mode t)
(setq global-auto-revert-non-file-buffers t)
(add-to-list 'global-auto-revert-ignore-modes 'Buffer-menu-mode)

(if (version<= emacs-version "28.1") nil
  (use-package ligature
    :ensure t
    :config
    (set-frame-font "Fira Code Retina-16" nil t)
    ;; Enable the www ligature in every possible major mode
    (ligature-set-ligatures 't '("www"))
    ;; Enable ligatures in programming modes
    (ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
				         ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
				         "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
				         "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
				         "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
				         "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
				         "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
				         "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
				         "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
				         "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))
    (global-ligature-mode 't))
  )

;; Background modes

(use-package undo-tree
  :delight
  :config
  (global-undo-tree-mode)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/backups/undo-tree"))))

(use-package beacon
  :delight
  :config (beacon-mode t)
  :custom
  (beacon-blink-when-focused 1)
  (beacon-color "#f6aa11"))

(global-set-key [remap crux-smart-open-line] 'ace-window)
(use-package ace-window
  :bind ("C-M-o" . ace-swap-window))

(use-package projectile
  :delight
  :bind
  ([remap overwrite-mode] . projectile-commander)
  :custom (projectile-indexing-method 'hybrid))

(use-package helm-swoop
  :delight
  :bind
  ("M-s" . helm-swoop)
  ("M-S" . helm-multi-swoop-projectile)
  ("M-l" . helm-swoop-back-to-last-point))

(use-package helm
  :delight)

(use-package move-text
  :config (move-text-default-bindings))

(use-package iedit
  :bind*
  ("C-c e" . iedit-mode)
  (:map iedit-mode-keymap
        ("M-h" . 'iedit-show/hide-context-lines))
  (:map iedit-mode-occurrence-keymap
        ("M-F" . 'iedit-restrict-function)))

(use-package expand-region
  :bind ("M-=" . er/expand-region))

(use-package paren
  ;; "Highlighting for parens"
  :custom
  (show-paren-delay 0.3)
  (blink-matching-paren t)
  (blink-matching-paren-on-screen t)
  (show-paren-style 'expression)
  (blink-matching-paren-dont-ignore-comments t)
  :config (show-paren-mode))
