CC ?= cc
CXX ?= c++
CPPFLAGS ?= -Isrc
CFLAGS ?= -O2 -g -std=c11 -Wall -Wextra -Wpedantic
CXXFLAGS ?= -O2 -g -std=c++11 -Wall -Wextra -Wpedantic
BUILD ?= build

LUA_SO ?= $(shell \
	for name in lua5.4 lua-5.4 lua54; do \
		if command -v pkg-config >/dev/null 2>&1 && pkg-config --exists $$name; then pkg-config --libs $$name; exit 0; fi; \
	done; \
	for path in /usr/lib/liblua5.4.so /usr/lib/liblua5.4.so.0 /lib/x86_64-linux-gnu/liblua5.4.so.0; do \
		if test -r $$path; then echo $$path; exit 0; fi; \
	done; echo -llua5.4)
BLAS_LIBS ?= $(shell \
	if command -v pkg-config >/dev/null 2>&1 && pkg-config --exists cblas; then pkg-config --libs cblas; \
	elif command -v pkg-config >/dev/null 2>&1 && pkg-config --exists openblas; then pkg-config --libs openblas; \
	else echo -lblas; fi)
LAPACK_LIBS ?= -llapack
NATIVE_LIBS = -lm $(BLAS_LIBS) $(LAPACK_LIBS)

CORE_OBJECTS = $(patsubst src/%.c,$(BUILD)/%.o,$(wildcard src/ln_*.c)) $(BUILD)/ln_fft.o
BINDING_OBJECTS = $(patsubst src/%.c,$(BUILD)/%.o,$(wildcard src/lua_*.c))
NATIVE_TESTS = $(patsubst tests/native/%.c,$(BUILD)/tests/%,$(wildcard tests/native/*.c))
LUA_TESTS = $(wildcard tests/lua/*_regression.lua) tests/lua/smoke.lua \
	tests/lua/creation107_stack.lua tests/lua/random80_statistical.lua tests/lua/write98_blocked.lua

# Match the arithmetic semantics used by the reference implementation.
EXTRA_ln_ufunc_loops = -fwrapv
EXTRA_ln_dot = -fwrapv
EXTRA_ln_unary_math = -ffp-contract=off
EXTRA_ln_arange = -ffp-contract=off

.PHONY: all test full-test native-test lua-test examples reference-test clean
all: $(BUILD)/luaray_core.so

$(BUILD)/%.o: src/%.c
	@mkdir -p "$(@D)"
	$(CC) $(CPPFLAGS) $(CFLAGS) $(EXTRA_$*) -MMD -MP -fPIC -c $< -o $@

$(BUILD)/ln_fft.o: src/ln_fft.cpp
	@mkdir -p "$(@D)"
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -MMD -MP -fPIC -c $< -o $@

$(BUILD)/luaray_core.so: $(CORE_OBJECTS) $(BINDING_OBJECTS)
	$(CXX) $(LDFLAGS) -shared $^ $(LUA_SO) $(NATIVE_LIBS) -o $@

$(BUILD)/runner.o: tests/runner.c
	@mkdir -p "$(@D)"
	$(CC) $(CPPFLAGS) $(CFLAGS) -MMD -MP -c $< -o $@

$(BUILD)/lua_runner: $(BUILD)/runner.o $(CORE_OBJECTS) $(BINDING_OBJECTS)
	$(CXX) $(LDFLAGS) $^ $(LUA_SO) $(NATIVE_LIBS) -o $@

$(BUILD)/tests/%.o: tests/native/%.c
	@mkdir -p "$(@D)"
	$(CC) $(CPPFLAGS) $(CFLAGS) -MMD -MP -c $< -o $@

$(BUILD)/tests/%: $(BUILD)/tests/%.o $(CORE_OBJECTS)
	$(CXX) $(LDFLAGS) $^ $(NATIVE_LIBS) -o $@

native-test: $(NATIVE_TESTS)
	@set -eu; for test in $(NATIVE_TESTS); do "$$test"; done

lua-test: $(BUILD)/lua_runner
	@set -eu; for test in $(LUA_TESTS); do LUA_PATH='./lua/?.lua;;' ./$(BUILD)/lua_runner "$$test"; done

test full-test: native-test lua-test

examples: $(BUILD)/luaray_core.so
	@set -eu; for example in examples/*.lua; do \
		LUA_PATH='./lua/?.lua;;' LUA_CPATH='./$(BUILD)/?.so;;' lua5.4 "$$example"; \
	done

# Download the pinned external oracle corpus only for an explicit reference run.
reference-test: $(BUILD)/luaray_core.so $(BUILD)/lua_runner
	LUARAY_BUILD_DIR='$(abspath $(BUILD))' sh tools/reference-tests.sh

clean:
	rm -rf -- $(BUILD)

.SECONDARY:
-include $(wildcard $(BUILD)/*.d $(BUILD)/tests/*.d)
