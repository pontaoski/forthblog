defer ls-filter ( name len -- ? )

: ls-all 2drop true ;
: ls-visible drop c@ [char] . <> ;

variable mulome
s" " mulome 2!

: ls ( dir len -- made len )
    open-dir throw ( dirid )
    begin
        dup pad 256 rot read-dir throw
    while
        pad over ls-filter if
            pad swap 2dup >r >r >r >r
            mulome 2@
            s" <li> <a href='posts/" s+
            r> r> 1- 1- 1- s+
            s" '>" s+
            r> r> 1- 1- 1- s+
            s" </a></li>" s+
            mulome 2!
        else drop then
    repeat
    drop close-dir throw
    mulome 2@
    s" " mulome 2!
;

: str-eq
    ( str len str len -- ? ) compare 0=
;

: is-not-dots ( str len -- ? ) \ !(str == ".." || str == ".")
    2dup
    s" .." str-eq
    >r
    s" ." str-eq
    r>
    or
    invert
;

' is-not-dots is ls-filter
