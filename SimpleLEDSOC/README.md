# Simple LED SOC

The hardware components of the SoC include:

1)An Arm Cortex-M0 microprocessor 

2)An AHB-Lite system bus 

3)Two AHB peripherals : 

    1) Program memory (implemented using on-chip memory blocks) 
    
    2)A simple LED peripheral
    
## LED SOC design(Architecture)
![Screenshot](images/Lab4_image1.png)

## ARM Cortex-m0
The logic of the Arm Cortex-M0 processor is written in Verilog code, and thus can be prototyped (synthesized and implemented) on an FPGA platform. The Cortex-M0 DesignStart has almost the same functionality of an industry-standard Cortex-M0 processor, except that some features are reduced; e.g., the number of interrupts is reduced from the original 32 to 16 interrupts.

Files used from ARM IP : 
     1) cortexm0ds_logic.v
     2) CORTEXM0INTEGRATION.v
     3) AHBMUX.v
     4) AHBDCD.v
     
Link for ARM IP : https://developer.arm.com/products/designstart

