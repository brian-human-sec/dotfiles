
; load evil mode
; (add-to-list 'load-path "~/.emacs.d/evil")

; load prettier
; (add-to-list 'load-path "~/.emacs.d/prettier-emacs")

;;(add-to-list 'load-path "~/.emacs.d/zenburn-emacs")
;;(add-to-list 'load-path "~/.emacs.d/color-theme-sanityinc-tomorrow")

; (if (not (require 'evil nil t)) (message "evil not found."))
; (if (not (require 'prettier-js nil t)) (message "prettier-js not found."))
;; (require 'evil)
;; (require 'prettier-js)
;; (require 'zenburn-theme)
;; (require 'color-theme-sanityinc-tomorrow)

; evil mode
; (if (require 'evil nil t) (evil-mode 1))

;; disable backup files
(setq make-backup-files nil)

;; disable splash screen and startup message
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;(add-hook 'js2-mode-hook 'prettier-js-mode)
;(add-hook 'web-mode-hook 'prettier-js-mode)
