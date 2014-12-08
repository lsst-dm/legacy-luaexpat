# EupsPkg config file. Sourced by 'eupspkg'

# Breaks on Darwin w/o this
export LANG=C

config()
{
    sed -i '.prev' "s,LUA_LIBDIR= /usr/local/,LUA_LIBDIR= $LUA_DIR/," config &&
    sed -i '.prev' "s,LUA_DIR= /usr/local/,LUA_DIR= ${LUA_DIR}/," config &&
    sed -i '.prev' "s,LUA_INC= /usr/local/,LUA_INC= ${LUA_DIR}/," config &&
    sed -i '.prev' "s,5\.0,5\.1," config &&
    sed -i '.prev' "s,-O2,-O2 -fPIC," config &&
    sed -i '.prev' "s,LUA_VERSION_NUM= 500,LUA_VERSION_NUM= 514," config &&
    sed -i '.prev' "s,EXPAT_INC= /usr/local/\(.*\),EXPAT_INC=${EXPAT_DIR}/\1"\\$'\n'"EXPAT_LIBDIR=${EXPAT_DIR}/lib," config && 
    sed -i '.prev' "s,-lexpat,-L\\\$\\(EXPAT_LIBDIR\\) -lexpat," makefile

    # Uncomment the correct line on OS X (and remove the line for Linux)
    if [[ $(uname) == Darwin ]]; then
        sed -i '.prev' "s,^LIB_OPTION=.*,," config
        sed -i '.prev' "s,^#LIB_OPTION=\(.*\) #for MacOS X,LIB_OPTION=\1 #for MacOS X," config
    fi

    # Don't be explicit about which compiler to use
    sed -i '.prev' "s,^CC = \(.*\),," config
}
