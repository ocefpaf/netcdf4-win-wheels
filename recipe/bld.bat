set SITECFG=%SRC_DIR%/setup.cfg

echo [options] > %SITECFG%
echo use_cython=True >> %SITECFG%
echo [directories] >> %SITECFG%
echo HDF5_libdir = %LIBRARY_LIB% >> %SITECFG%
echo HDF5_incdir = %LIBRARY_INC% >> %SITECFG%
echo netCDF4_libdir = %LIBRARY_LIB% >> %SITECFG%
echo netCDF4_incdir = %LIBRARY_INC% >> %SITECFG%

%PYTHON% -m pip wheel . --wheel-dir=dist --no-deps --no-build-isolation -vv
if errorlevel 1 exit 1

set dep_dir=%LIBRARY_BIN%
python %RECIPE_DIR%\fix_windows_wheel.py %dep_dir%\hdf5.dll %dep_dir%\netcdf.dll %dep_dir%\libcurl.dll %dep_dir%\libcrypto-3-x64.dll %dep_dir%\zlib.dll ^
  %dep_dir%\mfhdf.dll %dep_dir%\hdf5_hl.dll %dep_dir%\zip.dll %dep_dir%\libssh2.dll %dep_dir%\libbz2.dll %dep_dir%\xdr.dll %dep_dir%\hdf.dll
if errorlevel 1 exit 1

mkdir %RECIPE_DIR%\..\build_artifacts
mkdir %RECIPE_DIR%\..\build_artifacts\pypi_wheels

for %%f in (dist\*.whl) do (
  cp %%f %RECIPE_DIR%\..\build_artifacts\pypi_wheels\
  cp %%f %PREFIX%\
)
