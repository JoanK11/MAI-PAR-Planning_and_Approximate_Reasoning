PDDL Project: Rescue Drone Task

Overview
--------
This project involves the implementation of a rescue drone problem using Planning Domain Definition Language (PDDL). The PDDL files are designed to work with planners that support numeric fluents and types. We have used Metric-FF as our planner for testing and execution.

Requirements
------------
To run the PDDL codes, you need to download and install a planner that supports numeric fluents and types, such as Metric-FF. You can download Metric-FF from their official webpage:

Metric-FF Planner: https://fai.cs.uni-saarland.de/hoffmann/metric-ff.html

Alternatively, any other planner with similar support for numeric fluents and types can be used.

Installation of Metric-FF
-------------------------
To install Metric-FF:

1. Download the planner from the official Metric-FF webpage: https://fai.cs.uni-saarland.de/hoffmann/metric-ff.html
2. Follow the instructions provided in their README file for installation on your system. Metric-FF requires compiling from source, so ensure you have the necessary build tools (e.g., gcc, make) installed.

Execution Instructions
----------------------
Once you have installed Metric-FF, you can execute the planner using the following command:

    ./ff -o domain.pddl -f problemX.pddl

Where:
- domain.pddl is the PDDL file containing the domain definition.
- problemX.pddl is the PDDL file containing the problem instance to solve.

Example:
    ./ff -o domain.pddl -f problem1.pddl

This will run Metric-FF with the domain and problem files specified, solving the rescue drone task based on the defined constraints and actions.

Project Structure
-----------------
- domain.pddl: Contains the domain definition, including types, predicates, and actions.
- problemX.pddl: Contains various problem instances defined for testing the planner.

Notes
-----
- Ensure that the planner is properly installed and that the environment variables are correctly set (if needed) to run ./ff.
- You may modify the PDDL files to create new problem instances or adjust the domain as per your experimental needs.
