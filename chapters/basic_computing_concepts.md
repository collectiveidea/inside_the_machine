# Basic Computing Concepts
\label{cha:basic_computing_concepts}

Modern computers come in all shapes and sizes, and they aid us in a million different types of tasks ranging from the serious, like air traffic control and cancer research, to the not-so-serious, like computer gaming and photograph retouching. But as diverse as computers are in their outward forms and in the uses to which they’re put, they’re all amazingly similar in basic function. All of them rely on a limited repertoire of technologies that enable them do the myriad kinds of miracles we’ve come to expect from them.

At the heart of the modern computer is the _microprocessor_--also commonly called the _central processing unit (CPU)_--a tiny, square sliver of silicon that’s etched with a microscopic network of gates and channels through which electricity flows. This network of gates (_transistors_) and channels (_wires_ or _lines_) is a very small version of the kind of circuitry that we’ve all seen when cracking open a television remote or an old radio. In short, the microprocessor isn’t just the “heart” of a modern computer--it’s a computer in and of itself. Once you understand how this tiny computer works, you’ll have a thorough grasp of the fundamental concepts that underlie all of modern computing, from the aforementioned air traffic control system to the silicon brain that controls the brakes on a luxury car.

This chapter will introduce you to the microprocessor, and you’ll begin to get a feel for just how straightforward computers really are. You need master only a few fundamental concepts before you explore the micro- processor technologies detailed in the later chapters of this book.

To that end, this chapter builds the general conceptual framework on which I’ll hang the technical details covered in the rest of the book. Both newcomers to the study of computer architecture and more advanced readers are encouraged to read this chapter all the way through, because its abstractions and generalizations furnish the large conceptual “boxes” in which I’ll later place the specifics of particular architectures.

## The Calculator Model of Computing
\label{sec:calculator_model}

Figure~\ref{fig:1-1} is an abstract graphical representation of what a computer does. In a nutshell, a computer takes a stream of instructions (code) and a stream of data as input, and it produces a stream of results as output. For the purposes of our initial discussion, we can generalize by saying that the _code stream_ consists of different types of arithmetic operations and the _data stream_ consists of the data on which those operations operate. The _results stream_, then, is made up of the results of these operations. You could also say that the results stream begins to flow when the operators in the code stream are carried out on the operands in the data stream.

![A simple representation of a general-purpose computer.\label{fig:1-1}](images/figure_1-1.png)

\begin{aside}
\label{aside:note_1-1}

\noindent Figure~\ref{fig:1-1} is my own variation on the traditional way of representing a processor’s arithmetic logic unit (ALU), which is the part of the processor that does the addition, subtraction, and so on, of numbers. However, instead of showing two operands entering the top ports and a result exiting the bottom port (as is the custom in the literature), I’ve depicted code and data streams entering the top ports and a results stream leaving the bottom port.

\end{aside}

To illustrate this point, imagine that one of those little black boxes in the code stream of Figure~\ref{fig:1-1} is an addition operator (a + sign) and that two of the white data boxes contain two integers to be added together, as shown in Figure~\ref{fig:1-2}.

![Instructions are combined with data to produce results.\label{fig:1-2}](images/figure_1-2.png)

You might think of these black-and-white boxes as the keys on a calculator—with the white keys being numbers and the black keys being operators—the gray boxes are the results that appear on the calculator’s screen. Thus the two input streams (the code stream and the data stream) represent sequences of key presses (arithmetic operator keys and number keys), while the output stream represents the resulting sequence of numbers displayed on the calculator’s screen.

The kind of simple calculation described above represents the sort of thing that we intuitively think computers do: like a pocket calculator, the computer takes numbers and arithmetic operators (such as +, –, ÷, ×, etc.) as input, performs the requested operation, and then displays the results. These results might be in the form of pixel values that make up a rendered scene in a computer game, or they might be dollar values in a financial spreadsheet.

## The File-Clerk Model of Computing

The “calculator” model of computing, while useful in many respects, isn’t the only or even the best way to think about what computers do. As an alternative, consider the following definition of a computer:

\begin{quote} A _computer_ is a device that shuffles numbers around from place to place, reading, writing, erasing, and rewriting different numbers in different locations according to a set of inputs, a fixed set of rules for processing those inputs, and the prior history of all the inputs that the computer has seen since it was last reset, until a predefined set of criteria are met that cause the computer to halt. \end{quote}

We might, after Richard Feynman, call this idea of a computer as a reader, writer, and modifier of numbers the “file-clerk” model of computing (as opposed to the aforementioned calculator model). In the file-clerk model, the computer accesses a large (theoretically infinite) store of sequentially arranged numbers for the purpose of altering that store to achieve a desired result. Once this desired result is achieved, the computer halts so that the now-modified store of numbers can be read and interpreted by humans.

The file-clerk model of computing might not initially strike you as all that useful, but as this chapter progresses, you’ll begin to understand how important it is. This way of looking at computers is powerful because it emphasizes the end product of computation rather than the computation itself. After all, the purpose of computers isn’t just to compute in the abstract, but to produce usable results from a given data set.

\begin{aside}
\label{aside:note_1-2}

\noindent Those who’ve studied computer science will recognize in the preceding description the beginnings of a discussion of a Turing machine. The Turing machine is, however, too abstract for our purposes here, so I won’t actually describe one. The description that I develop here sticks closer to the classic Reduced Instruction Set Computing (RISC) load-store model, where the computer is “fixed” along with the storage. The Turing model of a computer as a movable read-write head (with a state table) traversing a linear “tape” is too far from real-life hardware organization to be anything but confusing in this discussion.

\end{aside}

In other words, what matters in computing is not that you did some math, but that you started with a body of numbers, applied a sequence of operations to it, and got a body of results. Those results could, again, represent pixel values for a rendered scene or an environmental snapshot in a weather simulation. Indeed, the idea that a computer is a device that transforms one set of numbers into another should be intuitively obvious to anyone who has ever used a Photoshop filter. Once we understand computers not in terms of the math they do, but in terms of the numbers they move and modify, we can begin to get a fuller picture of how they operate.

In a nutshell, a computer is a device that reads, modifies, and writes sequences of numbers. These three functions--read, modify, and write--are the three most fundamental functions that a computer performs, and all of the machine’s components are designed to aid in carrying them out. This read-modify-write sequence is actually inherent in the three central bullet points of our initial file-clerk definition of a computer. Here is the sequence mapped explicitly onto the file-clerk definition:

\begin{quote} A computer is a device that shuffles numbers around from place to place, reading, writing, erasing, and rewriting different numbers in different locations according to a set of inputs [_read_], a fixed set of rules for processing those inputs [_modify_], and the prior history of all the inputs that the computer has seen since it was last reset [_write_], until a predefined set of criteria are met that cause the computer to halt. \end{quote}

That sums up what a computer does. And, in fact, that’s all a computer does. Whether you’re playing a game or listening to music, everything that’s going on under the computer’s hood fits into this model.

\begin{aside}
\label{aside:note_1-2}

\noindent All of this is fairly simple so far, and I’ve even been a bit repetitive with the explanations to drive home the basic read-modify-write structure of all computer operations. It’s important to grasp this structure in its simplicity, because as we increase our computing model’s level of complexity, we’ll see this structure repeated at every level.

\end{aside}

### The Stored-Program Computer
All computers consist of at least three fundamental types of structures needed
to carry out the read-modify-write sequence:

* Storage
    To say that a computer “reads” and “writes” numbers implies that there is at least one number-holding structure that it reads from and writes to. All computers have a place to put numbers--a storage area that can be read from and written to.

* Arithmetic logic unit (ALU)
    Similarly, to say that a computer “modifies” numbers implies that the computer contains a device for performing operations on numbers. This device is the ALU, and it’s the part of the computer that performs arithmetic operations (addition, subtraction, and so on), on numbers from the storage area. First, numbers are read from storage into the ALU’s data input port. Once inside the ALU, they’re modified by means of an arithmetic calculation, and then they’re written back to storage via the ALU’s output port.

    The ALU is actually the green, three-port device at the center of Figure 1-1. Note that ALUs aren’t normally understood as having a code input port along with their data input port and results output port. They do, of course, have command input lines that let the computer specify which operation the ALU is to carry out on the data arriving at its data input port, so while the depiction of a code input port on the ALU in Figure 1-1 is unique, it is not misleading.

* Bus
  In order to move numbers between the ALU and storage, some means of transmitting numbers is required. Thus, the ALU reads from and writes to the data storage area by means of the _data bus_, which is a network of transmission lines for shuttling numbers around inside the computer. Instructions travel into the ALU via the _instruction bus_, but we won’t cover how instructions arrive at the ALU until Chapter 2. For now, the data bus is the only bus that concerns us.

The code stream in Figure~\ref{fig:1-1} flows into the ALU in the form of a sequence of arithmetic instructions (add, subtract, multiply, and so on). The operands for these instructions make up the data stream, which flows over the data bus from the storage area into the ALU. As the ALU carries out operations on the incoming operands, the results stream flows out of the ALU and back into the storage area via the data bus. This process continues until the code stream stops coming into the ALU. Figure~\ref{fig:1-3} expands on Figure~\ref{fig:1-1} and shows the storage area.

The data enters the ALU from a special storage area, but where does the code stream come from? One might imagine that it comes from the keypad of some person standing at the computer and entering a sequence of instructions, each of which is then transmitted to the code input port of the ALU, or perhaps that the code stream is a prerecorded list of instructions that is fed into the ALU, one instruction at a time, by some manual or automated mechanism. Figure Figure~\ref{fig:1-3} depicts the code stream as a prerecorded list of instructions that is stored in a special storage area just like the data stream, and modern computers do store the code stream in just such a manner.

![A simple computer, with an ALU and a region for storing instructions and data.\label{fig:1-3}](images/figure_1-3.png)

\begin{aside}
\label{aside:note_1-3}

\noindent More advanced readers might notice that in Figure~\ref{fig:1-3} (and in Figure~\ref{fig:1-4} later) I’ve separated the code and data in main memory after the manner of a Harvard architecture level-one cache. In reality, blocks of code and data are mixed together in main memory, but for now I’ve chosen to illustrate them as logically separated.

\end{aside}

The modern computer’s ability to store and reuse prerecorded sequences of commands makes it fundamentally different from the simpler calculating machines that preceded it. Prior to the invention of the first _stored-program computer_,:[^stored_program_footnote] all computing devices, from the abacus to the earliest electronic computing machines, had to be manipulated by an operator or group of operators who manually entered a particular sequence of commands each time they wanted to make a particular calculation. In contrast, modern computers store and reuse such command sequences, and as such they have a level of flexibility and usefulness that sets them apart from everything that has come before. In the rest of this chapter, you’ll get a first-hand look at the many ways that the stored-program concept affects the design and capabilities of the modern computer.

### Refining the File-Clerk Model
Let’s take a closer look at the relationship between the code, data, and results streams by means of a quick example. In this example, the code stream consists of a single instruction, an add, which tells the ALU to add two numbers together.

The add instruction travels from code storage to the ALU. For now, let’s not concern ourselves with how the instruction gets from code storage to the ALU; let’s just assume that it shows up at the ALU’s code input port announcing that there is an addition to be carried out immediately. The ALU goes through the following sequence of steps:

1. Obtain the two numbers to be added (the input operands) from data storage.
2. Add the numbers.
3. Place the results back into data storage.

The preceding example probably sounds simple, but it conveys the basic
manner in which computers--_all_ computers--operate. Computers are fed
a sequence of instructions one by one, and in order to execute them, the computer must first obtain the necessary data, then perform the calculation specified by the instruction, and finally write the result into a place where the end user can find it. Those three steps are carried out billions of times per second on a modern CPU, again and again and again. It’s only because the computer executes these steps so rapidly that it’s able to present the illusion that something much more conceptually complex is going on.

To return to our file-clerk analogy, a computer is like a file clerk who sits at his desk all day waiting for messages from his boss. Eventually, the boss sends him a message telling him to perform a calculation on a pair of numbers. The message tells him which calculation to perform, and where in his personal filing cabinet the necessary numbers are located. So the clerk first retrieves the numbers from his filing cabinet, then performs the calculation, and finally places the results back into the filing cabinet. It’s a boring, mindless task that’s repeated endlessly, day in and day out, which is precisely why we’ve invented a machine that can do it efficiently and not complain.

## The Register File

Since numbers must first be fetched from storage before they can be added, we want our data storage space to be as fast as possible so that the operation can be carried out quickly. Since the ALU is the part of the processor that does the actual addition, we’d like to place the data storage as close as possible to the ALU so it can read the operands almost instantaneously. However, practical considerations, such as a CPU’s limited surface area, constrain the size of the storage area that we can stick next to the ALU. This means that in real life, most computers have a relatively small number of very fast data storage locations attached to the ALU. These storage locations are called _registers_, and the first x86 computers only had eight of them to work with. These registers, which are arrayed in a storage structure called a _register file_, store only a small subset of the data that the code stream needs (and we’ll talk about where the rest of that data lives shortly).

Building on our previous, three-step description of what goes on when a computer’s ALU is commanded to add two numbers, we can modify it as follows. To execute an `add` instruction, the ALU must perform these steps:

1. Obtain the two numbers to be added (the _input operands_) from two _source registers_.
2. Add the numbers.
3. Place the results back in a _destination register_.

For a concrete example, let’s look at addition on a simple computer
with only four registers, named `A`, `B`, `C`, and `D`. Suppose each of these registers contains a number, and we want to add the contents of two registers together and overwrite the contents of a third register with the resulting sum, as in the following operation:

```ruby
A + B = C # Add the contents of registers A and B, and place the result in C,
          # overwriting whatever was there.
```
Upon receiving an instruction commanding it to perform this addition operation, the ALU in our simple computer would carry out the following three familiar steps:
1. Read the contents of registers `A` and `B`.
2. Add the contents of `A` and `B`.
3. Write the result to register `C`.

\begin{aside}
\label{aside:note_1-4}

\noindent You should recognize these three steps as a more specific form of the read-modify-write sequence from earlier, where the generic modify step is replaced with an addition operation.

\end{aside}

This three-step sequence is quite simple, but it’s at the very core of how a microprocessor really works. In fact, if you glance ahead to Chapter~\ref{cha:arm_3}'s discussion of the TKTK's pipeline, you’ll see that it actually has separate stages for each of these three operations: stage TK is the register read step, stage TK is the actual execute step, and stage TK is the write-back step. (Don’t worry if you don’t know what a _pipeline_ is, because that’s a topic for Chapter~\ref{cha:pipelined_execution}.) So the TKTK's ALU reads two operands from the register file, adds them together, and writes the sum back to the register file. If we were to stop our discussion right here, you’d already understand the three core stages of the TKTK's main integer pipeline--all the other stages are either just preparation to get to this point or they’re cleanup work after it.

## RAM: When the Registers Alone Don’t Cut It
Obviously, four (or even eight) registers aren’t even close to the theoretically infinite storage space I mentioned earlier in this chapter. In order to make a viable computer that does useful work, you need to be able to store very large
data sets. This is where the computer’s _main memory_ comes in. Main memory, which in modern computers is always some type of _random access memory_ (RAM), stores the data set on which the computer operates, and only a small portion of that data set at a time is moved to the registers for easy access from the ALU (as shown in Figure~\ref{fig:1-4}).

![A computer with a register file\label{fig:1-4}](images/figure_1-4.png)

Figure~\ref{fig:1-4} gives only the slightest indication of it, but main memory is situated quite a bit farther away from the ALU than are the registers. In fact, the ALU and the registers are internal parts of the microprocessor, but main memory is a completely separate component of the computer system that is connected to the processor via the _memory bus_. Transferring data between main memory and the registers via the memory bus takes a significant amount of time. Thus, if there were no registers and the ALU had to read data directly from main memory for each calculation, computers would run very slowly. However, because the registers enable the computer to store data near the ALU, where it can be accessed nearly instantaneously, the computer’s computational speed is decoupled somewhat from the speed of main memory. (We’ll discuss the problem of memory access speeds and computational performance in more detail in Chapter~\ref{cha:understanding_caching_and_performance}, when we talk about caches.)

### The File-Clerk Model Revisited and Expanded
To return to our file-clerk metaphor, we can think of main memory as a document storage room located on another floor and the registers as a small, personal filing cabinet where the file clerk places the papers on which he’s currently working. The clerk doesn’t really know anything about the document storage room—what it is or where it’s located—because his desk and his personal filing cabinet are all he concerns himself with. For documents that are in the storage room, there’s another office worker, the office secretary, whose job it is to locate files in the storage room and retrieve them for the clerk.

This secretary represents a few different units within the processor, all of which we’ll meet Chapter~\ref{cha:superscalar_execution}. For now, suffice it to say that when the boss wants the clerk to work on a file that’s not in the clerk’s personal filing cabinet, the secretary must first be ordered, via a message from the boss, to retrieve the file from the storage room and place it in the clerk’s cabinet so that the clerk can access it when he gets the order to begin working on it.

### An Example: Adding Two Numbers
To translate this office example into computing terms, let’s look at how the computer uses main memory, the register file, and the ALU to add two numbers.
To add two numbers stored in main memory, the computer must perform these steps:

1. Load the two operands from main memory into the two source registers.
2. Add the contents of the source registers and place the results in the destination register, using the ALU. To do so, the ALU must perform these steps:
  * Read the contents of registers A and B into the ALU’s input ports.
  * Add the contents of A and B in the ALU.
  * Write the result to register C via the ALU’s output port.
3. Store the contents of the destination register in main memory.

Since steps 2a, 2b, and 2c all take a trivial amount of time to complete,
relative to steps 1 and 3, we can ignore them. Hence our addition looks like this:

1. Load the two operands from main memory into the two source registers.
2. Add the contents of the source registers, and place the results in the des- tination register, using the ALU.
3. Store the contents of the destination register in main memory.

The existence of main memory means that the user—the boss in our
filing-clerk analogy—must manage the flow of information between main memory and the CPU’s registers. This means that the user must issue instructions to more than just the processor’s ALU; he or she must also issue instructions to the parts of the CPU that handle memory traffic. Thus, the preceding three steps are representative of the kinds of instruc- tions you find when you take a close look at the code stream.

## A Closer Look at the Code Stream: the Program
At the beginning of this chapter, I defined the code stream as consisting of “an ordered sequence of operations,” and this definition is fine as far as it goes. But in order to dig deeper, we need a more detailed picture of what the code stream is and how it works.

The term _operations_ suggests a series of simple arithmetic operations like addition or subtraction, but the code stream consists of more than just arithmetic operations. Therefore, it would be better to say that the code stream consists of an ordered sequence of _instructions_. Instructions, generally speaking, are commands that tell the whole computer—not just the ALU, but multiple parts of the machine—exactly what actions to perform. As we’ve seen, a computer’s list of potential actions encompasses more than just simple arithmetic operations.

### General Instruction Types
Instructions are grouped into ordered lists that, when taken as a whole,
tell the different parts of the computer how to work together to perform a specific task, like grayscaling an image or playing a media file. These ordered lists of instructions are called _programs_, and they consist of a few basic types of instructions.

In modern RISC microprocessors, the act of moving data between memory and the registers is under the explicit control of the code stream, or program. So if a programmer wants to add two numbers that are located in main memory and then store the result back in main memory, he or she must write a list of instructions (a program) to tell the computer exactly what to do. The program must consist of

􏰀* a load instruction to move the two numbers from memory into the registers
􏰀* an add instruction to tell the ALU to add the two numbers
􏰀* a store instruction to tell the computer to place the result of the addition
back into memory, overwriting whatever was previously there.

These operations fall into two main categories:
#### Arithmetic instructions
  These instructions tell the ALU to perform an arithmetic calculation (for example, `add`, `sub`, `mul`, `div`).
#### Memory-access instructions
  These instructions tell the parts of the processor that deal with main memory to move data from and to main memory (for example, load and store).

\begin{aside}
\label{aside:note_1-5}

\noindent We’ll discuss a third type of instruction, the branch instruction, shortly. Branch instructions are technically a special type of memory-access instruction, but they access code storage instead of data storage. Still, it’s easier to treat branches as a third category of instruction.

\end{aside}

The _arithmetic instruction_ fits with our calculator metaphor and is the type of instruction most familiar to anyone who’s worked with computers. Instructions like integer and floating-point addition, subtraction, multipli- cation, and division all fall under this general category.

\begin{aside}
\label{aside:note_1-6}

\noindent In order to simplify the discussion and reduce the number of terms, I’m temporarily including logical operations like AND, OR, NOT, NOR, and so on, under the general heading of arithmetic instructions. The difference between arithmetic and logical operations will be introduced in Chapter~\ref{cha:the_mechanics_of_program_execution}.

\end{aside}

The _memory-access instruction_ is just as important as the arithmetic instruction, because without access to main memory’s data storage regions, the computer would have no way to get data into or out of the register file.

To show you how memory-access and arithmetic operations work together within the context of the code stream, the remainder of this chapter will use a series of increasingly detailed examples. All of the examples are based on a simple, hypothetical computer, which I’ll call the DLW-1.:[^dlw_footnote]

### The DLW-1’s Basic Architecture and Instruction Formats
The DLW-1 microprocessor consists of an ALU (along with a few other units that I’ll describe later) attached to four registers, named `A`, `B`, `C`, and `D` for convenience. The DLW-1 is attached to a bank of main memory that’s laid out as a line of 256 memory cells, numbered #0 to #255. (The number that identifies an individual memory cell is called an _address_.)

#### The DLW-1’s Arithmetic Instruction Format
All of the DLW-1’s arithmetic instructions are in the following instruction format:

```
instruction source1, source2, destination
```

There are four parts to this instruction format, each of which is called a _field_. The _instruction_ field specifies the type of operation being performed (for example, an addition, a subtraction, a multiplication, and so on). The two _source_ fields tell the computer which registers hold the two numbers being operated on, or the operands. Finally, the _destination_ field tells the computer which register to place the result in.

As a quick illustration, an addition instruction that adds the numbers in registers `A` and `B` (the two source registers) and places the result in register `C` (the destination register) would look like this:

```
add A, B, C # Add the contents of registers A and B and place the result in C, overwriting whatever was previously there.
```

#### The DLW-1’s Memory Instruction Format
In order to get the processor to move two operands from main memory into the source registers so they can be added, you need to tell the processor explicitly that you want to move the data in two specific memory cells to two specific registers. This “filing” operation is done via a memory-access instruction called the `load`.

As its name suggests, the `load` instruction loads the appropriate data from main memory into the appropriate registers so that the data will be available for subsequent arithmetic instructions. The `store` instruction is the reverse of the load instruction, and it takes data from a register and stores it in a location in main memory, overwriting whatever was there previously.

All of the memory-access instructions for the DLW-1 have the following instruction format:

```
instruction source, destination
```

For all memory accesses, the instruction field specifies the type of memory operation to be performed (either a `load` or a `store`). In the case of a `load`, the source field tells the computer which memory address to fetch the data from, while the destination field specifies which register to put it in. Conversely, in the case of a `store`, the source field tells the computer which register to take the data from, and the destination field specifies which memory address to write the data to.

#### An Example DLW-1 Program
Now consider Listing~\ref{code:program-1-1}, which is a piece of DLW-1 code. Each of the lines in the program must be executed in sequence to achieve the desired result.

\begin{codelisting}
\label{code:program-1-1}
\codecaption{Program to add two numbers from main memory}
```
load #12, A       //Read the contents of memory cell #12 into register A.
load #13, B       //Read the contents of memory cell #13 into register B.
add A, B, C       //Add the numbers in registers A and B and store the result in C.
store C, #14      //Write the result of the addition from register C into memory cell #14.
```
\end{codelisting}

Suppose the main memory looked like the following before running Listing~\ref{code:program-1-1}:

| #11 | #12 | #13 | #14 |
|-----|-----|-----|-----|
|  12 |  6  |  2  |  3  |

After doing our addition and storing the results, the memory would be changed so that the contents of cell #14 would be overwritten by the sum of cells #12 and #13, as shown here:

| #11 | #12 | #13 | #14 |
|-----|-----|-----|-----|
|  12 |  6  |  2  |  8  |


## A Closer Look at Memory Accesses: Register vs. Immediate

The examples so far presume that the programmer knows the exact memory location of every number that he or she wants to load and store. In other words, it presumes that in composing each program, the programmer has at his or her disposal a list of the contents of memory cells #0 through #255.

While such an accurate snapshot of the initial state of main memory may be feasible for a small example computer with only 256 memory locations, such snapshots almost never exist in the real world. Real computers have billions of possible locations in which data can be stored, so programmers need a more flexible way to access memory, a way that doesn’t require each memory access to specify numerically an exact memory address.

Modern computers allow the _contents_ of a register to be used as a memory address, a move that provides the programmer with the desired flexibility. But before discussing the effects of this move in more detail, let’s take one more look at the basic add instruction.

### Immediate Values
All of the arithmetic instructions so far have required two source registers as input. However, it’s possible to replace one or both of the source registers with an explicit numerical value, called an _immediate value_. For instance, to increase whatever number is in register A by 2, we don’t need to load the value 2 into a second source register, like B, from some cell in main memory that contains that value. Rather, we can just tell the computer to add 2 to A directly, as follows:

```
add A, 2, A  //Add 2 to the contents of register A and place the result back into A, overwriting whatever was there.
```

I’ve actually been using immediate values all along in my examples, but just not in any arithmetic instructions. In all of the preceding examples, each load and store uses an immediate value in order to specify a memory address. So the #12 in the load instruction in line 1 of Listing~\ref{code:program-1-1} is just an immediate value (a regular whole number) prefixed by a # sign to let the computer know that this particular immediate value is a memory address that designates a cell in memory.

Memory addresses are just regular whole numbers that are specially marked with the # sign. Because they’re regular whole numbers, they can be stored in registers—and stored in memory—just like any other number. Thus, the whole-number contents of a register, like `D`, could be construed by the computer as representing a memory address.

For example, say that we’ve stored the number 12 in register `D`, and that we intend to use the contents of `D` as the address of a memory cell in Listing~\ref{code:program-1-2}.

\begin{codelisting}
\label{code:program-1-2}
\codecaption{Program to add two numbers from main memory using an address stored in a register}
```
load #D, A   //Read the contents of the memory cell designated by the number stored in D (where D = 12) into register A.
load #13, B  //Read the contents of memory cell #13 into register B.
add A, B, C  //Add the numbers in registers A and B and store the result in C.
store C, #14 //Write the result of the addition from register C into memory cell #14.
```
\end{codelisting}

Program 1-2 is essentially the same as Program 1-1, and given the same input, it yields the same results. The only difference is in line 1.

Listing~\ref{code:program-1-1}, Line 1
`load #12, A`

Listing~\ref{code:program-1-2}, Line 1
`load #D, A`

Since the content of `D` is the number 12, we can tell the computer to look in `D` for the memory cell address by substituting the register name (this time marked with a # sign for use as an address), for the actual memory cell number in line 1’s `load` instruction. Thus, the first lines of Listing~\ref{code:program-1-1} and Listing~\ref{code:program-1-2} are functionally equivalent.

This same trick works for store instructions, as well. For example, if we place the number 14 in `D` we can modify the store command in line 4 of Listing~\ref{code:program-1-1} to read as follows: `store C, #D`. Again, this modification would not change the program’s output.

Because memory addresses are just regular numbers, they can be stored in memory cells as well as in registers. Listing~\ref{code:program-1-3} illustrates the use of a memory address that’s stored in another memory cell. If we take the input for Listing~\ref{code:program-1-1} and apply it to Listing~\ref{code:program-1-3}, we get the same output as if we’d just run Listing~\ref{code:program-1-1} without modification:

\begin{codelisting}
\label{code:program-1-3}
\codecaption{Program to add two numbers from memory using an address stored in a memory cell.}
```
load #11, D  //Read the contents of memory cell #11 into D.
load #D, A   //Read the contents of the memory cell designated by the number in D (where D = 12) into register A.
load #13, B  //Read the contents of memory cell #13 into register B.
add A, B, C  //Add the numbers in registers A and B and store the result in C.
store C, #14 //Write the result of the addition from register C into memory cell #14.
```
\end{codelisting}

The first instruction in Listing~\ref{code:program-1-3} loads the number 12 from memory cell #11 into register `D`. The second instruction then uses the content of `D` (which is the value 12) as a memory address in order to load register `A` into memory location #12.

But why go to the trouble of storing memory addresses in memory cells and then loading the addresses from main memory into the registers before they’re finally ready to be used to access memory again? Isn’t this an overly complicated way to do things?

Actually, these capabilities are designed to make programmers’ lives easier, because when used with the register-relative addressing technique described next they make managing code and data traffic between the processor and massive amounts of main memory much less complex.

### Register-Relative Addressing
In real-world programs, loads and stores most often use _register-relative_ addressing, which is a way of specifying memory addresses relative to a register that contains a fixed _base address_.

For example, we’ve been using `D` to store memory addresses, so let’s say that on the DLW-1 we can assume that, unless it is explicitly told to do otherwise, the operating system always loads the starting address (or base address) of a program’s _data segment_ into `D`. Remember that code and data are logically separated in main memory, and that data flows into the processor from a data storage area, while code flows into the processor from a special code storage area. Main memory itself is just one long row of undifferentiated memory cells, each one _byte_ in width, that store numbers. The computer carves up this long row of bytes into multiple segments, some of which store code and some of which store data.

A _data segment_ is a block of contiguous memory cells that a program stores all of its data in, so if a programmer knows a data segment’s starting address (_base address_) in memory, he or she can access all of the other memory locations in that segment using this formula:
```
base address + offset
```
where offset is the distance in bytes of the desired memory location from the data segment’s base address.

Thus, `load` and `store` instructions in DLW-1 assembly would normally look something like this:

```
load #(D + 108), A   //Read the contents of the memory cell at location #(D + 108) into A.
store B, #(D + 108)  //Write the contents of B into the memory cell at location #(D + 108).
```

In the case of the load, the processor takes the number in D, which is the base address of the data segment, adds 108 to it, and uses the result as the load’s destination memory address. The store works in the exact same way.

Of course, this technique requires that a quick addition operation (called an _address calculation_) be part of the execution of the load instruction, so this is why the _load-store units_ on modern processors contain very fast integer addition hardware. (As we’ll learn in Chapter 4, the load-store unit is the _execution unit_ responsible for executing `load` and `store` instructions, just like the _arithmetic-logic unit_ is responsible for executing arithmetic instructions.)

By using register-relative addressing instead of _absolute addressing_ (in which memory addresses are given as immediate values), a programmer can write programs without knowing the exact location of data in memory. All the programmer needs to know is which register the operating system will place the data segment’s base address in, and he or she can do all memory accesses relative to that base address. In situations where a programmer uses absolute addressing, when the operating system loads the program into memory, all of the program’s immediate address values have to be changed to reflect the data segment’s actual location in memory.

Because both memory addresses and regular integer numbers are stored in the same registers, these registers are called _general-purpose registers_ (GPRs). On the DLW-1, A, B, C, and D are all GPRs.

[^stored_program_footnote]: In 1944 J. Presper Eckert, John Mauchly, and John von Neumann proposed the first stored-program computer, the EDVAC (Electronic Discreet Variable Automatic Computer), and in 1949 such a machine, the EDSAC, was built by Maurice Wilkes of Cambridge University.

[^dlw_footnote]: “DLW” in honor of the DLX architecture used by Hennessy and Patterson in their books on computer architecture.
