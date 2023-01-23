(setq frame-resize-pixelwise t)
(setq frame-inhibit-implied-resize t)

(setq package-enable-at-startup t)
(defvar package-quickstart)
(setq package-quickstart t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(save-place-mode -1)

(setq inhibit-startup-screen t)
(setq inhibit-startup-buffer-menu t)


(setq use-dialog-box t)
(setq use-file-dialog nil)

(setq default-frame-alist '((font . "Hack-13")))
(set-face-attribute 'default t :font "Hack-13")

(setq native-comp-async-report-warnings-errors 'silent)
