;;; config.el -*- lexical-binding: t; -*-

(setq user-full-name "netrover"
      user-mail-address "netrover1997@gmail.com")

;; Add your personal config here.

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 20 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 20) ; Good companion for mixed text
      doom-symbol-font (font-spec :family "JetBrainsMono Nerd Font"))

;; Set the theme to nil to force the vanilla Emacs "crashed" fallback look
;; Base theme
(setq doom-theme 'doom-old-hope)

;; Override specific syntax faces on top, just in case doom-old-hope
;; doesn't fully match what we want
;;(custom-set-faces!
;;  '(default                      :background "#000000" :foreground "#ff3b3b")
;;  '(font-lock-comment-face       :foreground "#5c5c5c" :slant italic)
;;  '(font-lock-string-face        :foreground "#cc4444")
;;  '(font-lock-keyword-face       :foreground "#ff5555" :weight bold)
;;  '(font-lock-function-name-face :foreground "#ff8888")
;;  '(font-lock-variable-name-face :foreground "#d9d9d9")
;;  '(font-lock-type-face          :foreground "#ff9999")
;;  '(font-lock-constant-face      :foreground "#ff6666")
;;  '(font-lock-builtin-face       :foreground "#ff4444")
;;  '(cursor                       :background "#ff3b3b")
;;  '(region                       :background "#330000")
;;  '(mode-line                    :background "#1a0000" :foreground "#ff3b3b")
;;  '(line-number                  :foreground "#4d0000")
;;  '(line-number-current-line     :foreground "#ff3b3b"))
