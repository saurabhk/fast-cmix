# Fast-cmix


## A direct link to a self-extracting archive archive9.exe (or decomp9.exe+archive9.bhm)
https://drive.google.com/file/d/1qz62mSG1JVsS_uKe6k_viH5cTsssTTmO/view?usp=share_link

## A single line of instruction how to execute it (long/complicated instructions are inadmissable)
```
./build_and_construct_comp.sh
# Running cmix-hp compressor
cd ./run
cmix -e <PATH_TO_ENWIK9> enwik9.comp
# Running  decompressor
cd ./run
./archive9
```

## Names of all involved program(s), version, and used options if any
Clang-13 (Other recent clang versions should produce similar results)
UPX
GNU Make
Operation System - Ubuntu

## Sizes of (de)comp9(a) and most important archive9.exe/bhm
archive9: 113746218 Apr 20 16:06 archive9
Cmix (compressor): 409937
Total: 114156155

## Approximate (de)compression time and maximal main and HDD memory used
Fast-cmix is expected to run around 10% faster than cmix-hp. The total compression/decompression will depend on the machine used. I expect it to take 45-50 hours on the test box based on cmix-hp/startlit runtimes which should meet that 50 hour runtime requirement.
	On my test machine, it took around 37 hours for each step.
	Maximum resident set size (kbytes): 8473292
	HDD Usage: 29.5 G (same as cmix-hp)
Description of the test machine (processor, memory, operating system, Geekbench5 score)
CPU: Intel Core i7-10700
RAM: 16 GB
OS: Ubuntu
Geekbench 5 score: 1267
## Links where all files can be downloaded:
Executables (or zipped source) and well-documented source code under some OSI license of (de)compressor and all other relevant files
https://drive.google.com/drive/folders/15ChUkq7RmmoShSn_xD9K2ZRLIHK7GfIP?usp=share_link
## A (link to a) document explaining the (algorithmic) ideas that led to or are incorporated into the algorithms and their inner working
The fast-cmix is a faster implementation of cmix-hp. It runs faster due to a bunch of different improvements leading to more optimized code. It does not rely on any new hardware to achieve faster runtime. Primarily, the following ideas led to a significant speedup in the performance of the code:
Eliminating all the virtual function calls in the fast path. Virtual calls are indirect calls, which means that the compiler cannot inline them and some aggressive optimizations are not possible.
Improving cache locality of the data structures by storing data next to each other and avoiding pointers where possible. Cache locality refers to the tendency of data that is used together to be stored in the same part of the CPU's cache. By storing data next to each other, the compiler was able to ensure that the data was more likely to be in the CPU's cache when it was needed, which improved performance.
Using alternate implementations of hash-maps/hash-sets which are known to be faster. There are many different implementations of hash-maps and hash-sets, and some are faster than others. By using a faster implementation, the code was able to perform hash lookups more quickly.
Fast-cmix opens up the possibility to increase the complexity of the models further such as the number of neurons in LSTM to improve the accuracy of prediction. The first version does not submit any changes in this direction in the spirit of meeting the timing on the official test machine. Subsequent versions are expected to be submitted contingent on timing.
Usage/compilation instructions
Please refer to README.md.
The program can be compiled and run in exactly the same way as cmix-hp/starlit.

## Appendix
Performance improvement based on experiments on Intel(R) Core(TM) i7-10700 CPU @ 2.90GHz with SSD.
Overall gain
(old_runtime - new_runtime)/old_run_time = 9.06 %
### cmix hp
```
934188796 bytes -> 113599198 bytes in 148339.69 s.
munmap_chunk(): invalid pointer
Command terminated by signal 6
        Command being timed: "./cmix -e ../../data/enwik9 enwik9.comp"
        User time (seconds): 141398.30
        System time (seconds): 7178.88
        Percent of CPU this job got: 99%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 41:17:46
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 7064972
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 1149221434
        Minor (reclaiming a frame) page faults: 1197715053
        Voluntary context switches: 43539
        Involuntary context switches: 961990
        Swaps: 0
        File system inputs: 8004816
        File system outputs: 6193223696
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0
```
### fast-cmix
```
Detected block types: TEXT: 100.0%saurabhk/src/hutter/cmix-hp$
Number of possible words: 0 vocab size: 204
num models 403
934188796 bytes -> 113599196 bytes in 134886.35 s.
munmap_chunk(): invalid pointer
Command terminated by signal 6
        Command being timed: "./cmix -e ../../data/enwik9 enwik9.comp"
        User time (seconds): 129549.44
        System time (seconds): 5559.55
        Percent of CPU this job got: 99%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 37:33:17
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 8511280
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 1071170542
        Minor (reclaiming a frame) page faults: 867046625
        Voluntary context switches: 45936
        Involuntary context switches: 673089
        Swaps: 0
        File system inputs: 6845240
        File system outputs: 6033875536
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0
```



