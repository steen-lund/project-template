CC    = gcc
#CC    = clang
STRIP = strip

# Specify your target name here, this will appear in the bin folder
TARGET  =
VERSION = 1


OPTIMIZE = -O2
DEBUG    = -g
INCLUDES = -I. -I./include
DEFINES  = 
WARNINGS = -Wall -Wwrite-strings -Werror

CFLAGS  = $(OPTIMIZE) $(DEBUG) $(INCLUDES) $(DEFINES) $(WARNINGS)
LDFLAGS =  
LIBS    = 

STRIPFLAGS = 

# Add your source files here, do not include "src/" folder name this script will automatically include that
SRCS = 
OBJS = $(addprefix obj/,$(SRCS:.c=.o))
DEPS = $(OBJS_000:.o=.d)

.PHONY: all
all: bin/$(TARGET)

-include $(DEPS)

obj/%.o: src/%.c
	@mkdir -p $(dir $@)
	$(CC) -MM -MP -MT $(@:.o=.d) -MT $@ -MF $(@:.o=.d) $(ARCH_000) $(CFLAGS) $<
	$(CC) $(CFLAGS) -c -o $@ $<

bin/$(TARGET): $(OBJS)
	@mkdir -p $(dir $@)
	$(CC) $(LDFLAGS) -o $@.debug $^ $(LIBS)
	$(STRIP) $(STRIPFLAGS) -o $@ $@.debug

.PHONY: clean
clean:
	rm -rf bin obj

