# source https://developer.apple.com/metal/tensorflow-plugin/ (2021-02-13)
conda_version=$(conda -V)
echo $conda_version

if [[ $conda_version != conda* ]]
then
  # install conda -> on mac miniforge
  curl https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh
  chmod +x ~/Downloads/Miniforge3-MacOSX-arm64.sh
  sh ~/Downloads/Miniforge3-MacOSX-arm64.sh
  source conda activate
else
  echo "Conda already installed"
fi

# install tensorflow deps
conda install -c apple -y tensorflow-deps

# install tensorflow for mac
# install metal version for M1 dependencies
yes | python -m pip install tensorflow-macos tensorflow-metal

echo 'Installation completed, now testing tensorflow...'

echo "import tensorflow as tf" > tf_test.py
echo "print(f'Tensorflow is loaded and has version {tf.__version__}')" >> tf_test.py
python tf_test.py

echo 'Cleaning up...'
rm tf_test.py

echo 'Installation is tested and runs now on Mac M1!'
echo 'Compeleted'