# Compilers Project

For this project, you need to install [Java](https://jdk.java.net/), [Gradle](https://gradle.org/install/). Please check the [compatibility matrix](https://docs.gradle.org/current/userguide/compatibility.html) for Java and Gradle versions.


## Project setup

There are some import folders in the repository. The development source code is inside the subfolder named ``src/main``. Specifically, your initially application is in the folder ``src/main/pt/up/fe/comp2023``, and the grammar is in the subfolder ``src/main/antlr/comp2023/grammar``. Finally, the subfolder named ``test`` contains the unit tests.


## Compile and Running

To compile and install the program, run ``gradle installDist``. This will compile the classes and create a launcher script in the folder ``./build/install/jmm/bin``. For convenience, there are two script files in the root folder, one for Windows (``jmm.bat``) and another for Linux (``jmm``), that call this launcher script.

After compilation, a series of tests will be automatically executed. The build will stop if any test fails. Whenever you want to ignore the tests and build the program anyway, you can call Gradle with the flag ``-x test``.


## Tests

The base repository comes with classes that contains unitary tests in the package ``pt.up.fe.comp``.

To test the program, run ``gradle test``. This will execute the build, and run the JUnit tests in the ``test`` folder. If you want to see output printed during the tests, use the flag ``-i`` (i.e., ``gradle test -i``).

You can also see a test report by opening the file ``./build/reports/tests/test/index.html``.


### Reports

We also included in this project the class ``pt.up.fe.comp.jmm.report.Report``. This class is used to generate important reports, including error and warning messages, but also can be used to include debugging and logging information.


### Compilation Stages 

The project is divided in four compilation stages, that you will be developing during the semester. The stages are Parser, Analysis, Optimization and Backend.

The parser stage is responsible for parsing the input program and generating an Abstract Syntax Tree (AST). The analysis stage is responsible for checking the program for semantic errors. The optimization stage is responsible for generating an OLLIR representation of the program and apply the requested optimizations. The backend stage is responsible for generating the final code in Jasmin assembly language.


### Optimizations

The optimizations are responsible for improving the code generated by the compiler. The optimizations are applied to the OLLIR representation of the program, and are implemented in the class ``pt.up.fe.comp.jmm.ollir.Optimization``.
There are two optimizations implemented in the base repository: ``ConstantFolding`` and ``ConstantPropagation``. The first optimization is responsible for evaluating constant expressions, and the second optimization is responsible for replacing variables by their constant values.

We also applied optimizations to the jasmine code, namely:
- Load constants to the stack with the appropriate instruction (e.g. ``iconst_0`` instead of ``ldc 0``)
- Use of iinc (e.g. ``iinc 1 1`` instead of ``iload 1``, ``iconst_1``, ``iadd``, ``istore 1``)
- Use of 'iflt' instead of 'if_icmplt'
- Use of 'iload_x' instead of 'iload x' when x is a variable


### config.properties

The testing framework, which uses the class ``pt.up.fe.comp.TestUtils``, has methods to test each of the four compilation stages (e.g., ``TestUtils.parse()`` for testing the Parser stage). 

In order for the test class to find your implementations for the stages, it uses the file ``config.properties`` that is in root of the repository. It has four fields, one for each stage (i.e. ``ParserClass``, ``AnalysisClass``, ``OptimizationClass``, ``BackendClass``).


### Authors

This project was developed by:
- João Pinheiro
- José Araújo
- Ricardo Cavalheiro

Percentage of work distribution:
- João Pinheiro: 33%
- José Araújo: 33%
- Ricardo Cavalheiro: 33%

Self-assessment: 19/20

Extra elements:
- Support of any conditional operator (e.g. <, >, <=, >=, ==, !=)