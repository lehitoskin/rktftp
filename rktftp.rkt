#!/usr/bin/env racket
#lang racket
; rktftp.rkt
; an ftp client
; information found from
; 	http://docs.racket-lang.org/net/ftp.html

; nothing to see here, folks!

(require net/ftp)

; establish a connection
(ftp-establish-connection server
			  port-no ; usually 21
			  user
			  passwd)

; need to put fun things here!
; like a menu or search around for a file

; change directory
(ftp-cd ftp-conn new-dir)

; return a list of files in cwd
; if path is given, check there
; (ftp-directory-list ftp-conn [path])
; (listof (list/c (one-of/c "-" "d" "l")
;		string?
;		string?))

; downloads file from the server's current directory
; and puts it in local-dir, using the same name.
; only writes at the end of transfer, will overwrite
; files of the same name
; (ftp-download-file ftp-conn local-dir file)

; close connection
(ftp-close-connection ftp-conn)
