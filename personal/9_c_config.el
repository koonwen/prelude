;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
(use-package helm-xref)

(helm-descbinds-mode -1)
(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(use-package yasnippet
  :config (yas-global-mode t))

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(use-package lsp-mode
  :bind-keymap ("C-c l" . lsp-command-map))
