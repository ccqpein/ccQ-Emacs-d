(defvar *global-output-stream* (make-string-output-stream))


(defun run-one-time-command (com &rest argvs)
  (let ((s (make-string-output-stream)))
    (sb-ext:run-program com argvs :search t :wait t :output s)
    (get-output-stream-string s)))


(defun run-command (com &rest argvs)
  (format t "Start run command ~a ~{~a ~}~%" com argvs)
  (if (/= 0 (sb-ext:process-exit-code
             (sb-ext:run-program com argvs :search t :wait t :output *global-output-stream*)))
      1
      nil))


(defun check-this-dir ()
  (let ((this-dir (parse-namestring (run-one-time-command "pwd"))))
    (and (string= (pathname-name this-dir) ".emacs")
         (equal '(#\d #\newline)
                (concatenate 'list (pathname-type this-dir))))))


(defmacro check-if-or-yes (bool-expression mesg yes no)
  `(if ,bool-expression
      (if (yes-or-no-p ,mesg)
          ,yes
          ,no)
      ,yes))


(defmacro check-if-or-no (bool-expression mesg yes no)
  `(if ,bool-expression
      (if (yes-or-no-p ,mesg)
          ,yes
          ,no)
      ,no))


(defun clean-up ()
  (if (yes-or-no-p "Wanna cleanup? This will clean zip and emacs_source folder")
      (if (run-command "rm" "-rf" "./emacs.zip" "./emacs_source")
          (progn
            (format t "Clean up failed")
            (sb-ext:exit))
          (format t "Clean up successed"))
      nil))


(defun if-has-argv (match)
  (loop
     for v in *posix-argv*
     when (string= match v)
     return match
     finally (return "")))


;;:= TODO: need another thread to print out log in *global-output-stream*

(defun main ()
  (if (not (check-this-dir))
      (sb-ext:exit))
  
  (check-if-or-yes
   (probe-file "./emacs.zip")
   "emacs.zip already exist, wanna download it again?"
   (if (run-command "wget" (if-has-argv "-—no-check-certificate") "-v" "https://github.com/emacs-mirror/emacs/archive/master.zip" "-O" "emacs.zip")
       (sb-ext:exit :code 1))
   nil)
  
  (check-if-or-yes
   (probe-file "./emacs_source")
   "emacs_source already exist, wanna unzip it anyway?"
   (if (run-command "unzip" "-o" "emacs.zip" "-d" "emacs_source")
       (sb-ext:exit :code 1))
   nil)

  ;;(run-command *global-output-stream* "brew" "install" "autoconf" "automake" "texinfo" "gnutls" "pkg-config" "libxml2")

  (if (/= 0 (sb-posix:chdir "./emacs_source/emacs-master"))
      (sb-ext:exit :code 1))
  
  (run-command "env" "PKG_CONFIG_PATH=/usr/local/opt/libxml2/lib/pkgconfig" "./autogen.sh")

  (run-command "env" "PKG_CONFIG_PATH=/usr/local/opt/libxml2/lib/pkgconfig" "./configure")

  (run-command "env" "PKG_CONFIG_PATH=/usr/local/opt/libxml2/lib/pkgconfig" "gmake" "install")

  (run-command "open" "./nextstep")

  (if (/= 0 (sb-posix:chdir "../../"))
      (sb-ext:exit :code 1))

  (clean-up)

  (sb-ext:exit)
  )

(main)
