# # # # # # # # # # # # # # # # # 
#
# You must define these:
#
#	MAIN	: Your sources files.
#
#	OUTPUT	: Your app game name.
#
# Optional:
#
#	TMP	: Place for temporary files (default: /tmp)
#
#	OS	: Platform (linux)
#
#	ARCH	: Architecture (x86_64)
#
#	FPC	: Compiler (fpc)
#
#
# # # # # # # # # # # # # # # # # 

# # # # # # # # # # # # # # # # # 
# 
# Build modes:
#
# 	make release
#
# 	make debug
#
# 	make clean
#
# 	make PACKBIN=1
#
# # # # # # # # # # # # # # # # # 



MAIN	= example/Main.pas

OUTPUT	= example/game



# Don't move. Allways last.
include ZenGames/Makefile

