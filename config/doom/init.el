;;; init.el -*- lexical-binding: t; -*-

(doom! :completion
       (corfu +orderless)
       vertico

       :ui
       doom
       dashboard
       modeline
       nav-flash
       ophints
       (popup +defaults)
       vc-gutter
       vi-tilde-fringe
       window-select
       workspaces

       :editor
      ; (evil +everywhere)
       file-templates
       fold
       snippets

       :emacs
       dired
       electric
       undo
       vc

       :checkers
       syntax

       :tools
       (eval +overlay)
       lookup
       magit
       tree-sitter
       lsp
       :lang
       emacs-lisp
       markdown
       (nix +tree-sitter)
       (sh +fish)
       yaml
       (lua +tree-sitter)
       (python +lsp +tree-sitter)
       (qml +lsp)
       
       :config
       (default +bindings +smartparens))
