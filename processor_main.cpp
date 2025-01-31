// DESCRIPTION: Verilator: Verilog example module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2017 by Wilson Snyder.
//======================================================================

// Include common routines
#include <verilated.h>

#include <sys/stat.h>  // mkdir

// Include model header, generated from Verilating "processor.v"
#include "Vprocessor.h"

// If "verilator --trace" is used, include the tracing class
#if VM_TRACE
# include <verilated_vcd_c.h>
#endif

// Current simulation time (64-bit unsigned)
vluint64_t main_time = 0;
// Called by $time in Verilog
double sc_time_stamp () {
    return main_time; // Note does conversion to real, to match SystemC
}

#define MAX_SIM_TIME 100000 //max simulation time

int main(int argc, char** argv, char** env) {
    // This is a more complicated example, please also see the simpler examples/hello_world_c.

    // Prevent unused variable warnings
    if (0 && argc && argv && env) {}
    // Pass arguments so Verilated code can see them, e.g. $value$plusargs
    Verilated::commandArgs(argc, argv);

    // Set debug level, 0 is off, 9 is highest presently used
    Verilated::debug(0);

    // Randomization reset policy
    Verilated::randReset(2);

    // Construct the Verilated model, from Vprocessor.h generated from Verilating "processor.v"
    Vprocessor* processor = new Vprocessor; // Or use a const unique_ptr, or the VL_UNIQUE_PTR wrapper

#if VM_TRACE
    // If verilator was invoked with --trace argument,
    // and if at run time passed the +trace argument, turn on tracing
    VerilatedVcdC* tfp = NULL;
    const char* flag = Verilated::commandArgsPlusMatch("trace");
    if (flag && 0==strcmp(flag, "+trace")) {
        Verilated::traceEverOn(true);  // Verilator must compute traced signals
        VL_PRINTF("Enabling waves into logs/wave.vcd...\n");
        tfp = new VerilatedVcdC;
        processor->trace(tfp, 99);  // Trace 99 levels of hierarchy
        mkdir("logs", 0777);
        tfp->open("logs/wave.vcd");  // Open the dump file
    }
#endif

    // Set some inputs
    processor->reset = 1;

    // Simulate until $finish
    while (!Verilated::gotFinish() && (main_time <= MAX_SIM_TIME)) {
        

        // reset signal remains for 1000 ns(100 cycles)
        if(main_time > 1000){
	    processor->reset = 0;
        }
        if ((main_time % 10) == 1) { // 1 cycle is 10 ns
            processor->clk = 1;
        }
        if ((main_time % 10) == 6) {
            processor->clk = 0;
        }

        // Evaluate model
        processor->eval();

        tfp->dump(main_time);//dump wave
        main_time++;  // Time passes...
    }

    // Final model cleanup
    processor->final();

    // Close trace if opened
#if VM_TRACE
    if (tfp) { tfp->close(); }
#endif

    //  Coverage analysis (since test passed)
#if VM_COVERAGE
    mkdir("logs", 0777);
    VerilatedCov::write("logs/coverage.dat");
#endif

    // Destroy model
    delete processor; processor = NULL;

    // Fin
    exit(0);
}
