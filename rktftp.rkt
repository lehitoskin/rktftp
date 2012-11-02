#!/usr/bin/env racket
#lang racket
; rktftp.rkt - an ftp client
; Copyright (C) 2012 Lehi Toskin
;
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;

(require net/ftp)

(command-line
  #:args (server port-no user passwd)

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
	      cd - change directory to given path
	      ls - list contents of a directory
	      q(uit) - quit the program
	      h(elp) - display this help message\n"))
	       
    ; only writes at the end of transfer, will overwrite
    ; files of the same name
    (define (get local-dir file)
      (display "Downloading...\n")
      (ftp-download-file ftp-conn local-dir file))

    ; main loop
    (define (menu)
      (display "ftp> ")
      (let ((cmd (symbol->string (read))))
	(define oper (substring cmd 1))
	(cond ((equal? cmd "cd")
	       (display "You called 'cd'!\n")
	       (cd oper))
	      ((equal? cmd "ls")
	       (display "You called 'ls'!\n")
	       (ls oper))
	      ((equal? cmd "h")
	       (display "You called 'h'!\n")
	       (help))
	      ((equal? cmd "help")
	       (display "You called 'help'!\n")
	       (help))
	      ((equal? cmd "get")
	       (get oper1 oper2))
	      (else (display "None of the options called.\n")))
	(cond ((not (or (equal? cmd "q") (equal? cmd "quit")))
	       (menu)))))

    (menu)
    
    ; close connection
    (ftp-close-connection ftp-conn)))
