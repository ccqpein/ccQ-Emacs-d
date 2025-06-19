;; -*- lexical-binding: t; -*-

(use-package mcp-hub
  :straight (:host github :repo "lizqwerscott/mcp.el")
  :custom (mcp-hub-servers
           (list (cons "hyper-mcp"
                       (list :command
                             "~/.cargo/bin/hyper-mcp"
                             :args
                             (list "-c" (file-truename "~/Code/garage/ai/hyper-mcp-test/config.json")))))))

(provide 'init-mcp)
