# weakdes-curry

This program calculates the weak and semi-weak keys of the DES algorithm.

Keys are only 56-bit since the parity bits have been removed; any solution
that seeks to find the 64-bit keys with parity would have to adjust the
permutation tables and implement the parity calculation.

This program was implemented as an assignment of [INE5386 course](https://planos.inf.ufsc.br/modulos/programas/visualizar.php?disciplina=INE5386),
during the first quarter of 2006. It received a few improvements over time,
more recently to solve compilation issues on recent versions of KiCS and
mcc compilers.

## Compiling

This code should work as-is using the Münster Curry Compiler. Other Curry
compilers can be used, check the source code for more details.

Compilation is done by running `make`. Executable `weakdes` should be generated.

Default compilation flags contain `-static`, which is more compatible but
generates bigger executables. It can be removed if not required.

## Implementation

The search is performed by defining the subkeys in terms of the operations
required to derive them from the keys, then searching pairs of keys whose
list of subkeys are the same but in reverse order - ie, subkeys(key1) is
equal to reverse(subkeys(key2)).

The search is performed by a conjunction of two equational constraints:

a) on the resulting pair of keys - which are defined as tuples of booleans,
being each boolean non-deterministically defined as True or False via choice
operator (?);

b) on the subkey equality (above).

Finally, "findall" is used to collect all the pairs of keys that satisfying
the solution.

## Performance

perf output for a single run of the resulting process on a relatively modern
Core i7 processor:

 Performance counter stats:

```
          7.715942      task-clock:u (msec)       #    0.962 CPUs utilized
                 0      context-switches:u        #    0.000 K/sec
                 0      cpu-migrations:u          #    0.000 K/sec
               461      page-faults:u             #    0.060 M/sec
        21,654,439      cycles:u                  #    2.806 GHz
        31,416,527      instructions:u            #    1.45  insn per cycle
        10,961,660      branches:u                # 1420.651 M/sec
            95,109      branch-misses:u           #    0.87% of all branches

       0.008024480 seconds time elapsed
```

Top memory usage reported by massif is 18Mb, which stays stable during the
whole process execution.

