(prelude-require-packages
 '(utop
   opam-switch-mode
   ocp-indent ocamlformat
   dune dune-format
   merlin merlin-company merlin-eldoc merlin-iedit))

(use-package ocp-index
  :config (unbind-key "C-c C-t" ocp-index-keymap)
  :bind (:map ocp-index-keymap
              ("C-c t" . ocp-index-print-info-at-point)))

(use-package merlin
  :bind (:map merlin-mode-map
              ("C-c m d" . merlin-document)
              ("M-." . merlin-locate)
              ("M-," . merlin-pop-stack))
  :config (setq merlin-error-after-save t)
  :custom
  (merlin-error-after-save t)
  (merlin-completion-with-doc t)
  (merlin-locate-preference 1)
  (merlin-type-after-locate 1))
