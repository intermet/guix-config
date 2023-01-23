(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq package-enable-at-startup nil)


(save-place-mode 1)
(setq inhibit-compacting-font-caches t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq default-fill-column 80)
;; (global-display-fill-column-indicator-mode)
(global-display-line-numbers-mode)

(add-hook 'compilation-mode-hook (lambda() (display-line-numbers-mode -1)))
(add-hook 'dired-mode-hook (lambda() (display-line-numbers-mode -1)))

(global-auto-revert-mode t)

(add-to-list 'default-frame-alist
             '(vertical-scroll-bars . nil))

(electric-pair-mode 1)
(setq electric-pair-pairs
      '(
        (?\" . ?\")
        (?\{ . ?\})))

(straight-use-package 'use-package)

(use-package straight
  :custom (straight-use-package-by-default t))

(use-package orderless
  :init
  :custom (completion-styles '(orderless))
  :config
  (setq orderless-component-separator 'orderless-escapable-split-on-space)
  )

(use-package modus-themes
  :ensure
  :init
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs t 
        modus-themes-region '(bg-only no-extend))
  (setq modus-themes-completions
        '((matches . (extrabold background intense))
          (selection . (semibold accented intense))
          (popup . (accented))))
  (setq modus-themes-hl-line '(underline accented))
  (setq modus-themes-paren-match '(bold))
  (load-theme 'modus-vivendi :no-confirm)
  :config
  :bind ("<f5>" . modus-themes-toggle))


(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package all-the-icons
  :if (display-graphic-p))

(use-package popper
  :bind (("C-`"   . popper-toggle-latest)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          help-mode
          compilation-mode))
  (popper-mode +1)
  (popper-echo-mode +1))     

;;; evil-mode
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (use-package evil-leader
    :config
    (evil-leader/set-leader "<SPC>")
    )
  (global-evil-leader-mode)
  (evil-mode 1)
  )

(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "<up>") 'nope)
  (define-key evil-normal-state-map (kbd "<down>") 'nope)
  (define-key evil-normal-state-map (kbd "<left>") 'nope)
  (define-key evil-normal-state-map (kbd "<right>") 'nope)
  (define-key evil-normal-state-map  "f" 'evil-avy-goto-char-in-line)
  (define-key evil-normal-state-map  "F" 'evil-avy-goto-word-1)
  (define-key evil-normal-state-map  "gl" 'evil-avy-goto-line)
  )

(use-package evil-commentary
  :config
  (evil-commentary-mode)
  )

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-goggles
  :custom
  (evil-goggles-duration 0.100)
  :config
  (evil-goggles-mode)
  (evil-goggles-use-diff-faces))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0)
  (setq company-show-numbers t)
  )

(use-package which-key
  :init
  (which-key-mode)
  )

(use-package restart-emacs)

(use-package vertico
  :config
  (vertico-mode)
  )

(use-package consult
  :bind (
         ("C-x b" . consult-buffer)
         ("C-s" . consult-line)
         ("C-x C-r" . consult-recent-file)
         )
  )

(use-package marginalia
   :config
   (marginalia-mode)
   )

(use-package all-the-icons-completion
  :init (all-the-icons-completion-marginalia-setup))

(use-package ace-window
  :bind
  ("M-o" . 'ace-window)
  :config
  (setq aw-ignore-on t)
  (setq aw-ignored-buffers popper-reference-buffers)
  )

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024))
  (setq lsp-idle-delay 0.500)
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-lens-enable nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-signature-render-documentation nil)
  :hook ((TeX-mode . lsp)
         (tuareg-mode . lsp)
         (python-mode . lsp)
         (haskell-mode . lsp))
  :commands lsp)



(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file user-init-file))

(defun find-xmonadhs ()
  (interactive)
  (find-file "~/.config/xmonad/xmonad.hs"))

(defun find-guix-system-config ()
  (interactive)
  (find-file "/sudo::/etc/config.scm"))

(use-package hydra)

(defhydra hydra-edit-config-files (:color pink
                             :hint nil)
"
^edit^
_i_: init.el    _j_: xinit
_x_: xmonad.hs  _z_: zshrc
_b_: xmobarrc   _g_: guix
"
  ("i" find-user-init-file :color blue)
  ("x"  find-xmonadhs :color blue)
  ("b" (find-file "~/.xmobarrc") :color blue)
  ("z" (find-file "~/.zshrc") :color blue)
  ("j" (find-file "~/.xinitrc") :color blue)
  ("g" find-guix-system-config :color blue)
  ("q" nil :color blue)
)

(use-package window
  :straight (:type built-in)
  :custom
  (display-buffer-alist
   '(("magit"
      (display-buffer-in-side-window)
      (side . right)
      (window-width . 0.25)
      (window-parameters . ((mode-line-format . (" " "%b"))))
      ))))


(defun ziyed/dired-vc ()
  (interactive)
  (let
  ((dir (if (vc-root-dir) (dired-noselect (vc-root-dir)) (dired-noselect default-directory))))
  (display-buffer-in-side-window
   dir
   `((side . left)
     (slot . 0)
     (window-width . 0.15)
     (window-parameters . ((mode-line-format . (" " "%b"))))
     ))
  (ace-window dir)))

(use-package dired
  :straight (:type built-in)
  :hook
  (dired-mode . dired-hide-details-mode)
  :config
  ;; Colourful columns.
  (setq dired-listing-switches
        "-GFhlv --group-directories-first --time-style=long-iso")
  (setq dired-omit-files "[~#]$")
  (global-set-key (kbd "C-c d") 'ziyed/dired-vc)
  (use-package dired-subtree)
  (add-hook 'dired-mode-hook (lambda() (display-line-numbers-mode -1)))
  (add-hook 'dired-mode-hook (lambda () (dired-omit-mode))))

(global-set-key (kbd "C-c I") 'hydra-edit-config-files/body)


(use-package rainbow-mode)

(use-package paredit
  :config
  (add-hook 'scheme-mode-hook #'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook #'enable-paredit-mode)
  (add-hook  'geiser-mode-hook #'enable-paredit-mode))

(use-package guix)
(use-package geiser)
(use-package geiser-guile)

(use-package vterm)

;; (exwm-enable)

;; (defun dmenu ()
;;   (interactive)
;;   (start-process ""
;;                  nil
;;                  "dmenu_run"
;;                  "-b"
;;                  "-fn"
;;                  "'Fira Code Medium-11'"
;;                  "-nb"
;;                  "black"
;;                  "-sb"
;;                  "'#555555'"
;;                  "-nf"
;;                  "white")
;;   )

;; (setq exwm-input-global-keys
;;       `(
;;         ([?\s-r] . exwm-reset)
;;         (,(kbd "M-o") . ace-window)
;;         ([?\s-d] . (lambda () (interactive) (dired default-directory)))
;;         (,(kbd "s-<return>") . (lambda () (interactive) (start-process "" nil "kitty")))
;;         ;; (,(kbd "s-<SPC>") . (lambda () (interactive) (start-process-shell-command "" nil "dmenu_run")))
;;         ([?\s-w] . (lambda () (interactive)
;;                      (start-process "" nil "flatpak" "run" "org.mozilla.firefox")))
;;         ,@(mapcar (lambda (i)
;;                     `(,(kbd (format "s-%d" i)) .
;;                       (lambda ()
;;                         (interactive)
;;                         (exwm-workspace-switch-create ,i)
;;                         )
;;                       ))
;;                   (number-sequence 0 9)
;;                   )
;;         )
;;         )
