#!/usr/bin/env racket
#lang racket
; rktftp.rkt
; an ftp client
; who knew??

; nothing to see here, folks!

(require racket/tcp)

; open socket
(open-tcp-stream-socket "web.mit.edu" "ftp")

; close socket
(close-port)
