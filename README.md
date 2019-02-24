# eNote Interview - Coding Challenge

## Task

> For a given non-negative integer number N generate a series of integer numbers of length N and provide the counts of how many times each number occurs in the series. The count should be ranked in the descending order twice: by the count numbers and by the value of those numbers if the counts are identical.

### Example

- Input parameter N: 7
- Series generated (automatically): [1, 3, 5, -2, 1, 5, 11]
- Expected output:
```sh
Value   -   Count
5       -   2
1       -   2
11      -   1
3       -   1
-2      -   1
```   

### Expected Solution

> The expected result should be in a form of iOS application and will be tested on 11-inch iPad Pro device. The application should have an input field for the number N, a button to trigger the task execution and an area on the screen to print out the result. The choice of the components to provide the output is yours. 

## Solution Notes

### UI
- Supports all devices and orientations
- TextField allows only positiv numbers
- Allowed Characters `1234567890`
- Starting `0` are allowed if followed by different number 
- Statring `0` will be cut from created Int value
- Max valid value is `9223372036854775807` (Max Int)
- While executing task a activity indicator is displayed
- TextField is disabled while executing task
- Result will be displayed in a table view
- While executing a task with a large number `N` the table view will show preliminary results
- When process is started table view will be cleared

### Logic classes
#### Overview
| Classes | Short description |
| ------ | ------ |
| Generator | Creating random numbers |
| Analyzer | Analyzes occurrence of numbers |
| Sorter | Sorts the analyzed data by task criteria (value and amount)  |
| Mapper | Mapps raw data to objects |
| RangeCalculator | Calculates ranges depending on the a given number `N` |
| Worker | Coordinates all classes listed above |

#### Generator
- Generates random numbers for a given number `N`
- Random numbers are within a given range
- `IntervalRandomGenerator` can split process in different loops which can be continued if needed 
    - Generator will pause after a given interval (Default: 50000) and only continue if `continue()` method is called 

#### Analyzer
- Analyzes given number array
- Mapps occurrence of a number in a dictionary with number as key and the amount as value
- `MemoryStorageAnalyzer` keeps all analyzed data within the memory

#### Sorter
- Sorts analyzed dictionary by value and amount

#### Mapper
- Mapps sorted data to `ValueEntity` objects which can be displayed in the table view

#### RangeCalculator
- Calculates range for the creation of the random numbers
- To increase the repetition of numbers, the range is restricted to be less than the given number `N`
- `DivideRangeCalculator` will create the range for a given minimum range divisor and maximum range divisor
    - Example:
    - Given number `N`: 30
    - Minimum range divisor: -3
    - Minimum range: 30 / -3 = -10    
    - Maximum range divisor: 2
    - Maximum range: 30 / 2 = 15
    - Range: [-10, -9, -8, ... 0, 1, 2, 3, ..., 13, 14, 15]
- If an illegal value is committed calculated range is empty ([])

#### Worker
- Coordinates all classes listed above
- Coordinates thread usage
- `IntervalWorker` can split process in several loops
    - If a loop is finished the preliminary result is transmitted
    - Next loop is started automatically
    - Will continue until process is finished
- `IntervalWorker` default dependencies: `IntervalRandomGenerator`, `MemoryStorageAnalyzer`, `Sorter`, `Mapper` 

### Tests
- Project code coverage `94.3%`
- Unit Tests: `63`
- Integration Tests: `1` (IntervalWorker)
- Performance Tests: `2` (checks which algorithm / process is the fastest)
- UI Tests: `2`
