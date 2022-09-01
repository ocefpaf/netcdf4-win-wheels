for %%f in (%PREFIX%\*.whl) do (
  "%PYTHON%" -m pip install %%f
)
"%PYTHON%" -c "import netCDF4"
