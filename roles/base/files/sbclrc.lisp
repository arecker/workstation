;; -*- mode: lisp -*-
#-quicklisp
(let ((quicklisp-init (merge-pathnames ".quicklisp/setup.lisp"
				       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(defvar *recker/extra-projects* '("src/stumpwm/"
				  ".stumpwm.d/"))

(defun add-to-registry-if-exists (proj)
  (let ((target (merge-pathnames proj (user-homedir-pathname))))
    (if (probe-file target)
	(push target asdf:*central-registry*)
	(format t "~s not found, skipping~%" target))))

(mapcar #'add-to-registry-if-exists *recker/extra-projects*)
