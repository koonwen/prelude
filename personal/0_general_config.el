;; Unset flycheck mode
(global-flycheck-mode -1)
(remove-hook 'prog-mode 'flycheck-mode)

(prelude-require-packages
 '(beacon
   multiple-cursors
   twilight-bright-theme
   projectile-ripgrep
   helm-swoop
   goto-last-change
   treemacs treemacs-projectile treemacs-magit))

;; Default Zoom
(set-face-attribute 'default (selected-frame) :height 150)

(setq prelude-super-keybindings nil)
(setq crux-shell "/bin/fish")

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
(bind-key "C-c C-\\" #'toggle-themes)
(bind-key "C-c C-\\" #'toggle-themes)
(bind-key "<end>" 'scroll-lock-mode)
(bind-key "C-x 2" #'vsplit-other-window)
(bind-key "C-x 3" #'hsplit-other-window)
(bind-key "M-<right>" #'er/expand-region)
(bind-key "M-<left>" #'er/contract-region)

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

(blink-cursor-mode t)

;; Start activity-watch-mode
(global-activity-watch-mode t)

(use-package beacon
  :config (beacon-mode 1)
  :bind ("C-*" . beacon-blink)
  :custom
  (beacon-blink-when-focused 1)
  (beacon-color "#f6aa11"))

(use-package projectile
  :bind
  ([remap overwrite-mode] . projectile-commander)
  :custom (projectile-indexing-method 'hybrid))
(use-package projectile-ripgrep)


(use-package helm-swoop
  :bind
  ("M-s" . helm-swoop)
  ("M-S" . helm-multi-swoop-projectile)
  ("M-l" . helm-swoop-back-to-last-point))

;; (use-package helm-gtags
;;   :hook (prog-mode helm-gtags-mode))

(use-package treemacs
  :bind
  ("<home>" . treemacs))

(use-package goto-last-change)
(global-set-key "\C-x\C-\\" 'goto-last-change)

(use-package multiple-cursors)
(global-set-key (kbd "C-c m c") 'mc/edit-lines)
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)

;; https://ebzzry.com/en/emacs-pairs/
;; (bind-keys
;;  :map smartparens-mode-map
;;  ("C-M-a" . sp-beginning-of-sexp)
;;  ("C-M-e" . sp-end-of-sexp)

;;  ("C-<down>" . sp-down-sexp)
;;  ("C-<up>"   . sp-up-sexp)
;;  ("M-<down>" . sp-backward-down-sexp)
;;  ("M-<up>"   . sp-backward-up-sexp)

;;  ("C-M-f" . sp-forward-sexp)
;;  ("C-M-b" . sp-backward-sexp)

;;  ("C-M-n" . sp-next-sexp)
;;  ("C-M-p" . sp-previous-sexp)

;;  ("C-S-f" . sp-forward-symbol)
;;  ("C-S-b" . sp-backward-symbol)

;;  ("C-<right>" . sp-forward-slurp-sexp)
;;  ("M-<right>" . sp-forward-barf-sexp)
;;  ("C-<left>"  . sp-backward-slurp-sexp)
;;  ("M-<left>"  . sp-backward-barf-sexp)

;;  ("C-M-t" . sp-transpose-sexp)
;;  ("C-M-k" . sp-kill-sexp)
;;  ("C-k"   . sp-kill-hybrid-sexp)
;;  ("M-k"   . sp-backward-kill-sexp)
;;  ("C-M-w" . sp-copy-sexp)
;;  ("C-M-d" . delete-sexp)

;;  ("M-<backspace>" . backward-kill-word)
;;  ("C-<backspace>" . sp-backward-kill-word)
;;  ([remap sp-backward-kill-word] . backward-kill-word)

;;  ("M-[" . sp-backward-unwrap-sexp)
;;  ("M-]" . sp-unwrap-sexp)

;;  ("C-x C-t" . sp-transpose-hybrid-sexp)

;;  ("C-c ("  . wrap-with-parens)
;;  ("C-c ["  . wrap-with-brackets)
;;  ("C-c {"  . wrap-with-braces)
;;  ("C-c '"  . wrap-with-single-quotes)
;;  ("C-c \"" . wrap-with-double-quotes)
;;  ("C-c _"  . wrap-with-underscores)
;;  ("C-c `"  . wrap-with-back-quotes))
