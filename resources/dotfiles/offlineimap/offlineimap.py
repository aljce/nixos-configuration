#!/usr/bin/env python2
from subprocess import check_output

def get_pass(ident):
    return check_output("pass mail/" + ident,shell=True).splitlines()[0]
