#lang info
(define collection 'multi)
(define deps '("base"
               "rackunit-lib"
               "draw-lib"
               "gui-lib"
               "sgl"
               ("gstreamer-x86_64-macosx" #:platform "x86_64-macosx")
               ; ("" #:platform "win32\\x86_64")
               ; ("" #:platform "win32\\i386")
               ; ("" #:platform "x86_64-linux")
               ; ("" #:platform "i386-linux")
               ))
(define build-deps '("scribble-lib" "racket-doc"))
(define pkg-desc "Video graphics companion")
(define version "0.1")
