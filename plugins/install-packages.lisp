;;; install packages those ain't on elpa
(defparameter *WILD-CARDS-PKGS*
  '(
	("ejira" . "")
	))

(defun check-if-already-install (git-repo))

(defun git-clone (git-repo))

(defun git-pull (git-repo))

(defun main ()
  (dolist (pkg *WILD-CARDS-PKGS*)
	(if (check-if-already-install pkg)
		(git-pull pkg)
		(git-clone pkg))))
