ifeq ("$(shell which fpc 2>/dev/null)","")
$(error Free Pascal Compiler not found.)
endif

TMP	?= /tmp
OS	?= linux
ARCH	?= x86_64
FPC	?= fpc

FLAGS		= -Sc -Sg -Sh -Si -XX -MObjFPC
ifdef PACKBIN
FLAGS		+= -dPACKBIN
endif
FLAGS_DEBUG	= -O1 -Sa -gs -dMEMCHECK -gl -dDEBUG
FLAGS_RELEASE	= -O3 -Xs -CX

INCLUDE=-FuZenGames/Engines/ZenGL/headers \
		-FiZenGames/Engines/ZenGL/headers \
		-FuZenGames/Engines/ZenGL/extra \
		-FuZenGames/Engines/ZenGL/src \
		-FuZenGames/Engines/MondoZenGL

LIBS=-FuZenGames/Engines/ZenGL/lib/jpeg/$(ARCH)-$(OS) \
		-FuZenGames/Engines/ZenGL/lib/ogg/$(ARCH)-$(OS) \
		-FuZenGames/Engines/ZenGL/lib/theora/$(ARCH)-$(OS) \
		-FuZenGames/Engines/ZenGL/lib/zlib/$(ARCH)-$(OS) \
		-FuZenGames/Engines/ZenGL/lib/zip/$(ARCH)-$(OS)

release: FLAGS += $(FLAGS_RELEASE)
release: $(OUTPUT)

debug:  FLAGS += $(FLAGS_DEBUG)
debug: $(OUTPUT)

$(OUTPUT):
	$(FPC) $(MAIN) $(INCLUDE) $(LIBS)  -FU$(TMP) $(FLAGS) -o$(OUTPUT) -TLINUX

.PHONY: clean

clean:
	rm $(TMP)/{*.o,*.ppu} $(OUTPUT)
