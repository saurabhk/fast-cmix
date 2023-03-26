# fast cmix-hp
A faster version of cmix-hp. All the compile/run instructions below stay applicable.

# cmix-hp

Submission for the [Hutter Prize](http://prize.hutter1.net/).

v1 submitted on June 10, 2021.

v2 submitted on August 1, 2021. v2 is faster than v1, but has worse compression rate.

v3 submitted on August 9, 2021. v3 gets a slightly better compression rate than v2 (but is slower). v2 was not above the 1% improvement threshold on a testing computer.

# Submission Description
This submission contains some small modifications on top of the recent [STARLIT](https://github.com/amargaritov/starlit) Hutter Prize winner.

Below is the cmix-hp v3 result:

| Metric | Value |
| --- | ----------- |
| cmix-hp compressor's executable file size (S1)| 396929 bytes |
| cmix-hp self-extracting archive size (S2)| 113733212 bytes |
| Total size (S) | 114130141 bytes |
| Previous record (L) | 115352938 bytes |
| cmix-hp improvement (1 - S/L) | 1.06% |

| Experiment platform |  |
| --- | ----------- |
| Operating system | Ubuntu 20.04 |
| Processor | Intel Core i7-7700K @ 4.20GHz (Geekbench score 1288) |
| Memory | 32 GB DDR4 |
| Decompression running time | 42.8 hours |
| Decompression RAM max usage | 6905 MiB |
| Decompression disk usage | ~35GB |

Time, disk, and RAM usage are approximately symmetric for compression and decompression.

Here is a comparison between different entries on this computer:

| Name | running time (hours) | S1 | S2 |
| --- | --- | --- | --- |
| STARLIT | 44.13 | 401264 | 114920105 |
| cmix-hp v1 | 45.44 | 397242 | 113688192 |
| cmix-hp v2 | 41.94 | 396779 | 113760510 |
| cmix-hp v3 | 42.8 | 396929 | 113733212 |

# cmix-hp algorithm description
The submission has several small tweaks on top of STARLIT. The most substantial change is to have a huge PPM model, which gets swapped to disk to improve memory usage.

# Changes to STARLIT for v1
* Changed mod_ppmd from v3 to v2, which supports a higher memory limit.
* Used one PPM model (order-25) instead of two.
* Used mmap to store PPM memory to disk (reducing RAM usage).
* Added a limit to the cmix context mixer size to make it more memory efficient.
* Made the PAQ8HP context mixer use a hash map, to reduce memory usage.
* Memory tuning for PAQ8HP: shifted more memory to wordModel.
* Reduced memory usage for some cmix models, and removed "Direct" models.
* Removed some unused preprocessor code.

# Speed improvements for v2
* Exported fewer model predictions from PAQ8HP to the cmix mixer.
* Removed some cmix context mixers.

# Compression improvements for v2
Thanks to Kaido Orav for these suggested improvements:

* Swapped certain byte regions during preprocessing - a trick originally used in PAQ8HP.
* Improved handling of zero state in PAQ8HP mixer.
* Better handling of UTF characters in PAQ8HP.

# Changes for v3
* Added back two of the cmix context mixers (which were removed in v2).

# Instructions
The installation and usage instructions for cmix-hp are the same as for STARLIT. For convenience, most of the information below is copied from STARLIT documentation.

One important note: it is recommended to change one variable in the source code for PPM. From line 26 in src/models/ppmd.cpp:

```
// If mmap_to_disk is set to false (recommended setting), PPM will only use RAM
// for memory.
// If mmap_to_disk is set to true, PPM memory will be saved to disk using mmap.
// This will reduce RAM usage, but will be slower as well. *Warning*: this will
// write a *lot* of data to disk, so can reduce the lifespan of SSDs. Not
// recommended for normal usage.
bool mmap_to_disk = true;
```

This variable is set to true by default, to comply with the Hutter Prize RAM limit.

# Installing packages required for compiling cmix-hp compressor from sources on Ubuntu
Building cmix-hp compressor from sources requires clang-12, upx-ucl, and make packages. On Ubuntu, these packages can be installed by running the following scripts:
```bash
./install_tools/install_upx.sh
./install_tools/install_clang-12.sh
```

# Compiling cmix-hp compressor from sources
A bash script is provided for compiling cmix-hp compressor from sources on Ubuntu. This script places the cmix-hp executable file named as `cmix` in `./run` directory. The script can be run as
```bash
./build_and_construct_comp.sh
```

# Running cmix-hp compressor
To run the cmix-hp compressor use
```bash
cd ./run
cmix -e <PATH_TO_ENWIK9> enwik9.comp
```

Expected output:
```
78125 bytes -> 415377 bytes in 74.17 s.
199784 bytes -> 1131233 bytes in 184.88 s.
Detected block types: TEXT: 100.0%
934188796 bytes -> 113536067 bytes in 155972.59 s.
free(): invalid size
Command terminated by signal 6
```
The error message does not affect the compression validity.

# Running cmix-hp decompressor
The compressor is expected to output an executable file named `archive9` in the same directory (`./run`). The file `archive9` when executed is expected to reproduce the original enwik9 as a file named `enwik9_restored`. The executable file `archive9` should be launched without argments from the directory containing it. 
```bash
cd ./run
./archive9
```

Expected output:
```
78125 bytes -> 415377 bytes in 72.31 s.
113536067 bytes -> 934188796 bytes in 154012.40 s.
```

# Acknowelegments
Thanks to:

* Artemiy Margaritov for releasing STARLIT - it is a great achievement.
* Eugene Shelwien for releasing mod_ppmd - an essential component for this submission.
* Kaido Orav for suggesting improvements for cmix-hp v2.

# Open-source projects used in this submission
* [This is a link to the original STARLIT repo](https://github.com/amargaritov/starlit)

