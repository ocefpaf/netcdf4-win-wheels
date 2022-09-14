for %%f in (%PREFIX%\*.whl) do (
  "%PYTHON%" -m pip install %%f
)
"%PYTHON%" -m pip install pytest

cd test && "%PYTHON%" run_all.py
"%PYTHON%" -c "import netCDF4"
