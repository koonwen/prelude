(prelude-require-packages
 '(utop
   ocp-indent ocamlformat
   dune dune-format
   merlin merlin-company merlin-eldoc merlin-iedit))

(use-package merlin
  :bind (:map merlin-mode-map
              ("C-c m d" . merlin-document)
              ("M-." . merlin-locate)
              ("M-," . merlin-pop-stack))
  :config (setq merlin-error-after-save t)
  :custom
  (merlin-completion-with-doc t)
  (merlin-locate-preference 1)
  (merlin-type-after-locate 1))

(use-package merlin-eldoc
  :after merlin
  :ensure t
  :custom
  (eldoc-echo-area-use-multiline-p t) ; use multiple lines when necessary
  (merlin-eldoc-max-lines 8)          ; but not more than 8
  (merlin-eldoc-type-verbosity 'min)  ; don't display verbose types
  (merlin-eldoc-function-arguments nil) ; don't show function arguments
  (merlin-eldoc-doc nil)                ; don't show the documentation
  :bind (:map merlin-mode-map
              ("C-c m p" . merlin-eldoc-jump-to-prev-occurrence)
              ("C-c m n" . merlin-eldoc-jump-to-next-occurrence))
  :hook ((tuareg-mode reason-mode) . merlin-eldoc-setup))

(use-package ocamlformat
  :bind ("<backtab>" . ocamlformat))

(use-package dune-format
  :hook (dune-mode . dune-format-on-save-mode))
