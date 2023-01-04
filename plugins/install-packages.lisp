;;; install packages those ain't on elpa
(defparameter *WILD-CARDS-PKGS*
  '(
	("ejira" "https://github.com/nyyManni/ejira.git" "~/.emacs.d/elpa/")
	))

(defun check-if-already-install (git-repo-info)
  (let ((current-dir (sb-posix:getcwd))
		(install-path (third git-repo-info))
		(folder-name (first git-repo-info))
		(stdout (make-string-output-stream)))
	
	(sb-posix:chdir install-path)
	(probe-file (concatenate 'string install-path folder-name))
	))

(defun git-clone (git-repo-info)
  (let ((current-dir (sb-posix:getcwd))
		(install-path (third git-repo-info))
		(folder-name (first git-repo-info))
		(stdout (make-string-output-stream)))
	
	(sb-posix:chdir install-path)
	(sb-ext:run-program "git" (list "clone" (second git-repo-info))
						:search t
                        :output stdout)
	(format t "~a~%" (get-output-stream-string stdout))
	))

(defun git-pull (git-repo-info))

(defun main ()
  (dolist (pkg *WILD-CARDS-PKGS*)
	(if (check-if-already-install pkg)
		(git-pull pkg)
		(git-clone pkg))))

(format t "~a~%" (sb-posix:getcwd))
