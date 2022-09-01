set SITECFG=%SRC_DIR%/setup.cfg

echo [options] > %SITECFG%
echo use_cython=True >> %SITECFG%
echo [directories] >> %SITECFG%
echo HDF5_libdir = %LIBRARY_LIB% >> %SITECFG%
echo HDF5_incdir = %LIBRARY_INC% >> %SITECFG%
echo netCDF4_libdir = %LIBRARY_LIB% >> %SITECFG%
echo netCDF4_incdir = %LIBRARY_INC% >> %SITECFG%

%PYTHON% -m pip wheel . --wheel-dir=dist --no-deps --no-build-isolation
if errorlevel 1 exit 1

REM set dep_dir=%LIBRARY_BIN%
REM python %RECIPE_DIR%\fix_windows_wheel.py %dep_dir%\mpir.dll %dep_dir%\mpfr.dll %dep_dir%\mpc.dll %dep_dir%\flint-16.dll %dep_dir%\pthreadVSE2.dll %dep_dir%\zlib.dll
REM if errorlevel 1 exit 1

mkdir %RECIPE_DIR%\..\build_artifacts
mkdir %RECIPE_DIR%\..\build_artifacts\pypi_wheels

for %%f in (dist\*.whl) do (
  cp %%f %RECIPE_DIR%\..\build_artifacts\pypi_wheels\
  %PYTHON% -m pip install %%f
)
