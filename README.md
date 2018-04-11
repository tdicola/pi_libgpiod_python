# Raspberry Pi libgpiod Python

Docker container for the Raspberry Pi with the modern Linux GPIO character device
library libgpiod and a Python 3 wrapper around it.  Installs libgpiod and a simple
SWIG-based Python wrapper around it from: https://github.com/tdicola/libgpiod-python
Pull this from Docker hub under the tdicola/pi_libgpiod_python name.

Make sure to run with the --privileged flag or add the /dev/gpiochip*
devices to the container so it can access the host's hardware!
