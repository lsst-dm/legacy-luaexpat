# EupsPkg config file. Sourced by 'eupspkg'

# Breaks on Darwin w/o this
export LANG=C

config()
{
    [[ $(uname) = Darwin ]] && SED_INPLACE="sed -i '.prev'" || SED_INPLACE="sed -i"

    $SED_INPLACE "s,LUA_LIBDIR= /usr/local/,LUA_LIBDIR= $LUA_DIR/," config &&
    $SED_INPLACE "s,LUA_DIR= /usr/local/,LUA_DIR= ${LUA_DIR}/," config &&
    $SED_INPLACE "s,LUA_INC= /usr/local/,LUA_INC= ${LUA_DIR}/," config &&
    $SED_INPLACE "s,5\.0,5\.1," config &&
    $SED_INPLACE "s,-O2,-O2 -fPIC," config &&
    $SED_INPLACE "s,LUA_VERSION_NUM= 500,LUA_VERSION_NUM= 514," config &&
    $SED_INPLACE "s,EXPAT_INC= /usr/local/\(.*\),EXPAT_INC=${EXPAT_DIR}/\1"\\$'\n'"EXPAT_LIBDIR=${EXPAT_DIR}/lib," config && 
    $SED_INPLACE "s,-lexpat,-L\\\$\\(EXPAT_LIBDIR\\) -lexpat," makefile

    # Uncomment the correct line on OS X (and remove the line for Linux)
    if [[ $(uname) == Darwin ]]; then
        $SED_INPLACE "s,^LIB_OPTION=.*,," config
        $SED_INPLACE "s,^#LIB_OPTION=\(.*\) #for MacOS X,LIB_OPTION=\1 #for MacOS X," config
    fi

    # Don't be explicit about which compiler to use
    $SED_INPLACE "s,^CC = \(.*\),," config
}
