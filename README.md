# Documentation
Full on Documentation soon to be generate with Sphinx.
## References
 - [RaysLogic](http://www.rayslogic.com/propeller/programming/AdafruitRGB/AdafruitRGB.htm)
  - [Useful DataSheet for driver chips](http://www.rayslogic.com/propeller/programming/AdafruitRGB/MBI5026.pdf)
## Architecture
The current architecture is somewhat as presented below.
![System Architecture](Documentation/Content/System_Schematic.svg)
# Tasks
## Display Logic
 - [ ] Confirm logic is functional with verilator
 - [ ] Display streak free colors on the FPGA
 - [ ] Display entire image on FPGA
 - [ ] Rewrite display logic to be addressable
 - [ ] Drive with single frame buffer
 - [ ] Write LibPNG wrapper for display logic

## Frame Buffer
