#!/usr/bin/env racket
#lang racket
; rktftp.rkt
; an ftp client
; information found from
; 	http://docs.racket-lang.org/net/ftp.html

(require net/ftp)

(define port-no 21)
; replace these next two in main menu loop
(define new-dir (string->path "EBOOKS"))
(define path (string->path "."))

(command-line
  #:args (server user passwd)

  ; establish a connection
  (let ((ftp-conn (ftp-establish-connection server
					    port-no ; usually 21
					    user
					    passwd)))

    ; need to put fun things here!
    ; like a menu or search around for a file
    ; change directory
    (ftp-cd ftp-conn new-dir)

    ; return a list of files in cwd
    ; if path is given, check there
    (display (ftp-directory-list ftp-conn path))
    (newline)

    ; downloads file from the server's current directory
    ; and puts it in local-dir, using the same name.
    ; only writes at the end of transfer, will overwrite
    ; files of the same name
    ;(display "Downloading the file!\n")
    ;(ftp-download-file ftp-conn local-dir file)
    
    ; close connection
    (ftp-close-connection ftp-conn)))
