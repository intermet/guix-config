(define-module (services-module)
  #:use-module (gnu)
  #:use-module (gnu services networking) 
  #:use-module (gnu services dbus) 
  #:use-module (gnu services desktop) 
  #:use-module (gnu services ssh) 
  #:use-module (gnu services xorg) 
  #:export (my-services))

(define my-wpa-supplicant-service
  (service wpa-supplicant-service-type
           (wpa-supplicant-configuration
            (interface "wlo1")
            (config-file "/home/ziyed/wifi.conf"))))

(define my-dhcp-client-service
  (service dhcp-client-service-type))


(define my-desktop-services
  (modify-services
   (modify-services %desktop-services (delete wpa-supplicant-service-type))
   (delete network-manager-service-type)))


(define my-network-services
  (list
   my-wpa-supplicant-service
   my-dhcp-client-service
   ))

(define %substitute-urls
  (list "https://substitutes.nonguix.org"))

(define %substitute-keys
  (list (local-file "./substitutes-signing-keys/nonguix.pub")))

(define (add-substitute-server services)
  (modify-services %desktop-services
      (guix-service-type config =>
                        (guix-configuration
                          (inherit config)
                          (substitute-urls
                            (append %substitute-urls
                                    %default-substitute-urls))
                          (authorized-keys
                            (append %substitute-keys
                                    %default-authorized-guix-keys))))))

(define my-services
  (append
   my-network-services
   my-desktop-services))

;; (define my-services
;;   (add-substitute-server my-services))
