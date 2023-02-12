(use-modules 
	(gnu)
    (nongnu packages linux)
    (nongnu system linux-initrd)
	(gnu packages shells)
    (packages-module)
    (services-module)
    (srfi srfi-1)
    (guix channels)
    (guix inferior)
)

(use-modules (packages-module)
             (services-module))

(operating-system
 (locale "en_US.utf8")
 (timezone "America/New_York")
 (keyboard-layout (keyboard-layout "us"))
 (host-name "lenovo")

  (kernel
    (let*
      ((channels
        (list (channel
               (name 'guix)
               (url "https://git.savannah.gnu.org/git/guix.git")
               (commit "3c075ffd82a64e185579aa94e03be020faeebb4"))
              (channel
               (name 'nonguix)
               (url "https://gitlab.com/nonguix/nonguix")
               (commit "748ec7f8d3f86d27e3bad50987771200230e49be"))
              (channel
               (name 'z)
               (url "https://github.com/intermet/guix-channel")
               (commit "d8279f14aeabdaf4cba331babd54d19525e4eb7e"))
              ))
       (inferior
        (inferior-for-channels channels)))
      (first (lookup-inferior-packages inferior "linux" "6.1.8"))))

 
 (initrd microcode-initrd)
 (firmware (cons* iwlwifi-firmware
                  %base-firmware))

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
