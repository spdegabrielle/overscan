#lang scribble/manual
@require[@for-label[ffi/unsafe/introspection
                    racket/base
                    ffi/unsafe]]

@title[#:tag "gobject-introspection"]{GObject Introspection}

@secref{gstreamer} is the core framework that powers much of the
capabilities of Overscan. GStreamer is also a @bold{C} framework,
which means that a big part of Overscan's codebase is dedicated to the
interop between Racket and C. Racket provides a phenomenal
@seclink["top" #:doc '(lib
"scribblings/foreign/foreign.scrbl")]{Foreign Interface}, but to
create foreign functions for all the relevant portions of GStreamer
would be cumbersome, at best.

Luckily, GStreamer is written with
@hyperlink["https://wiki.gnome.org/Projects/GLib"]{GLib} and contains
@hyperlink["https://wiki.gnome.org/Projects/GObjectIntrospection"]{GObject
Introspection} metadata. @emph{GObject Introspection} (aka @emph{GIR})
is a middleware layer that allows for a language to read this metadata
and dynamically create bindings for constructing an interface into the
C library.

The Overscan package provides a module designed to accompany Racket's
FFI collection. This module brings additional functionality and
@secref["types" #:doc '(lib "scribblings/foreign/foreign.scrbl")] for
working with Introspected C libraries. This module powers the
@secref{gstreamer} module, but can be used outside of Overscan for
working with other GLib libraries.

@defmodule[ffi/unsafe/introspection]

@defproc[(introspection [namespace symbol?] [version string? #f])
         gi-repository?]{

Search for the @racket[namespace] typelib in the GObject Introspection
         repository search path and load it. If @racket[version] is
         not specified, the latest version will be used.

An example for loading the @secref{gstreamer} namespace:

@racketblock[
  (define gst (introspection 'Gst))
]

This function returns the repository as a private struct. This struct
has the @racket[prop:procedure] property and can be called as a
function as such:

@nested[#:style 'inset]{
  @defproc*[#:kind "gi-repository" #:link-target? #f
            ([(repository) (hash/c symbol? gi-base?)]
             [(repository [name symbol?]) gi-base?])]{
    When called as in the first form, without an argument, the proc
  will return a @racket[hash] of all of the known members of this
  namespace.

    When called as the second form, this is the equivalent to
  @racket[gi-repository-find-name] with the first argument already
  set.
  }
}

}

@defproc[(gi-repository-find-name [repo gi-repository?] [name symbol?]) gi-base?]{
  Find a metadata entry called @racket[name] in the
  @racket[repo]. These @emph{entries} form the basis of the foreign
  interface. This will raise an argument error if the entry is not a
  part of the given namespace.
}

@defstruct*[gi-base ([info cpointer?])
            #:omit-constructor ]{
  The common base struct of all GIR metadata entries. Instances of
  this struct have the @racket[prop:cpointer] property, and can be
  used transparently as cpointers to their respective entries.
}
