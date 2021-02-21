include 1991.forth
include dirs.forth

sourcedir s" views/" s+ set-view-path

: entries
    s" pages" ls
    $type
;

: handle-/
    s" index.html" render-view
;

4096 constant max-line

variable hallo
s" " hallo 2!

: third ( A b c -- A b c A ) >r over r> swap ;

: read-lines ( fileid -- str len )
    begin
        pad max-line third read-line throw
    while
        pad swap  ( fileid c-addr u )  \ string excludes the newline
        >r >r
        hallo 2@
        r> r> s+
        s" <br>" s+
        hallo 2!
    repeat
        2drop

    hallo 2@
    s" " hallo 2!
;

: content
    s" pages/"
    get-query-string 5 /string
    s+
    s" .md"
    s+
    r/o open-file throw
    read-lines
    $type
;

: handle-post
    s" post.html" render-view
;

/1991 / handle-/
/1991 /posts/<name> handle-post

\ Start the server on port 8080.
8080 1991:
