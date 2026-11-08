CC ?= cc
CXX ?= c++
CFLAGS ?= -O2 -g -std=c11 -Wall -Wextra -Wpedantic
CXXFLAGS ?= -O2 -g -std=c++11 -Wall -Wextra -Wpedantic
CPPFLAGS ?= -Isrc
BUILD ?= build

all: $(BUILD)/test_core

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/ln_random.o: src/ln_random.c src/ln_random.h src/third_party/numpy_ziggurat_constants.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_hypergeometric.o: src/ln_hypergeometric.c src/ln_random.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_multinomial.o: src/ln_multinomial.c src/ln_random.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_dirichlet.o: src/ln_dirichlet.c src/ln_random.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_multivariate_normal.o: src/ln_multivariate_normal.c src/ln_multivariate_normal.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_multivariate_hypergeometric.o: src/ln_multivariate_hypergeometric.c src/ln_random.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_half.o: src/ln_half.c src/ln_half.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_complex_math.o: src/ln_complex_math.c src/ln_complex_math.h src/ln_complex.h | $(BUILD)
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_string.o: src/ln_string.c src/ln_string.h src/ln_core.h src/ln_dtype_transfer.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_datetime.o: src/ln_datetime.c src/ln_datetime.h src/ln_core.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_datetime_strings.o: src/ln_datetime_strings.c src/ln_datetime_strings.h src/ln_datetime.h src/ln_core.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_core.o: src/ln_core.c src/ln_core.h src/ln_half.h src/ln_complex.h src/ln_datetime.h src/ln_string.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_dtype_transfer.o: src/ln_dtype_transfer.c src/ln_dtype_transfer.h src/ln_core.h src/ln_half.h src/ln_complex.h src/ln_datetime.h src/ln_string.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_ufunc_loops.o: src/ln_ufunc_loops.c src/ln_ufunc_loops.h src/ln_core.h src/ln_half.h src/ln_complex.h src/ln_complex_math.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fwrapv -fPIC -c $< -o $@

$(BUILD)/ln_nditer_multi.o: src/ln_nditer_multi.c src/ln_nditer_multi.h src/ln_core.h src/ln_dtype_transfer.h src/ln_ufunc_loops.h src/ln_datetime.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_ufunc.o: src/ln_ufunc.c src/ln_ufunc.h src/ln_nditer_multi.h src/ln_ufunc_loops.h src/ln_core.h src/ln_datetime.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_mapping.o: src/ln_mapping.c src/ln_mapping.h src/ln_core.h src/ln_dtype_transfer.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_nditer.o: src/ln_nditer.c src/ln_nditer.h src/ln_core.h src/ln_dtype_transfer.h src/ln_ufunc_loops.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_matmul.o: src/ln_matmul.c src/ln_matmul.h src/ln_core.h src/ln_half.h src/ln_dtype_transfer.h src/ln_ufunc_loops.h src/ln_complex.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_insert.o: src/ln_insert.c src/ln_insert.h src/ln_dtype_transfer.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_delete.o: src/ln_delete.c src/ln_delete.h src/ln_core.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_join.o: src/ln_join.c src/ln_join.h src/ln_core.h src/ln_dtype_transfer.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_repeat.o: src/ln_repeat.c src/ln_repeat.h src/ln_core.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_quantile.o: src/ln_quantile.c src/ln_quantile.h src/ln_dtype_transfer.h src/ln_core.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_average.o: src/ln_average.c src/ln_average.h src/ln_dtype_transfer.h src/ln_core.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_stats.o: src/ln_stats.c src/ln_stats.h src/ln_dtype_transfer.h src/ln_core.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_truth.o: src/ln_truth.c src/ln_truth.h src/ln_core.h src/ln_dtype_transfer.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_roll.o: src/ln_roll.c src/ln_roll.h src/ln_core.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_axis.o: src/ln_axis.c src/ln_axis.h src/ln_core.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_split.o: src/ln_split.c src/ln_split.h src/ln_core.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_dot.o: src/ln_dot.c src/ln_dot.h src/ln_core.h src/ln_half.h src/ln_dtype_transfer.h src/ln_ufunc_loops.h src/ln_complex.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fwrapv -fPIC -c $< -o $@

$(BUILD)/ln_sort.o: src/ln_sort.c src/ln_sort.h src/ln_core.h src/ln_half.h src/ln_complex.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_fft.o: src/ln_fft.cpp src/ln_fft.h src/ln_core.h src/ln_dtype_transfer.h src/ln_complex.h src/ln_half.h src/third_party/pocketfft/pocketfft_hdronly.h | $(BUILD)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -fPIC -c $< -o $@

$(BUILD)/ln_linalg.o: src/ln_linalg.c src/ln_linalg.h src/ln_core.h src/ln_dtype_transfer.h src/ln_complex.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/test_core_main.o: tests/test_core.c src/ln_split.h src/ln_repeat.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_core: $(BUILD)/test_core_main.o $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o $(BUILD)/ln_multinomial.o $(BUILD)/ln_dirichlet.o $(BUILD)/ln_multivariate_normal.o $(BUILD)/ln_half.o $(BUILD)/ln_complex_math.o $(BUILD)/ln_string.o $(BUILD)/ln_datetime.o $(BUILD)/ln_datetime_strings.o $(BUILD)/ln_core.o $(BUILD)/ln_dtype_transfer.o $(BUILD)/ln_ufunc_loops.o $(BUILD)/ln_nditer_multi.o $(BUILD)/ln_ufunc.o $(BUILD)/ln_mapping.o $(BUILD)/ln_write.o $(BUILD)/ln_take.o $(BUILD)/ln_nditer.o $(BUILD)/ln_matmul.o $(BUILD)/ln_dot.o $(BUILD)/ln_join.o $(BUILD)/ln_delete.o $(BUILD)/ln_insert.o $(BUILD)/ln_split.o $(BUILD)/ln_axis.o $(BUILD)/ln_repeat.o $(BUILD)/ln_roll.o $(BUILD)/ln_stats.o $(BUILD)/ln_average.o $(BUILD)/ln_truth.o $(BUILD)/ln_quantile.o $(BUILD)/ln_sort.o $(BUILD)/ln_fft.o $(BUILD)/ln_linalg.o
	$(CXX) $(LDFLAGS) $^ -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

test: $(BUILD)/test_core $(BUILD)/test_repeat_core $(BUILD)/test_roll_core $(BUILD)/test_atleast_core $(BUILD)/test_delete_core $(BUILD)/test_insert_core $(BUILD)/test_extrema_core $(BUILD)/test_selection_core $(BUILD)/test_quantile_core $(BUILD)/test_nanquantile_core $(BUILD)/test_nanreductions_core $(BUILD)/test_nanextrema_core $(BUILD)/test_cumulative_core $(BUILD)/test_truth_core $(BUILD)/test_average_core
	./$(BUILD)/test_core
	./$(BUILD)/test_repeat_core
	./$(BUILD)/test_roll_core
	./$(BUILD)/test_atleast_core
	./$(BUILD)/test_delete_core
	./$(BUILD)/test_insert_core
	./$(BUILD)/test_extrema_core
	./$(BUILD)/test_selection_core
	./$(BUILD)/test_quantile_core
	./$(BUILD)/test_nanquantile_core
	./$(BUILD)/test_nanreductions_core
	./$(BUILD)/test_nanextrema_core
	./$(BUILD)/test_cumulative_core
	./$(BUILD)/test_truth_core
	./$(BUILD)/test_average_core

clean:
	rm -rf $(BUILD)

# Discover an existing Lua 5.4 development/runtime library instead of
# assuming a Debian multiarch path (Omarchy/Arch commonly uses /usr/lib).
# Override explicitly with `make LUA_SO=/path/to/liblua5.4.so` if needed.
LUA_SO ?= $(shell \
	for name in lua5.4 lua-5.4 lua54; do \
		if command -v pkg-config >/dev/null 2>&1 && pkg-config --exists $$name; then pkg-config --libs $$name; exit 0; fi; \
	done; \
	for path in /usr/lib/liblua5.4.so /usr/lib/liblua5.4.so.0 /lib/x86_64-linux-gnu/liblua5.4.so.0; do \
		if test -r $$path; then echo $$path; exit 0; fi; \
	done; \
	echo -llua5.4)
BLAS_LIBS ?= $(shell \
	if command -v pkg-config >/dev/null 2>&1 && pkg-config --exists cblas; then pkg-config --libs cblas; \
	elif command -v pkg-config >/dev/null 2>&1 && pkg-config --exists openblas; then pkg-config --libs openblas; \
	else echo -lblas; fi)
LAPACK_LIBS ?= -llapack

$(BUILD)/lua_module.o: src/lua_module.c src/ln_take.h src/ln_write.h src/ln_random.h src/ln_multivariate_normal.h src/lua_compat.h src/ln_core.h src/ln_string.h src/ln_ufunc.h src/ln_nditer_multi.h src/ln_mapping.h src/ln_nditer.h src/ln_matmul.h src/ln_dot.h src/ln_join.h src/ln_delete.h src/ln_insert.h src/ln_split.h src/ln_axis.h src/ln_repeat.h src/ln_roll.h src/ln_stats.h src/ln_average.h src/ln_truth.h src/ln_sort.h src/ln_fft.h src/ln_linalg.h src/ln_datetime.h src/ln_datetime_strings.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/luaray_core.so: $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o $(BUILD)/ln_multinomial.o $(BUILD)/ln_dirichlet.o $(BUILD)/ln_multivariate_normal.o $(BUILD)/ln_half.o $(BUILD)/ln_complex_math.o $(BUILD)/ln_string.o $(BUILD)/ln_datetime.o $(BUILD)/ln_datetime_strings.o $(BUILD)/ln_core.o $(BUILD)/ln_dtype_transfer.o $(BUILD)/ln_ufunc_loops.o $(BUILD)/ln_nditer_multi.o $(BUILD)/ln_ufunc.o $(BUILD)/ln_mapping.o $(BUILD)/ln_write.o $(BUILD)/ln_take.o $(BUILD)/ln_nditer.o $(BUILD)/ln_matmul.o $(BUILD)/ln_dot.o $(BUILD)/ln_join.o $(BUILD)/ln_delete.o $(BUILD)/ln_insert.o $(BUILD)/ln_split.o $(BUILD)/ln_axis.o $(BUILD)/ln_repeat.o $(BUILD)/ln_roll.o $(BUILD)/ln_stats.o $(BUILD)/ln_average.o $(BUILD)/ln_truth.o $(BUILD)/ln_quantile.o $(BUILD)/ln_sort.o $(BUILD)/ln_fft.o $(BUILD)/ln_linalg.o $(BUILD)/lua_module.o
	$(CXX) $(LDFLAGS) -shared $^ $(LUA_SO) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

$(BUILD)/lunumpy_core.so: $(BUILD)/luaray_core.so
	cp $< $@

$(BUILD)/lua_runner_main.o: tests/lua_runner.c | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/lua_runner: $(BUILD)/lua_runner_main.o $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o $(BUILD)/ln_multinomial.o $(BUILD)/ln_dirichlet.o $(BUILD)/ln_multivariate_normal.o $(BUILD)/ln_half.o $(BUILD)/ln_complex_math.o $(BUILD)/ln_string.o $(BUILD)/ln_datetime.o $(BUILD)/ln_datetime_strings.o $(BUILD)/ln_core.o $(BUILD)/ln_dtype_transfer.o $(BUILD)/ln_ufunc_loops.o $(BUILD)/ln_nditer_multi.o $(BUILD)/ln_ufunc.o $(BUILD)/ln_mapping.o $(BUILD)/ln_write.o $(BUILD)/ln_take.o $(BUILD)/ln_nditer.o $(BUILD)/ln_matmul.o $(BUILD)/ln_dot.o $(BUILD)/ln_join.o $(BUILD)/ln_delete.o $(BUILD)/ln_insert.o $(BUILD)/ln_split.o $(BUILD)/ln_axis.o $(BUILD)/ln_repeat.o $(BUILD)/ln_roll.o $(BUILD)/ln_stats.o $(BUILD)/ln_average.o $(BUILD)/ln_truth.o $(BUILD)/ln_quantile.o $(BUILD)/ln_sort.o $(BUILD)/ln_fft.o $(BUILD)/ln_linalg.o $(BUILD)/lua_module.o
	$(CXX) $(LDFLAGS) $^ $(LUA_SO) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

lua-test: $(BUILD)/luaray_core.so $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/memory97_regression.lua
	./$(BUILD)/lua_runner tests/average_regression.lua
	./$(BUILD)/lua_runner tests/truth_regression.lua
	./$(BUILD)/lua_runner tests/cumulative_regression.lua
	./$(BUILD)/lua_runner tests/cumulative_differential_generated.lua
	./$(BUILD)/lua_runner tests/nanextrema_regression.lua
	./$(BUILD)/lua_runner tests/nanextrema_differential_generated.lua
	./$(BUILD)/lua_runner tests/smoke.lua
	./$(BUILD)/lua_runner tests/join_regression.lua
	./$(BUILD)/lua_runner tests/split_regression.lua
	./$(BUILD)/lua_runner tests/axis_regression.lua
	./$(BUILD)/lua_runner tests/broadcast_regression.lua
	./$(BUILD)/lua_runner tests/repeat_regression.lua
	./$(BUILD)/lua_runner tests/roll_regression.lua
	./$(BUILD)/lua_runner tests/atleast_regression.lua
	./$(BUILD)/lua_runner tests/shape_stack_regression.lua
	./$(BUILD)/lua_runner tests/append_delete_regression.lua
	./$(BUILD)/lua_runner tests/insert_regression.lua
	./$(BUILD)/lua_runner tests/stats_regression.lua
	./$(BUILD)/lua_runner tests/extrema_regression.lua
	./$(BUILD)/lua_runner tests/selection_regression.lua
	./$(BUILD)/lua_runner tests/quantile_regression.lua
	./$(BUILD)/lua_runner tests/nanquantile_regression.lua
	./$(BUILD)/lua_runner tests/nanreductions_regression.lua
	./$(BUILD)/lua_runner tests/join_differential_generated.lua
	./$(BUILD)/lua_runner tests/split_differential_generated.lua
	./$(BUILD)/lua_runner tests/axis_differential_generated.lua
	./$(BUILD)/lua_runner tests/broadcast_differential_generated.lua
	./$(BUILD)/lua_runner tests/repeat_differential_generated.lua
	./$(BUILD)/lua_runner tests/roll_differential_generated.lua
	./$(BUILD)/lua_runner tests/atleast_differential_generated.lua
	./$(BUILD)/lua_runner tests/shape_stack_differential_generated.lua
	./$(BUILD)/lua_runner tests/append_delete_differential_generated.lua
	./$(BUILD)/lua_runner tests/insert_differential_generated.lua

# Run *every* checked-in oracle fixture, not just the recent subset in
# lua-test.  This target never invokes Python and does not regenerate data.
fixture-test: $(BUILD)/luaray_core.so $(BUILD)/lua_runner
	@set -eu; count=0; for fixture in tests/*_differential_generated.lua; do \
		printf '[fixture] %s\n' "$$fixture"; \
		./$(BUILD)/lua_runner "$$fixture"; count=$$((count+1)); \
	done; printf 'All %s differential fixture files passed\n' "$$count"

full-test: test lua-test fixture-test random-test integers-test normal-test exponential-test distributions55-test distributions56-test distributions57-test distributions58-test distributions59-test distributions60-test distributions61-test distributions62-test distributions63-test distributions64-test distributions65-test distributions66-test distributions67-test distributions68-test distributions69-test distributions70-test distributions71-test shuffle72-test permuted73-test choice74-test mvn75-test random76-test random77-test random78-test random79-test random80-test random81-test random82-test random83-test random84-test random85-test random86-test random87-test random88-test random89-test random90-test


oracle-test: full-test
	python3 tools/generate_exponential_differential.py
	./$(BUILD)/lua_runner tests/exponential_differential_generated.lua
	python3 tools/generate_normal_differential.py
	./$(BUILD)/lua_runner tests/normal_differential_generated.lua
	python3 tools/generate_integers_differential.py
	./$(BUILD)/lua_runner tests/integers_differential_generated.lua
	python3 tools/generate_random_differential.py
	./$(BUILD)/lua_runner tests/random_differential_generated.lua
	python3 tools/generate_average_differential.py
	./$(BUILD)/lua_runner tests/average_differential_generated.lua
	python3 tools/generate_truth_differential.py
	./$(BUILD)/lua_runner tests/truth_differential_generated.lua
	python3 tools/generate_nanextrema_differential.py
	./$(BUILD)/lua_runner tests/nanextrema_differential_generated.lua
	python3 tools/generate_nanreductions_differential.py
	./$(BUILD)/lua_runner tests/nanreductions_differential_generated.lua
	python3 tools/generate_nanquantile_differential.py
	./$(BUILD)/lua_runner tests/nanquantile_differential_generated.lua
	python3 tools/generate_quantile_differential.py
	./$(BUILD)/lua_runner tests/quantile_differential_generated.lua
	python3 tools/generate_selection_differential.py
	python3 tools/generate_stats_differential.py
	python3 tools/generate_extrema_differential.py
	python3 tools/generate_join_differential.py
	python3 tools/generate_split_differential.py
	python3 tools/generate_axis_differential.py
	python3 tools/generate_broadcast_differential.py
	python3 tools/generate_repeat_differential.py
	python3 tools/generate_roll_differential.py
	python3 tools/generate_atleast_differential.py
	python3 tools/generate_shape_stack_differential.py
	python3 tools/generate_append_delete_differential.py
	python3 tools/generate_insert_differential.py
	python3 tools/generate_promotion_differential.py
	./$(BUILD)/lua_runner tests/join_differential_generated.lua
	./$(BUILD)/lua_runner tests/split_differential_generated.lua
	./$(BUILD)/lua_runner tests/axis_differential_generated.lua
	./$(BUILD)/lua_runner tests/broadcast_differential_generated.lua
	./$(BUILD)/lua_runner tests/repeat_differential_generated.lua
	./$(BUILD)/lua_runner tests/roll_differential_generated.lua
	./$(BUILD)/lua_runner tests/atleast_differential_generated.lua
	./$(BUILD)/lua_runner tests/shape_stack_differential_generated.lua
	./$(BUILD)/lua_runner tests/append_delete_differential_generated.lua
	./$(BUILD)/lua_runner tests/insert_differential_generated.lua
	python3 tools/generate_differential.py
	python3 tools/generate_semantics_differential.py
	python3 tools/generate_mixed_ufunc_differential.py
	python3 tools/generate_reduction_differential.py
	python3 tools/generate_mean_differential.py
	python3 tools/generate_advanced_indexing_differential.py
	python3 tools/generate_more_ufunc_differential.py
	python3 tools/generate_nditer_differential.py
	python3 tools/generate_extended_reduction_differential.py
	python3 tools/generate_accumulate_differential.py
	python3 tools/generate_reduceat_differential.py
	python3 tools/generate_matmul_differential.py
	python3 tools/generate_dot_differential.py
	python3 tools/generate_sorting_differential.py
	python3 tools/generate_searchsorted_differential.py
	python3 tools/generate_catalog_ufunc_differential.py
	python3 tools/generate_numeric_ops_differential.py
	python3 tools/generate_math_ufunc_differential.py
	python3 tools/generate_half_differential.py
	python3 tools/generate_complex_differential.py
	python3 tools/generate_complex_math_differential.py
	python3 tools/generate_extended_math_differential.py
	python3 tools/generate_inverse_math_differential.py
	python3 tools/generate_fft_differential.py
	python3 tools/generate_fftnd_differential.py
	python3 tools/generate_promotion_differential.py
	python3 tools/generate_linalg_differential.py
	python3 tools/generate_qr_differential.py
	python3 tools/generate_eigen_svd_differential.py
	python3 tools/generate_linalg_advanced_differential.py
	python3 tools/generate_linalg_surface_differential.py
	python3 tools/generate_multiout_ufunc_differential.py
	python3 tools/generate_registry_migration_differential.py
	python3 tools/generate_weak_scalar_registry_differential.py
	python3 tools/generate_unary_registry_differential.py
	python3 tools/generate_datetime_differential.py
	python3 tools/generate_datetime_strings_differential.py
	python3 tools/generate_string_differential.py
	python3 tools/generate_string_cast_differential.py
	python3 tools/generate_casting_policy_differential.py
	./$(BUILD)/lua_runner tests/differential_generated.lua
	./$(BUILD)/lua_runner tests/mixed_ufunc_differential_generated.lua
	./$(BUILD)/lua_runner tests/indexing_differential_generated.lua
	./$(BUILD)/lua_runner tests/casting_differential_generated.lua
	./$(BUILD)/lua_runner tests/reshape_differential_generated.lua
	./$(BUILD)/lua_runner tests/assignment_differential_generated.lua
	./$(BUILD)/lua_runner tests/reduction_differential_generated.lua
	./$(BUILD)/lua_runner tests/mean_differential_generated.lua
	./$(BUILD)/lua_runner tests/advanced_indexing_differential_generated.lua
	./$(BUILD)/lua_runner tests/advanced_assignment_differential_generated.lua
	./$(BUILD)/lua_runner tests/more_ufunc_differential_generated.lua
	./$(BUILD)/lua_runner tests/nditer_differential_generated.lua
	./$(BUILD)/lua_runner tests/extended_reduction_differential_generated.lua
	./$(BUILD)/lua_runner tests/accumulate_differential_generated.lua
	./$(BUILD)/lua_runner tests/reduceat_differential_generated.lua
	./$(BUILD)/lua_runner tests/matmul_differential_generated.lua
	./$(BUILD)/lua_runner tests/dot_differential_generated.lua
	./$(BUILD)/lua_runner tests/sorting_differential_generated.lua
	./$(BUILD)/lua_runner tests/searchsorted_differential_generated.lua
	./$(BUILD)/lua_runner tests/catalog_ufunc_differential_generated.lua
	./$(BUILD)/lua_runner tests/numeric_ops_differential_generated.lua
	./$(BUILD)/lua_runner tests/math_ufunc_differential_generated.lua
	./$(BUILD)/lua_runner tests/half_differential_generated.lua
	./$(BUILD)/lua_runner tests/complex_differential_generated.lua
	./$(BUILD)/lua_runner tests/complex_math_differential_generated.lua
	./$(BUILD)/lua_runner tests/extended_math_differential_generated.lua
	./$(BUILD)/lua_runner tests/inverse_math_differential_generated.lua
	./$(BUILD)/lua_runner tests/fft_differential_generated.lua
	./$(BUILD)/lua_runner tests/fftnd_differential_generated.lua
	./$(BUILD)/lua_runner tests/promotion_differential_generated.lua
	./$(BUILD)/lua_runner tests/linalg_differential_generated.lua
	./$(BUILD)/lua_runner tests/qr_differential_generated.lua
	./$(BUILD)/lua_runner tests/eigen_svd_differential_generated.lua
	./$(BUILD)/lua_runner tests/linalg_advanced_differential_generated.lua
	./$(BUILD)/lua_runner tests/linalg_surface_differential_generated.lua
	./$(BUILD)/lua_runner tests/multiout_ufunc_differential_generated.lua
	./$(BUILD)/lua_runner tests/registry_migration_differential_generated.lua
	./$(BUILD)/lua_runner tests/weak_scalar_registry_differential_generated.lua
	./$(BUILD)/lua_runner tests/unary_registry_differential_generated.lua
	./$(BUILD)/lua_runner tests/datetime_differential_generated.lua
	./$(BUILD)/lua_runner tests/datetime_strings_differential_generated.lua
	./$(BUILD)/lua_runner tests/string_differential_generated.lua
	./$(BUILD)/lua_runner tests/string_cast_differential_generated.lua
	./$(BUILD)/lua_runner tests/casting_policy_differential_generated.lua

# Repetition kernels have a native test independent of the Lua adapter.
$(BUILD)/test_repeat_main.o: tests/test_repeat_core.c src/ln_repeat.h src/ln_axis.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_repeat_core: $(BUILD)/test_repeat_main.o $(BUILD)/test_core
	$(CXX) $(LDFLAGS) $(BUILD)/test_repeat_main.o $(filter-out %_san.o $(BUILD)/test_repeat_main.o $(BUILD)/test_core_main.o,$(wildcard $(BUILD)/ln_*.o)) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

repeat-native-test: $(BUILD)/test_repeat_core
	./$(BUILD)/test_repeat_core

.PHONY: repeat-native-test

# Rolling is tested directly against the host-neutral C kernel, without Lua.
$(BUILD)/test_roll_main.o: tests/test_roll_core.c src/ln_roll.h src/ln_axis.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_roll_core: $(BUILD)/test_roll_main.o $(BUILD)/test_core
	$(CXX) $(LDFLAGS) $(BUILD)/test_roll_main.o $(filter-out %_san.o $(BUILD)/test_repeat_main.o $(BUILD)/test_roll_main.o $(BUILD)/test_core_main.o,$(wildcard $(BUILD)/ln_*.o)) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

# Direct C validation of the native atleast view implementation.
$(BUILD)/test_atleast_main.o: tests/test_atleast_core.c src/ln_axis.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_atleast_core: $(BUILD)/test_atleast_main.o $(BUILD)/test_core
	$(CXX) $(LDFLAGS) $(BUILD)/test_atleast_main.o $(filter-out %_san.o $(BUILD)/test_atleast_main.o $(BUILD)/test_core_main.o,$(wildcard $(BUILD)/ln_*.o)) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

# Copy-producing deletion tests, independent of the Lua boundary.
$(BUILD)/test_delete_main.o: tests/test_delete_core.c src/ln_delete.h src/ln_axis.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_delete_core: $(BUILD)/test_delete_main.o $(BUILD)/test_core
	$(CXX) $(LDFLAGS) $(BUILD)/test_delete_main.o $(filter-out %_san.o $(BUILD)/test_delete_main.o $(BUILD)/test_repeat_main.o $(BUILD)/test_roll_main.o $(BUILD)/test_atleast_main.o $(BUILD)/test_core_main.o,$(wildcard $(BUILD)/ln_*.o)) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

# Native C insertion checks independent of Lua's argument conversion.
$(BUILD)/test_insert_main.o: tests/test_insert_core.c src/ln_insert.h src/ln_axis.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_insert_core: $(BUILD)/test_insert_main.o $(BUILD)/test_core
	$(CXX) $(LDFLAGS) $(BUILD)/test_insert_main.o $(filter-out %_san.o $(BUILD)/test_insert_main.o $(BUILD)/test_delete_main.o $(BUILD)/test_repeat_main.o $(BUILD)/test_roll_main.o $(BUILD)/test_atleast_main.o $(BUILD)/test_core_main.o,$(wildcard $(BUILD)/ln_*.o)) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

# Direct C coverage for extrema reductions, including overlapping `out`.
$(BUILD)/test_extrema_main.o: tests/test_extrema_core.c src/ln_stats.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_extrema_core: $(BUILD)/test_extrema_main.o $(BUILD)/test_core
	$(CXX) $(LDFLAGS) $(BUILD)/test_extrema_main.o $(filter-out %_san.o $(BUILD)/test_extrema_main.o $(BUILD)/test_core_main.o,$(wildcard $(BUILD)/ln_*.o)) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

.PHONY: extrema-native-test
$(BUILD)/test_selection_main.o: tests/test_selection_core.c src/ln_stats.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_selection_core: $(BUILD)/test_selection_main.o $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o $(BUILD)/ln_multinomial.o $(BUILD)/ln_half.o $(BUILD)/ln_complex_math.o $(BUILD)/ln_string.o $(BUILD)/ln_datetime.o $(BUILD)/ln_datetime_strings.o $(BUILD)/ln_core.o $(BUILD)/ln_dtype_transfer.o $(BUILD)/ln_ufunc_loops.o $(BUILD)/ln_nditer_multi.o $(BUILD)/ln_ufunc.o $(BUILD)/ln_mapping.o $(BUILD)/ln_write.o $(BUILD)/ln_take.o $(BUILD)/ln_nditer.o $(BUILD)/ln_matmul.o $(BUILD)/ln_dot.o $(BUILD)/ln_join.o $(BUILD)/ln_delete.o $(BUILD)/ln_insert.o $(BUILD)/ln_split.o $(BUILD)/ln_axis.o $(BUILD)/ln_repeat.o $(BUILD)/ln_roll.o $(BUILD)/ln_stats.o $(BUILD)/ln_average.o $(BUILD)/ln_truth.o $(BUILD)/ln_quantile.o $(BUILD)/ln_sort.o $(BUILD)/ln_fft.o $(BUILD)/ln_linalg.o
	$(CXX) $(LDFLAGS) $^ -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

extrema-native-test: $(BUILD)/test_extrema_core
	./$(BUILD)/test_extrema_core

# Precision tests independently exercising the C quantile kernel.
$(BUILD)/test_quantile_main.o: tests/test_quantile_core.c src/ln_quantile.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_quantile_core: $(BUILD)/test_quantile_main.o $(BUILD)/test_core
	$(CXX) $(LDFLAGS) $(BUILD)/test_quantile_main.o $(filter-out %_san.o $(BUILD)/test_quantile_main.o $(BUILD)/test_selection_main.o $(BUILD)/test_extrema_main.o $(BUILD)/test_insert_main.o $(BUILD)/test_delete_main.o $(BUILD)/test_repeat_main.o $(BUILD)/test_roll_main.o $(BUILD)/test_atleast_main.o $(BUILD)/test_core_main.o,$(wildcard $(BUILD)/ln_*.o)) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

# Dedicated all-NaN, noncontiguous, aliasing and output-DType native tests.
$(BUILD)/test_nanquantile_main.o: tests/test_nanquantile_core.c src/ln_quantile.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_nanquantile_core: $(BUILD)/test_nanquantile_main.o $(BUILD)/test_core
	$(CXX) $(LDFLAGS) $(BUILD)/test_nanquantile_main.o $(filter-out %_san.o $(BUILD)/test_nanquantile_main.o $(BUILD)/test_quantile_main.o $(BUILD)/test_selection_main.o $(BUILD)/test_extrema_main.o $(BUILD)/test_insert_main.o $(BUILD)/test_delete_main.o $(BUILD)/test_repeat_main.o $(BUILD)/test_roll_main.o $(BUILD)/test_atleast_main.o $(BUILD)/test_core_main.o,$(wildcard $(BUILD)/ln_*.o)) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

# Native coverage for NaN masks and sample-count semantics.
$(BUILD)/test_nanreductions_main.o: tests/test_nanreductions_core.c src/ln_stats.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_nanreductions_core: $(BUILD)/test_nanreductions_main.o $(BUILD)/test_core
	$(CXX) $(LDFLAGS) $(BUILD)/test_nanreductions_main.o $(filter-out %_san.o $(BUILD)/test_nanreductions_main.o $(BUILD)/test_core_main.o,$(wildcard $(BUILD)/ln_*.o)) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

# Direct native coverage for the NaN-aware extrema and index kernel.
$(BUILD)/test_nanextrema_main.o: tests/test_nanextrema_core.c src/ln_stats.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_nanextrema_core: $(BUILD)/test_nanextrema_main.o $(BUILD)/test_core
	$(CXX) $(LDFLAGS) $(BUILD)/test_nanextrema_main.o $(filter-out %_san.o $(BUILD)/test_nanextrema_main.o $(BUILD)/test_core_main.o,$(wildcard $(BUILD)/ln_*.o)) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

# Native verification of precise unsigned integers, negative strides and
# NaN replacement before cumulative sum/product.
$(BUILD)/test_cumulative_main.o: tests/test_cumulative_core.c src/ln_stats.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_cumulative_core: $(BUILD)/test_cumulative_main.o $(BUILD)/test_core
	$(CXX) $(LDFLAGS) $(BUILD)/test_cumulative_main.o $(filter-out %_san.o $(BUILD)/test_cumulative_main.o $(BUILD)/test_nanextrema_main.o $(BUILD)/test_nanreductions_main.o $(BUILD)/test_core_main.o,$(wildcard $(BUILD)/ln_*.o)) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

# Native exact truth/count semantics including large integers and wide strings.
$(BUILD)/test_truth_main.o: tests/test_truth_core.c src/ln_truth.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_truth_core: $(BUILD)/test_truth_main.o $(BUILD)/test_core
	$(CXX) $(LDFLAGS) $(BUILD)/test_truth_main.o $(filter-out %_san.o $(BUILD)/test_truth_main.o $(BUILD)/test_core_main.o,$(wildcard $(BUILD)/ln_*.o)) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

$(BUILD)/test_average_main.o: tests/test_average_core.c src/ln_average.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

TEST_CORE_NATIVE_OBJECTS = $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o $(BUILD)/ln_multinomial.o $(BUILD)/ln_half.o $(BUILD)/ln_complex_math.o $(BUILD)/ln_string.o $(BUILD)/ln_datetime.o $(BUILD)/ln_datetime_strings.o $(BUILD)/ln_core.o $(BUILD)/ln_dtype_transfer.o $(BUILD)/ln_ufunc_loops.o $(BUILD)/ln_nditer_multi.o $(BUILD)/ln_ufunc.o $(BUILD)/ln_mapping.o $(BUILD)/ln_write.o $(BUILD)/ln_take.o $(BUILD)/ln_nditer.o $(BUILD)/ln_matmul.o $(BUILD)/ln_dot.o $(BUILD)/ln_join.o $(BUILD)/ln_delete.o $(BUILD)/ln_insert.o $(BUILD)/ln_split.o $(BUILD)/ln_axis.o $(BUILD)/ln_repeat.o $(BUILD)/ln_roll.o $(BUILD)/ln_stats.o $(BUILD)/ln_average.o $(BUILD)/ln_truth.o $(BUILD)/ln_quantile.o $(BUILD)/ln_sort.o $(BUILD)/ln_fft.o $(BUILD)/ln_linalg.o
$(BUILD)/test_average_core: $(BUILD)/test_average_main.o $(TEST_CORE_NATIVE_OBJECTS)
	$(CXX) $(LDFLAGS) $^ -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

$(BUILD)/test_random_core: tests/test_random_core.c $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

integers-test: $(BUILD)/test_random_core $(BUILD)/lua_runner
	./$(BUILD)/test_random_core
	./$(BUILD)/lua_runner tests/integers_regression.lua
	./$(BUILD)/lua_runner tests/integers_differential_generated.lua

random-test: $(BUILD)/test_random_core $(BUILD)/luaray_core.so $(BUILD)/lua_runner
	./$(BUILD)/test_random_core
	./$(BUILD)/lua_runner tests/random_regression.lua

# Normal distribution tests: no Python dependency when using stored fixture.
normal-test: $(BUILD)/test_random_core $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/normal_regression.lua
	./$(BUILD)/lua_runner tests/normal_differential_generated.lua

# Exponential distribution differential fixture, generated independently using NumPy.
exponential-test: $(BUILD)/test_random_core $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/exponential_regression.lua
	./$(BUILD)/lua_runner tests/exponential_differential_generated.lua


$(BUILD)/test_distributions55_core: tests/test_distributions55_core.c $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

distributions55-test: $(BUILD)/test_distributions55_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions55_core
	./$(BUILD)/lua_runner tests/distributions55_regression.lua
	./$(BUILD)/lua_runner tests/distributions55_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions55.lua

# NumPy 2.5.3-compatible Gumbel, logistic, Rayleigh and Weibull samplers.
$(BUILD)/test_distributions56_core: tests/test_distributions56_core.c $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

distributions56-test: $(BUILD)/test_distributions56_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions56_core
	./$(BUILD)/lua_runner tests/distributions56_regression.lua
	./$(BUILD)/lua_runner tests/distributions56_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions56.lua

# NumPy 2.5.3-compatible Pareto II, power and triangular samplers.
$(BUILD)/test_distributions57_core: tests/test_distributions57_core.c $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

distributions57-test: $(BUILD)/test_distributions57_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions57_core
	./$(BUILD)/lua_runner tests/distributions57_regression.lua
	./$(BUILD)/lua_runner tests/distributions57_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions57.lua

# Gamma, Beta and float32 standard-Gamma native and differential checks.
$(BUILD)/test_distributions58_core: tests/test_distributions58_core.c $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

distributions58-test: $(BUILD)/test_distributions58_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions58_core
	./$(BUILD)/lua_runner tests/distributions58_regression.lua
	./$(BUILD)/lua_runner tests/distributions58_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions58.lua

# 0.59 NumPy-compatible chi-square and Fisher F samplers.
$(BUILD)/test_distributions59_core: tests/test_distributions59_core.c $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

distributions59-test: $(BUILD)/test_distributions59_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions59_core
	./$(BUILD)/lua_runner tests/distributions59_regression.lua
	./$(BUILD)/lua_runner tests/distributions59_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions59.lua

# 0.60: independent NumPy fixtures for noncentral chi-square and F.
$(BUILD)/test_distributions60_core: tests/test_distributions60_core.c $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

distributions60-test: $(BUILD)/test_distributions60_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions60_core
	./$(BUILD)/lua_runner tests/distributions60_regression.lua
	./$(BUILD)/lua_runner tests/distributions60_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions60.lua

# 0.61: public Poisson distribution, exact PCG64-state fixtures.
$(BUILD)/test_distributions61_core: tests/test_distributions61_core.c $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

distributions61-test: $(BUILD)/test_distributions61_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions61_core
	./$(BUILD)/lua_runner tests/distributions61_regression.lua
	./$(BUILD)/lua_runner tests/distributions61_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions61.lua

# 0.62: binomial inversion and BTPE, exact NumPy PCG64 fixture.
$(BUILD)/test_distributions62_core: tests/test_distributions62_core.c $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

distributions62-test: $(BUILD)/test_distributions62_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions62_core
	./$(BUILD)/lua_runner tests/distributions62_regression.lua
	./$(BUILD)/lua_runner tests/distributions62_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions62.lua

# 0.63: NumPy Gamma--Poisson negative binomial with exact PCG64 fixture.
$(BUILD)/test_distributions63_core: tests/test_distributions63_core.c $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $< $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o -lm -o $@

distributions63-test: $(BUILD)/test_distributions63_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions63_core
	./$(BUILD)/lua_runner tests/distributions63_regression.lua
	./$(BUILD)/lua_runner tests/distributions63_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions63.lua

# 0.64: geometric (search/inversion), exact NumPy PCG64 fixtures.
$(BUILD)/test_distributions64_core: tests/test_distributions64_core.c $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $< $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o -lm -o $@

distributions64-test: $(BUILD)/test_distributions64_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions64_core
	./$(BUILD)/lua_runner tests/distributions64_regression.lua
	./$(BUILD)/lua_runner tests/distributions64_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions64.lua

# 0.65 Zipf rejection sampler and exact NumPy PCG64 comparisons.
$(BUILD)/test_distributions65_core: tests/test_distributions65_core.c $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $< $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o -lm -o $@

distributions65-test: $(BUILD)/test_distributions65_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions65_core
	./$(BUILD)/lua_runner tests/distributions65_regression.lua
	./$(BUILD)/lua_runner tests/distributions65_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions65.lua

# 0.66: hypergeometric, NumPy masked random_interval + HRUA.
$(BUILD)/test_distributions66_core: tests/test_distributions66_core.c $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

distributions66-test: $(BUILD)/test_distributions66_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions66_core
	./$(BUILD)/lua_runner tests/distributions66_regression.lua
	./$(BUILD)/lua_runner tests/distributions66_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions66.lua

# 0.67: multivariate hypergeometric (marginals and count), PCG64 fixture.
$(BUILD)/test_distributions67_core: tests/test_distributions67_core.c $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

distributions67-test: $(BUILD)/test_distributions67_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions67_core
	./$(BUILD)/lua_runner tests/distributions67_regression.lua
	./$(BUILD)/lua_runner tests/distributions67_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions67.lua

# 0.68 multinomial: sequential binomial matching PCG64 draw order.
$(BUILD)/test_distributions68_core: tests/test_distributions68_core.c $(BUILD)/ln_random.o $(BUILD)/ln_hypergeometric.o $(BUILD)/ln_multivariate_hypergeometric.o $(BUILD)/ln_multinomial.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

distributions68-test: $(BUILD)/test_distributions68_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions68_core
	./$(BUILD)/lua_runner tests/distributions68_regression.lua
	./$(BUILD)/lua_runner tests/distributions68_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions68.lua

# 0.69: Dirichlet gamma/beta sampler and verified PCG64 draw order.
$(BUILD)/test_distributions69_core: tests/test_distributions69_core.c $(BUILD)/ln_random.o $(BUILD)/ln_dirichlet.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

distributions69-test: $(BUILD)/test_distributions69_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions69_core
	./$(BUILD)/lua_runner tests/distributions69_regression.lua
	./$(BUILD)/lua_runner tests/distributions69_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions69.lua

# 0.70: NumPy native Wald/inverse-Gaussian and logseries scalar samplers.
$(BUILD)/test_distributions70_core: tests/test_distributions70_core.c $(BUILD)/ln_random.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

distributions70-test: $(BUILD)/test_distributions70_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions70_core
	./$(BUILD)/lua_runner tests/distributions70_regression.lua
	./$(BUILD)/lua_runner tests/distributions70_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions70.lua

# 0.71: NumPy standard Student's t and circular von Mises samplers.
$(BUILD)/test_distributions71_core: tests/test_distributions71_core.c $(BUILD)/ln_random.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

distributions71-test: $(BUILD)/test_distributions71_core $(BUILD)/lua_runner
	./$(BUILD)/test_distributions71_core
	./$(BUILD)/lua_runner tests/distributions71_regression.lua
	./$(BUILD)/lua_runner tests/distributions71_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_distributions71.lua

# 0.72: NumPy Generator.shuffle and Generator.permutation.
$(BUILD)/test_shuffle72_core: tests/test_shuffle72_core.c $(BUILD)/ln_random.o | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm -o $@

shuffle72-test: $(BUILD)/test_shuffle72_core $(BUILD)/lua_runner
	./$(BUILD)/test_shuffle72_core
	./$(BUILD)/lua_runner tests/shuffle72_regression.lua
	./$(BUILD)/lua_runner tests/shuffle72_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_shuffle72.lua

# 0.73: NumPy Generator.permuted -- independent shuffling along fibers.
permuted73-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/permuted73_regression.lua
	./$(BUILD)/lua_runner tests/permuted73_differential_generated.lua
	./$(BUILD)/lua_runner tests/permuted73_dtypes_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_permuted73.lua

# 0.74: NumPy Generator.choice, weighted/unweighted, replace/no-replace.
choice74-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/choice74_regression.lua
	./$(BUILD)/lua_runner tests/choice74_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_choice74.lua

# 0.75: NumPy Generator.multivariate_normal (svd/eigh/cholesky).
$(BUILD)/test_mvn75_factor: tests/test_mvn75_factor.c $(BUILD)/ln_multivariate_normal.o
	$(CC) $(CPPFLAGS) $(CFLAGS) $^ -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

mvn75-test: $(BUILD)/lua_runner $(BUILD)/test_mvn75_factor
	./$(BUILD)/test_mvn75_factor
	./$(BUILD)/lua_runner tests/mvn75_regression.lua
	./$(BUILD)/lua_runner tests/mvn75_differential_generated.lua
	./$(BUILD)/lua_runner examples/random_multivariate_normal75.lua

# 0.76: Generator.bytes() and Generator.random(dtype/out) compatibility.
random76-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/random76_regression.lua
	./$(BUILD)/lua_runner tests/random76_differential_generated.lua
	./$(BUILD)/lua_runner examples/random76.lua

# 0.77: broadcasted float64 parameters (normal, uniform, exponential).
random77-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/random77_regression.lua
	./$(BUILD)/lua_runner tests/random77_differential_generated.lua
	./$(BUILD)/lua_runner examples/random77.lua

# 0.78: vectorized parameters for eight continuous distributions.
random78-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/random78_regression.lua
	./$(BUILD)/lua_runner tests/random78_differential_generated.lua
	./$(BUILD)/lua_runner tests/random78_edge_generated.lua
	./$(BUILD)/lua_runner examples/random78.lua

# 0.79: rejection-sampling distribution parameter broadcasting.
random79-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/random79_regression.lua
	./$(BUILD)/lua_runner tests/random79_differential_generated.lua
	./$(BUILD)/lua_runner tests/random79_edge_generated.lua
	./$(BUILD)/lua_runner examples/random79.lua

# 0.80: broadcasted Generator.standard_gamma with independent float32 path.
random80-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/random80_regression.lua
	./$(BUILD)/lua_runner tests/random80_statistical.lua
	./$(BUILD)/lua_runner tests/random80_differential_generated.lua
	./$(BUILD)/lua_runner examples/random80.lua

# 0.81: standard_gamma nonfinite values, PCG64 and ndarray output.
random81-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/random81_regression.lua
	./$(BUILD)/lua_runner tests/random81_differential_generated.lua
	./$(BUILD)/lua_runner examples/random81.lua

# 0.82: broadcasted Wald and discrete logseries distributions.
random82-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/random82_regression.lua
	./$(BUILD)/lua_runner tests/random82_differential_generated.lua
	./$(BUILD)/lua_runner examples/random82.lua

# 0.83: vectorized geometric / poisson parameters with int64 output.
random83-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/random83_regression.lua
	./$(BUILD)/lua_runner tests/random83_differential_generated.lua
	./$(BUILD)/lua_runner examples/random83.lua

# 0.84 vectorized Binomial and negative Binomial compatibility
random84-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/random84_regression.lua
	./$(BUILD)/lua_runner tests/random84_differential_generated.lua
	./$(BUILD)/lua_runner examples/random84.lua

# 0.85 vectorized noncentral chi-square and noncentral F
random85-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/random85_regression.lua
	./$(BUILD)/lua_runner tests/random85_differential_generated.lua
	./$(BUILD)/lua_runner examples/random85.lua

# 0.86 three distribution families: Student-t, von Mises and triangular.
random86-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/random86_regression.lua
	./$(BUILD)/lua_runner tests/random86_differential_generated.lua
	./$(BUILD)/lua_runner examples/random86.lua

# 0.87 vectorized Zipf and hypergeometric.
random87-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/random87_regression.lua
	./$(BUILD)/lua_runner tests/random87_differential_generated.lua
	./$(BUILD)/lua_runner examples/random87.lua

# 0.88: native RNG standard distribution out buffers, C and Fortran contiguous.
random88-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/random88_regression.lua
	./$(BUILD)/lua_runner tests/random88_differential_generated.lua
	./$(BUILD)/lua_runner examples/random88.lua

# 0.89: broadcasted integer bounds, all native integer dtypes.
random89-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/random89_regression.lua
	./$(BUILD)/lua_runner tests/random89_differential_generated.lua
	./$(BUILD)/lua_runner examples/random89.lua

# 0.90: Fortran-transposed integer limits, lossless int64 Lua integer tables,
# and full-width signed range NumPy differential coverage.
random90-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/random90_regression.lua
	./$(BUILD)/lua_runner tests/random90_differential_generated.lua
	./$(BUILD)/lua_runner examples/random90.lua

# 0.91: NumPy 2.x numeric/parametric DType promotion and NEP 50 weak scalars.
dtype91-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/dtype91_regression.lua
	./$(BUILD)/lua_runner tests/dtype91_differential_generated.lua

full-test: dtype91-test

# NumPy 2.x ndarray.astype ordering/copy behavior (0.92)
dtype92-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/dtype92_regression.lua
	./$(BUILD)/lua_runner tests/dtype92_differential_generated.lua
	./$(BUILD)/lua_runner tests/dtype92_can_cast_differential_generated.lua

full-test: dtype92-test

# 0.93: NumPy scalar minimum dtype and extended ndarray.astype layout audit.
dtype93-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/dtype93_min_scalar_differential_generated.lua
	./$(BUILD)/lua_runner tests/dtype93_audit_differential_generated.lua

full-test: dtype93-test

# NumPy 2.x scalar DType hierarchy and Unicode scalar minimum DType (0.94).
dtype94-test: $(BUILD)/lua_runner
	./$(BUILD)/lua_runner tests/dtype94_differential_generated.lua

full-test: dtype94-test

# 0.98: flattened indexed and selection-counted writes.
$(BUILD)/ln_write.o: src/ln_write.c src/ln_write.h src/ln_mapping.h src/ln_core.h src/ln_dtype_transfer.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/test_write98_main.o: tests/test_write98_core.c src/ln_write.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_write98_core: $(BUILD)/test_write98_main.o $(BUILD)/ln_write.o $(BUILD)/test_core
	$(CXX) $(LDFLAGS) $(BUILD)/test_write98_main.o $(filter-out %_san.o,$(wildcard $(BUILD)/ln_*.o)) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

write98-test: $(BUILD)/test_write98_core $(BUILD)/lua_runner
	./$(BUILD)/test_write98_core
	./$(BUILD)/lua_runner tests/write98_regression.lua
	./$(BUILD)/lua_runner tests/put98_differential_generated.lua
	./$(BUILD)/lua_runner tests/place98_differential_generated.lua
	./$(BUILD)/lua_runner tests/write98_blocked.lua

full-test: write98-test

.PHONY: write98-test

sanitize-write98: $(BUILD)/lua_runner $(BUILD)/luaray_core.so
	python3 tools/sanitize_write98.py

release:
	python3 tools/release.py

.PHONY: sanitize-write98 release

$(BUILD)/test_memory99_main.o: tests/test_memory99_core.c src/ln_write.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_memory99_core: $(BUILD)/test_memory99_main.o $(BUILD)/ln_write.o $(BUILD)/test_core
	$(CXX) $(LDFLAGS) $(BUILD)/test_memory99_main.o $(filter-out %_san.o,$(wildcard $(BUILD)/ln_*.o)) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

memory99-test: $(BUILD)/test_memory99_core $(BUILD)/lua_runner
	./$(BUILD)/test_memory99_core
	./$(BUILD)/lua_runner tests/memory99_regression.lua
	./$(BUILD)/lua_runner tests/copyto99_differential_generated.lua
	./$(BUILD)/lua_runner tests/putmask99_differential_generated.lua

full-test: memory99-test
.PHONY: memory99-test

sanitize-memory99: $(BUILD)/lua_runner $(BUILD)/luaray_core.so
	python3 tools/sanitize_write98.py --memory99

.PHONY: sanitize-memory99

$(BUILD)/ln_take.o: src/ln_take.c src/ln_take.h src/ln_write.h src/ln_mapping.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD)/test_take100_main.o: tests/test_take100_core.c src/ln_take.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD)/test_take100_core: $(BUILD)/test_take100_main.o $(BUILD)/ln_take.o $(BUILD)/test_core
	$(CXX) $(LDFLAGS) $(BUILD)/test_take100_main.o $(filter-out %_san.o,$(wildcard $(BUILD)/ln_*.o)) -lm $(BLAS_LIBS) $(LAPACK_LIBS) -o $@

take100-test: $(BUILD)/test_take100_core $(BUILD)/lua_runner
	./$(BUILD)/test_take100_core
	./$(BUILD)/lua_runner tests/take100_regression.lua
	./$(BUILD)/lua_runner tests/take100_differential_generated.lua

full-test: take100-test
.PHONY: take100-test

sanitize-take100: $(BUILD)/lua_runner $(BUILD)/luaray_core.so
	python3 tools/sanitize_write98.py --memory99 --libm-fix --take100

.PHONY: sanitize-take100
