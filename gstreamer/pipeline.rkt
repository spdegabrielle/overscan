#lang racket/base

(require (except-in ffi/unsafe/introspection
                    send get-field set-field! field-bound? is-a? is-a?/c)
         racket/class
         racket/contract
         "gst.rkt"
         "element.rkt"
         "bin.rkt")

(provide (contract-out [pipeline%
                        (subclass?/c bin%)]))

(define pipeline-mixin
  (make-gobject-delegate get-bus))

(define pipeline%
  (class (pipeline-mixin bin%)
    (super-new)
    (inherit-field pointer)))