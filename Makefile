# FIXME use cmake

# NOTE: This one Makefile works with Microsoft nmake and GNU make.
# They use different conditional syntax, but each can be nested and inverted within the other.

all: check

ifdef MAKEDIR:
!ifdef MAKEDIR

# Microsoft nmake on Windows. Visual C++.
CFLAGS=-MD -Gy -Z7 -EHsc -W4 -EHsc -WX -Gy -std:c++20 -nologo
CPPFLAGS=-MD -Gy -Z7 -EHsc -std:c++20 -W4 -EHsc -WX -Gy -nologo
CXXFLAGS=-MD -Gy -Z7 -EHsc -std:c++20 -W4 -EHsc -WX -Gy -nologo
CXX=cl

RM = del 2>nul
RM_F = $(RM) /f
#ILDASM = ildasm /nobar /out:$@
#ILASM = ilasm /quiet
#RUN_EACH=for %%a in (
#RUN_EACH_END=) do @$Q$(MONO)$Q %%a
O=obj
EXE=.exe

CLINK_FLAGS=/link /out:$@ /incremental:no /opt:ref /pdb:$(@B).pdb

!else
else

# GNU/Posix make on Unix with gcc, clang, etc.
RM = rm 2>/dev/null
RM_F = rm -f 2>/dev/null
O=o
EXE=
CXX=g++

CFLAGS=-g
CLINK_FLAGS=-o $@

endif
!endif :

check:

clean:

exe:

# jarray.$O \

OBJS=\

ifdef MAKEDIR:
!ifdef MAKEDIR

!if !defined (AMD64) && !defined (386) && !defined (ARM)
AMD64=1
386=0
ARM=0
!endif

!if $(AMD64)
win=winamd64$(EXE)
386=0
ARM=0
!elseif $(386)
win=winx86$(EXE)
AMD64=0
ARM=0
!elseif $(ARM)
win=winarm$(EXE)
AMD64=0
386=0
!endif

!ifndef win
win=win$(EXE)
!endif

all:

check:

!else
else

UNAME_S = $(shell uname -s)

ifeq ($(UNAME_S), Cygwin)
Cygwin=1
NativeTarget=cyg
else
Cygwin=0
Linux=0
endif

ifeq ($(UNAME_S), Linux)
Linux=1
NativeTarget=lin
else
Cygwin=0
endif

# TODO Darwin, Linux, etc.

# FIXME winarm64 etc.
#all: $(NativeTarget) win32$(EXE) win64$(EXE)
all:

test:

endif
!endif :

OBJS=\
libdef_linkage.obj libdef_linkage.lib \
libdef1.lib libdef2.lib objdef1.obj objdef2.obj \
 ref.$O \

# linkage1$(EXE)
all: \
 ref_and_linkage.lib \
 ref.lib \
 objref_libc$(EXE) \
 objref_libc_libdef$(EXE) \
 libdef1_objref_libc$(EXE) \
 libdef1_libref_libc$(EXE) \
 libdef1_libref_libdef2_libc$(EXE) \
 libdef2_libref_libdef1_libc$(EXE) \
 libdef2_libref_libdef1_libc_objdef1$(EXE) \

	@dir /s/b *.exe

LIBC=msvcrt.lib ucrt.lib vcruntime.lib kernel32.lib /nod /map

objref_libdef1_libc$(EXE): $(OBJS)
	$(CC) $(CFLAGS) $(Wall) $(Qspectre) main.c $(CLINK_FLAGS) ref.obj libdef1.lib $(LIBC)

# This works as people think. The def is from the lib, preceding the ref,
# because ref is in obj.
libdef1_objref_libc$(EXE): $(OBJS)
	$(CC) $(CFLAGS) $(Wall) $(Qspectre) main.c $(CLINK_FLAGS) libdef1.lib ref.obj $(LIBC)

# Now lets put the ref in a lib instead.
# This is what betrays people's understanding.
# The def is not the first on the command line, but the first following the ref.
# We'll build more samples.
libdef1_libref_libc$(EXE): $(OBJS)
	$(CC) $(CFLAGS) $(Wall) $(Qspectre) main.c $(CLINK_FLAGS) libdef1.lib ref.lib $(LIBC)

# Here we have our own two custom operator new. Which will be used, 1 or 2?
libdef1_libref_libdef2_libc$(EXE): $(OBJS)
	$(CC) $(CFLAGS) $(Wall) $(Qspectre) main.c $(CLINK_FLAGS) libdef1.lib ref.lib libdef2.lib $(LIBC)

# And the other way around.
libdef2_libref_libdef1_libc$(EXE): $(OBJS)
	$(CC) $(CFLAGS) $(Wall) $(Qspectre) main.c $(CLINK_FLAGS) libdef2.lib ref.lib libdef1.lib $(LIBC)

# And show that objs always win.
libdef2_libref_libdef1_libc_objdef1$(EXE): $(OBJS)
	$(CC) $(CFLAGS) $(Wall) $(Qspectre) main.c $(CLINK_FLAGS) libdef2.lib ref.lib libdef1.lib $(LIBC) objdef1.obj

# Def is in LIBC as expected.
# But this betrays the reading of the standard also.
# You cannot "just" replace operator new, and have it in a lib.
# Other lib can be favored.
objref_libc_libdef$(EXE): $(OBJS)
	$(CC) $(CFLAGS) $(Wall) $(Qspectre) main.c $(CLINK_FLAGS) ref.obj $(LIBC) libdef1.lib

# For sanity, check that msvcrt.lib is it, works, when we have no definition.
objref_libc$(EXE): $(OBJS)
	$(CC) $(CFLAGS) $(Wall) $(Qspectre) main.c $(CLINK_FLAGS) ref.obj $(LIBC)

# And now for the final exercise(s), given everything works about
# as predicted (I missed the ref in obj vs. lib aspect), try the associativity method.
# I have not gotten this to work.
linkage1$(EXE): $(OBJS)
	$(CC) $(CFLAGS) $(Wall) $(Qspectre) main.c $(CLINK_FLAGS) ref_and_linkage.lib $(LIBC) libdef1.lib libdef_linkage.lib

ref_and_linkage.obj: ref_and_linkage.cpp
	$(CC) -c $(CFLAGS) $(Wall) $(Qspectre) ref_and_linkage.cpp

ref_and_linkage.lib: ref_and_linkage.obj
	link /lib ref_and_linkage.obj /out:ref_and_linkage.lib

ref.obj: ref.cpp
	$(CC) -c $(CFLAGS) $(Wall) $(Qspectre) ref.cpp

ref.lib: $(@R).obj
	link /lib $(@R).obj /out:$@

libdef_linkage.obj libdef_linkage.lib libdef1.lib libdef2.lib objdef1.obj objdef2.obj: new_template.cpp
	$(CC) -c $(CFLAGS) $(Wall) $(Qspectre) new_template.cpp -Foobjdef1.obj -DNEW_NAME=objdef1
	$(CC) -c $(CFLAGS) $(Wall) $(Qspectre) new_template.cpp -Foobjdef2.obj -DNEW_NAME=objdef2
	$(CC) -c $(CFLAGS) $(Wall) $(Qspectre) new_template.cpp -Folibdef1.obj -DNEW_NAME=libdef1
	$(CC) -c $(CFLAGS) $(Wall) $(Qspectre) new_template.cpp -Folibdef2.obj -DNEW_NAME=libdef2
	$(CC) -c $(CFLAGS) $(Wall) $(Qspectre) new_template.cpp -Folibdef_linkage.obj -DNEW_NAME=libdef_linkage -DNEW_LINKAGE=1
	link /lib libdef1.obj /out:libdef1.lib
	link /lib libdef2.obj /out:libdef2.lib
	link /lib libdef_linkage.obj /out:libdef_linkage.lib

clean:
	$(RM_F) 1.csv 1.csv.index *.obj *.o *.lib *.exe *.ilk *.pdb *.map

realclean: clean
