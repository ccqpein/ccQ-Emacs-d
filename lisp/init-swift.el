(use-package swift-mode
  :custom
  (swift-indent-offset 4)
  
  :bind
  ;;(("\C-c\C-k" . swift-mode:send-buffer))
  
  :config
  (add-to-list 'ac-modes 'swift-mode)
  )

(use-package lsp-sourcekit
  :after lsp-mode
  :config
  (setenv "SOURCEKIT_TOOLCHAIN_PATH" "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain")
  (setq lsp-sourcekit-executable (expand-file-name "~/Desktop/sourcekit-lsp-master/sourcekit-lsp-master/.build/x86_64-apple-macosx/debug/sourcekit-lsp")))


;(require 'swift-mode)
;;Because swift-mode cannot load from ad-modes automatically even add swift-mode to ac-modes aoready. So need addition sentence next make sure swift mode load auto-complete
;(add-hook 'swift-mode-hook
;          (lambda ()
;            (add-to-list 'ac-modes 'swift-mode)
;            (define-key (current-local-map) (kbd "\C-c\C-k") 'swift-mode:send-buffer)
;            (setq swift-indent-offset 4)))

(provide 'init-swift)
