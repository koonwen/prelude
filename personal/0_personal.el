(use-package neocaml
  :custom
  (neocaml-dune-project-root-files '("dune" "dune-project"))
  (neocaml-dune-format-on-save t))

;; Hook in neocaml-dune-interaction-mode
(dolist (hook '(neocaml-base-mode-hook
                neocaml-dune-mode-hook
                neocaml-opam-mode-hook))
  (add-hook hook #'neocaml-dune-interaction-mode))

;; (add-hook 'neocaml-base-mode-hook #'which-function-mode)
;; (add-hook 'neocaml-base-mode-hook #'outline-minor-mode)

;; ocaml-eglot binds C-c C-d to ocaml-eglot-document, shadowing the
;; neocaml-dune-interaction C-c C-d prefix.
(with-eval-after-load 'ocaml-eglot
  (define-key ocaml-eglot-mode-map (kbd "C-c C-d") nil))


;; Structural expansion
(use-package expreg
  :ensure t
  :bind (("C-=" . expreg-expand)
         ("C--" . expreg-contract)))
