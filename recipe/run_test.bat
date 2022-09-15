for %%f in (%PREFIX%\*.whl) do (
  "%PYTHON%" -m pip install %%f
)
"%PYTHON%" -m pip install pytest cython

set NO_CDL=1 && cd test && "%PYTHON%" run_all.py || exit 1
"%PYTHON%" -c "import netCDF4" || exit 1
