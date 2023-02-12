(define-module (packages-module)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages kde)
  #:use-module (gnu packages haskell-apps)
  #:use-module (gnu packages xfce)
  #:use-module (gnu packages image-viewers)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages video)
  #:use-module (gnu packages suckless)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages lisp-xyz)
  ;; #:use-module ((z packages z-emacs) #:prefix z:)
  #:export (my-packages))

;; (define z-emacs-next
;;   (package
;;    (inherit emacs-next)
;;    (name "z-emacs-next")
;;    (arguments
;;     (substitute-keyword-arguments (package-arguments emacs)
;;                                   ((#:configure-flags flags ''())
;;                                    `(cons* "--with-tree-sitter"
;;                                            ,flags))))
   
;;    ))

(define my-packages
  (list
   vim
   ;; z:emacs-next-treesitter
   emacs-next
   ;;emacs-guix
   ;;emacs-vterm
   ;;emacs-evil
   ;;emacs-vertico
   ;;emacs-modus-themes
   ;; emacs-ace-window
   ;;emacs-evil-commentary
   ;;emacs-evil-collection
   ;;emacs-company
   ;;emacs-which-key
   ;;emacs-marginalia
   ;;emacs-magit
   ;; emacs-paredit
   ;; emacs-popper
   ;;emacs-consult
   ;; emacs-haskell-mode
   ;; emacs-geiser
   ;; emacs-geiser-guile
   ;; emacs-guix
   ;; emacs-lsp-mode
   ;; emacs-rainbow-delimiters
   ;; emacs-stumpwm-mode
   ;;emacs-orderless
   ;;emacs-sly
   ;; emacs-auctex
   okular
   xdg-desktop-portal xdg-desktop-portal-gtk
   kitty
   git
   xorg-server
   ;;xmonad xmobar cabal-install
   stumpwm+slynk
   ;; `(,stumpwm "lib")
   stumpish
   sbcl
   sbcl-stumpwm-ttf-fonts
   sbcl-slime-swank
   ;;sbcl-stumpwm-swm-gaps
   font-hack font-dejavu
   xmodmap
   zsh
   nss-certs
   thunar
   p7zip
   feh
   alsa-utils
   openssh
   exa
   mpv
   yt-dlp
   ffmpeg
   dmenu
   streamlink
   xdg-utils
   ))
