
#编译参数
CC = g++
SHARED := -fPIC --shared
CFLAGS = -g -O2 -Wall -I$(LUA_INC) -L$(LUA_INC) -llua

#path
LUA_STATICLIB := lua/liblua.a
LUA_LIB ?= $(LUA_STATICLIB)
LUA_INC ?= lua

LUA_CLIB_PATH ?= lib
LUA_CLIB_SRC ?= lib-src

#platform

PLAT ?= macosx
PLATS = linux macosx

.PHONY : default all linux macosx

default : PLAT = macosx
default:
	$(MAKE) $(PLAT)
linux macosx :
	$(MAKE) all PLAT=$@

#liblua
all : $(LUA_LIB)
$(LUA_STATICLIB) :
	cd lua && $(MAKE) $(PLAT)


#mylib

LUA_CLIB = test

$(LUA_CLIB_PATH) :
	mkdir $(LUA_CLIB_PATH)

all : \
  $(foreach v, $(LUA_CLIB), $(LUA_CLIB_PATH)/$(v).so)

$(LUA_CLIB_PATH)/test.so : $(LUA_CLIB_SRC)/test.cpp | $(LUA_CLIB_PATH)
	$(CC) $(CFLAGS) $(SHARED) $^ -o $@


#clean
clean :
	rm -f $(LUA_CLIB_PATH)/*.so

cleanall: clean
	cd $(LUA_INC) && $(MAKE) clean
	rm -f $(LUA_STATICLIB)
