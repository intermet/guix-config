(use-modules 
	(gnu)
    (nongnu packages linux)
    (nongnu system linux-initrd)
	(gnu packages shells)
    (packages-module)
    (services-module)
)

(use-modules (packages-module)
             (services-module))

(operating-system
 (locale "en_US.utf8")
 (timezone "America/New_York")
 (keyboard-layout (keyboard-layout "us"))
 (host-name "lenovo")
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))

 (users (cons* (user-account
                (name "ziyed")
                (group "users")
                (home-directory "/home/ziyed")
                (shell (file-append zsh "/bin/zsh"))
                (supplementary-groups '("wheel" "input" "netdev" "audio" "video")))
               %base-user-accounts))

 (packages (append my-packages %base-packages))
 (services my-services)
                   
 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (targets (list "/boot/efi"))
              (keyboard-layout keyboard-layout)))

 (swap-devices (list (swap-space
                      (target (uuid
                               "bdfc036a-6b15-4e93-9c04-30dc894fd970")))))

 (file-systems (cons* (file-system
                       (mount-point "/boot/efi")
                       (device (uuid "2619-D29C"
                                     'fat32))
                       (type "vfat"))
                      (file-system
                       (mount-point "/")
                       (device (uuid
                                "0868a552-e78e-4431-830b-d154a26a6782"
                                'ext4))
                       (type "ext4"))
                      (file-system
                       (mount-point "/home")
                       (device (uuid
                                "a7576e83-fe3b-437e-92e9-0e3b38bdf01b"
                                'ext4))
                       (type "ext4")) %base-file-systems)))
