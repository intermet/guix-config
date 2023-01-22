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
  #:use-module (gnu packages haskell-apps)
  #:use-module (gnu packages xfce)
  #:use-module (gnu packages image-viewers)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages ssh)
  #:export (my-packages))

(define my-packages
  (list
   vim
   emacs
   kitty
   git
   xorg-server
   xmonad xmobar cabal-install
   font-hack
   zsh
   emacs-exwm
   nss-certs
   thunar
   p7zip
   feh
   alsa-utils
   openssh
   ))
