;----------------------------------------------------------------------
; dup.asm - user-callable entry point to dup() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 11.0
; 
;       Copyright (c) 1991, 2002 by Borland Software Corporation
;       All Rights Reserved.
; 

; $Revision: 9.3 $

        include rules.asi
	include entry.inc
        Entry@ dup, __dup, _RTLENTRY, 4
        end
