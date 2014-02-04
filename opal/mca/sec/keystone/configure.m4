dnl -*- shell-script -*-
dnl
dnl Copyright (c) 2014      Intel, Inc. All rights reserved.
dnl $COPYRIGHT$
dnl 
dnl Additional copyrights may follow
dnl 
dnl $HEADER$
dnl

# MCA_sec_keystone_CONFIG([action-if-found], [action-if-not-found])
# -----------------------------------------------------------
AC_DEFUN([MCA_opal_sec_keystone_CONFIG], [
    AC_CONFIG_FILES([opal/mca/sec/keystone/Makefile])

    AC_ARG_WITH([keystone],
                [AC_HELP_STRING([--with-keystone],
                                [Build keystone support (default: no)])],
	                        [], with_keystone=no)

    # do not build if support not requested
    AS_IF([test "$with_keystone" != "no"],
          [AS_IF([test ! -z "$with_keystone" -a "$with_keystone" != "yes"],
                 [opal_check_keystone_dir="$with_keystone"])
           OMPI_CHECK_PACKAGE([sec_keystone],
                              [libkeystone.h],
                              [keystone],
                              [keystoneFN],
                              [],
                              [$opal_check_keystone_dir],
                              [],
                              [$1],
                              [AC_MSG_WARN([KEYSTONE SUPPORT REQUESTED])
                               AC_MSG_WARN([BUT REQUIRED LIBRARY OR HEADER NOT FOUND])
                               AC_MSG_ERROR([CANNOT CONTINUE])
                               $2])],
          [$2])

    AC_SUBST(sec_keystone_CPPFLAGS)
    AC_SUBST(sec_keystone_LDFLAGS)
    AC_SUBST(sec_keystone_LIBS)
])dnl
