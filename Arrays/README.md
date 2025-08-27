# Arrays in Csharp

- Array is a **fixed-size**, **ordered collection** of values from the **same type**.
- You can store multiple values in a single variable.
- It always start with the first position at **0**.

<table align="center"><tr><td align="center" width="9999">
    <img src="../images/Arrays/1.png">
</td></tr></table>

## Declaration and Initialization

### Number of elements defined but all zero

- You can start an array with all elements as `0` in all positions.
- Define the type inside the array and the number os positions.

```csharp

int[] numbers = new int[5];
// Start an integer values with 5 positions.
// Visual: | 0 | 0 | 0 | 0 | 0 |

```

### Defined numbers to each position

- You can start with the values needed to the positions.
- You can do in short and long options

```csharp

// Long version
int[] numbers = new int[] { 1, 2, 3, 4, 5 };

// Short version
int[] numbers = { 1, 2, 3, 4, 5 };

```

## Accessing Array values

- We can get the information from one array knowing the position.
- The value inside the position is going to be accessed.

```csharp

int[] numbers = { 1, 2, 3, 4, 5};

int value = numbers[0]; // value = 1
int value = numbers[1]; // value = 2
int value = numbers[2]; // value = 3
int value = numbers[3]; // value = 4
int value = numbers[4]; // value = 5

```

## Iterating over Arrays

- If you don't need one specific value from the array.
- You can check all values inside or print the information.

### For Loop

The most basic way is using the for loop when you have to specify the positions.

This option is good when you need to verify a part or the entire array.

You can work with Matrix using the for loop with arrays.

```csharp

for (int i = 0 ; i < numbers.Length; i++) {
    Console.WriteLine($"numbers[{i}] = {numbers[i]}");
}

```

### Foreach Loop

This loop is to get all values from an array.

You can't control the positions or informations.

```csharp

foreach (int number in numbers) {
    Console.WriteLine($"Number: {number}");
}

```

### LINQ

We can use LINQ to show information from an Array:

```csharp

int[] numbers = { 1, 2, 3, 4, 5, 6};

Console.WriteLine($"\nReading array using LINQ: {string.Join(" | ", numbers)}");


```

## Array Properties and Methods

- In C# you can use a defined methods in your arrays.

```csharp

Array.Sort(numbers); // Sort the array
Array.Reverse(numbers); // Reverse the array

```

## Multidimensional Arrays - Matrix

C# supports multidimensional arrays, like 2D arrays:

```csharp

int[,] matrix = {
    {1, 2, 3},
    {4, 5, 6}
};

Console.WriteLine(matrix[1, 2]); // Outputs: 6


```

## Jagged Arrays

Jagged arrays are arrays where each element is itself an array

```csharp

int[][] jaggedArray = new int[2][];
jaggedArray[0] = new int[] { 1, 2 }; // The array on the first position
jaggedArray[1] = new int[] { 3, 4, 5 }; // The array on the second position

Console.WriteLine(jaggedArray[1][2]); // Outputs: 5

```

