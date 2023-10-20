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

mkdir %RECIPE_DIR%\..\build_artifacts
mkdir %RECIPE_DIR%\..\build_artifacts\pypi_wheels

cd dist
for %%f in (*.whl) do (
  delvewheel repair -w %RECIPE_DIR%\..\build_artifacts\pypi_wheels\ %%f
  copy %RECIPE_DIR%\..\build_artifacts\pypi_wheels\%%f %PREFIX%\
)
