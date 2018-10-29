exec sbcl \
     --eval '(ql:quickload :cl-recker :silent t)' \
     --eval '(ql:quickload :clx-truetype :silent t)' \
     --eval '(ql:quickload :stumpwm :silent t)' \
     --eval '(ql:quickload :swank :silent t)'\
     --eval '(swank-loader::setup)' \
     --eval '(swank:create-server :dont-close t)' \
     --eval '(stumpwm:stumpwm)'
