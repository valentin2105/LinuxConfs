#!/bin/bash

cdr2mask ()
{
	   # Number of args to shift, 255..255, first non-255 byte, zeroes
	      set -- $(( 5 - ($1 / 8) )) 255 255 255 255 $(( (255 << (8 - ($1 % 8))) & 255 )) 0 0 0
	         [ $1 -gt 1 ] && shift $1 || shift
		    echo ${1-0}.${2-0}.${3-0}.${4-0}
	    }
cdr2mask $1	 


