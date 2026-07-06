;;; config.el -*- lexical-binding: t; -*-

(setq user-full-name "netrover"
      user-mail-address "netrover1997@gmail.com")

;; Add your personal config here.

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 20 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 20) ; Good companion for mixed text
      doom-symbol-font (font-spec :family "JetBrainsMono Nerd Font"))

;; Set the theme to nil to force the vanilla Emacs "crashed" fallback look
;; Base theme

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
;; 2. Enable Zen Mode automatically for ALL your work types
;;(add-hook 'prog-mode-hook #'+zen/toggle) ; For programming
;;(add-hook 'text-mode-hook #'+zen/toggle) ; For notes/prose
;;(add-hook 'conf-mode-hook #'+zen/toggle) ; For config files (the one you wanted!)

;;(after! writeroom-mode
;;  (setq writeroom-width 80) ; Set a fixed width for the "Zen" column
;;  (if (not (display-graphic-p)) ; If in terminal mode...
;;      (setq writeroom-fullscreen-effect nil))) ; Disable fullscreen hacks

;; 3. Permanent Visual Line Wrapping (Nvim-style)
(global-visual-line-mode t)
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-Iosvkem)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;; 1. Use bash for internal Emacs processes (prevents Fish-related breakages)
(setq shell-file-name (executable-find "bash"))

;; 2. Use Fish for interactive terminals (vterm, etc.)
(setq-default vterm-shell "/usr/bin/fish")
(setq-default explicit-shell-file-name "/usr/bin/fish")

;; 3. Ensure pyenv is respected inside Emacs
(setq nrepl-python-command "python") ; helpful for some python modules

;; --- TOTAL BLACKOUT (OLED) ---

;; 1. Global Background & Solaire Fix
;; This forces inactive/active windows and margins to stay pure black.
(custom-set-faces!
  '(default :background "#000000")
  '(fringe :background "#000000")
  '(solaire-default-face :background "#000000")
  '(solaire-base-face :background "#000000")
  '(solaire-mode-line-face :background "#000000")
  '(solaire-mode-line-inactive-face :background "#000000"))

;; 2. Modeline (The Bottom Bar)
(after! doom-modeline
  (setq doom-modeline-bar-width 0) ; Removes the small colored vertical bar on the left
  (custom-set-faces!
    '(mode-line :background "#000000" :box nil)
    '(mode-line-inactive :background "#000000" :box nil)
    '(doom-modeline-bar :background "#000000")))

;; 3. Centaur-Tabs (The Top Bar)
(after! centaur-tabs
  (custom-set-faces!
    '(centaur-tabs-default :background "#000000")
    '(centaur-tabs-selected :background "#000000")
    '(centaur-tabs-unselected :background "#000000")
    '(centaur-tabs-selected-modified :background "#000000")
    '(centaur-tabs-unselected-modified :background "#000000")
    '(centaur-tabs-active-bar-face :background "#000000")))

;; 4. Terminal (Vterm) Background
(after! vterm
  (custom-set-faces!
    '(vterm-color-black :background "#000000")))
