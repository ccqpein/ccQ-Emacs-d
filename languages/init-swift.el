(require 'swift-mode)
;;Because swift-mode cannot load from ad-modes automatically even add swift-mode to ac-modes aoready. So need addition sentence next make sure swift mode load auto-complete
(add-hook 'swift-mode-hook
          (lambda ()
            (add-to-list 'ac-modes 'swift-mode)
            (define-key (current-local-map) (kbd "\C-c\C-k") 'swift-mode:send-buffer)
            (setq swift-indent-offset 4)))

(provide 'init-swift)
