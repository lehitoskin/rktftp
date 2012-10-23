#!/usr/bin/env racket
#lang racket
; rktftp.rkt
; an ftp client

(require net/ftp)

(define port-no 21)

(command-line
  #:args (server user passwd)

  ; establish a connection
  (let ((ftp-conn (ftp-establish-connection server
					    port-no ; usually 21
					    user
					    passwd)))
    
    (define cd
      (lambda (new-dir)
	(ftp-cd ftp-conn new-dir)))
    
    (define ls
      (lambda (path)
	((display
	   (ftp-directory-list ftp-conn path))
	 (newline))))
    
    (define (help)
      (printf "Current supported commands:
	      d - change directory to given path
	      ls - list contents of a directory
	      q(uit) - quit the program
	      h(elp) - display this help message\n"))
	       
    ; downloads file from the server's current directory
    ; and puts it in local-dir, using the same name.
    ; only writes at the end of transfer, will overwrite
    ; files of the same name
    ;(display "Downloading the file!\n")
    ;(ftp-download-file ftp-conn local-dir file)

    ; main loop
    (define (menu)
      (display "ftp> ")
      (let ((cmd (symbol->string (read))))
	(define oper (substring cmd 0))
	(cond ((equal? cmd "cd")
	       (display "You called 'cd'!\n")
	       (cd oper))
	      ((equal? cmd "ls")
	       (display "You called 'ls'!\n")
	       (ls oper))
	      ((equal? cmd "h")
	       (display "You called 'h'!\n")
	       (help))
	      (else (display "None of the options called.\n")))
	(cond ((not (equal? cmd "q"))
	       (menu)))))

    (menu)
    
    ; close connection
    (ftp-close-connection ftp-conn)))
