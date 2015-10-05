# The Mechanics of Program Execution
\label{cha:the_mechanics_of_program_execution}

Now that we understand the basics of computer organization, it’s time to take a
closer look at the nuts and bolts of how stored programs are actually executed by the computer.

To that end, this chapter will cover core programming concepts like machine language, the programming model, the instruction set architecture, branch instructions, and the fetch-execute loop.

## Opcodes and Machine Language
If you’ve been following the discussion so far, it shouldn’t surprise you to learn that both memory addresses and instructions are ordinary numbers that can be stored in memory. All of the instructions in a program like Program 1-1 are represented inside the computer as strings of numbers. Indeed, a program is one long string of numbers stored in a series of memory locations.
￼
How is a program like Program 1-1 rendered in numerical notation so that it can be stored in memory and executed by the computer? The answer is simpler than you might think.

As you may already know, a computer actually only understands 1s and 0s (or “high” and “low” electric voltages), not English words like _add_, _load_, and _store_, or letters and base-10 numbers like A, B, 12, and 13. In order for the computer to run a program, therefore, all of its instructions must be rendered in _binary notation_. Think of translating English words into Morse code’s dots and dashes and you’ll have some idea of what I’m talking about.

### Machine Language on the DLW-1

The translation of programs of any complexity into this binary-based _machine language_ is a massive undertaking that’s meant to be done by a computer, but I’ll show you the basics of how it works so you can understand what’s going on. The following example is simplified, but useful nonetheless.

The English words in a program, like _add_, _load_, and _store_, are _mnemonics_ (meaning they’re easy for people to remember), and they’re all mapped to strings of binary numbers, called _opcodes_, that the computer can understand. Each opcode designates a different operation that the processor can perform. Table 2-1 maps each of the mnemonics used in Chapter 1 to a 3-bit opcode for the hypothetical DLW-1 microprocessor. We can also map the four register names to 2-bit binary codes, as shown in Table 2-2.

| Mnemonic | Opcode |
|----------|--------|
|   `add`    |  `000`   |
|   `sub`    |  `001`   |
|   `load`   |  `010`   |
|   `store`  |  `011`   |

Table 2-1: Mapping of Mnemonics to Opcodes for the DLW-1


| Register | Binary Code |
|----------|-------------|
|   `A`    |  `00`   |
|   `B`    |  `01`   |
|   `C`    |  `10`   |
|   `D`    |  `11`   |

Table 2-2: Mapping of Registers to Binary Codes for the DLW-1

The binary values representing both the opcodes and the register codes are arranged in one of a number of 16-bit (or 2-byte) formats to get a complete _machine language instruction_, which is a binary number that can be stored in RAM and used by the processor.

\begin{aside}
\label{aside:note_2-1}

\noindent Because programmer-written instructions must be translated into binary codes before a computer can read them, it is common to see programs in any format—binary, assembly, or a high-level language like BASIC or C, referred to generically as “code” or “codes.” So programmers sometimes speak of “assembler code,” “binary code,” or “C code,” when referring to programs written in assembly, binary, or C language. Programmers also will often describe the act of programming as “writing code” or “coding.” I have adopted this terminology in this book, and will henceforth use the term “code” regularly to refer generically to instruction sequences and programs.

\end{aside}

### Binary Encoding of Arithmetic Instructions

Arithmetic instructions have the simplest machine language instruction formats, so we’ll start with them. Figure 2-1 shows the format for the machine language encoding of a register-type arithmetic instruction.

![Machine language format for a register-type instruction\label{fig:2-1}](images/figure_2-1.png)

In a register-type arithmetic instruction (that is, an arithmetic instruc- tion that uses only registers and no immediate values), the first bit of the instruction is the _mode bit_. If the mode bit is set to 0, then the instruction is a register-type instruction; if it’s set to 1, then the instruction is of the immediate type.

Bits 1–3 of the instruction specify the opcode, which tells the computer what type of operation the instruction represents. Bits 4–5 specify the instruc- tion’s first source register, 6–7 specify the second source register, and 8–9 specify the destination register. The last six bits are not needed by register-to- register arithmetic instructions, so they’re padded with 0s (they’re _zeroed out_ in computer jargon) and ignored.

Now, let’s use the binary values in Tables 2-1 and 2-2 to translate the add instruction in line 3 of Program 1-1 into a 2-byte (or 16-bit) machine language instruction:

| Assembly Language Instruction | Machine Language Instruction |
|-------------------------------|------------------------------|
| `add A, B, C`                 | `00000001 10000000`   |
| `add C, D, A`                 | `00001011 00000000`   |
| `add D, B, C`                 | `00001101 10000000`   |
| `sub A, D, C`                 | `00010011 10000000`   |

Increasing the number of binary digits in the opcode and register fields increases the total number of instructions the machine can use and the number of registers it can have. For example, if you know something about binary notation, then you probably know that a 3-bit opcode allows the processor to map up to 2^3 mnemonics, which means that it can have up to 2^3, or 8, instructions in its _instruction set_; increasing the opcode size to 8 bits would allow the processor’s instruction set to contain up to 2^8, or 256, instructions. Similarly, increasing the number of bits in the register field increases the possible number of registers that the machine can have.

Arithmetic instructions containing an immediate value use an immediate- type instruction format, which is slightly different from the register-type format we just saw. In an immediate-type instruction, the first byte contains the opcode, the source register, and the destination register, while the second byte contains the immediate value, as shown in Figure 2-2.

![Machine language format for an immediate-type instruction\label{fig:2-2}](images/figure_2-2.png)

Here are a few immediate-type arithmetic instructions translated from assembly language to machine language:

| Assembly Language Instruction | Machine Language Instruction |
|-------------------------------|------------------------------|
| `add C, 8, A`                 | `10001000 00001000`   |
| `add 5, A, C`                 | `10000010 00000101`   |
| `sub 25, D, C`                | `10011110 00011001`   |

### Binary Encoding of Memory Access Instructions

Memory-access instructions use both register- and immediate-type instruction formats exactly like those shown for arithmetic instructions. The only difference lies in how they use them. Let’s take the case of a load first.

#### The load Instruction
We’ve previously seen two types of `load`, the first of which was the immediate type. An immediate-type `load` (see Figure 2-3) uses the immediate-type instruction format, but because the `load`'s source is an immediate value (a memory address) and not a register, the source field is unneeded and must be zeroed out. (The source field is not ignored, though, and in a moment we’ll see what happens if it isn’t zeroed out.)

![Machine language format for an immediate-type load\label{fig:2-3}](images/figure_2-3.png)

Now let’s translate the immediate-type load in line 1 of Program 1-1 (12 is 1100 in binary notation):

| Assembly Language Instruction | Machine Language Instruction |
|-------------------------------|------------------------------|
| `load #12, A`                 | `10100000 00001100`   |

The 2-byte machine language instruction on the right is a binary representation of the assembly language instruction on the left. The first byte corresponds to an immediate-type `load` instruction that takes register `A` as its destination. The second byte is the binary representation of the number 12, which is the source address in memory that the data is to be loaded from.

The second type of `load` we’ve seen is the register type. A register-type `load` uses the register-type instruction format, but with the source2 field zeroed out and ignored, as shown in Figure 2-4.

In Figure 2-4, the source1 field specifies the register containing the memory address that the processor is to load data from, and the destination field specifies the register that the loaded data is to be placed in.

![Machine language format for a register-type load\label{fig:2-4}](images/figure_2-4.png)

For a register-relative addressed `load`, we use a version of the immediate-type instruction format, shown in Figure 2-5, with the base field specifying the register that contains the base address and the offset stored in the second byte of the instruction.

![Machine language format for a register-relative load\label{fig:2-5}](images/figure_2-5.png)

Recall from Table 2-2 that 00 is the binary number that designates register `A`. Therefore, as a result of the DLW-1’s particular machine language encoding scheme, any register but `A` could theoretically be used to store the base address for a register-relative load.

#### The store Instruction

The register-type binary format for a `store` instruction is the same as it is for a load, except that the destination field specifies a register containing a destination memory address, and the source1 field specifies the register containing the data to be stored to memory.

The immediate-type machine language format for a `store`, pictured in Figure 2-6, is also similar to the immediate-type format for a `load`, except that since the destination register is not needed (the destination is the immediate memory address) the destination field is zeroed out, while the source field specifies which register holds the data to be stored.

![Machine language format for an immediate-type store\label{fig:2-6}](images/figure_2-6.png)

The register-relative `store`, on the other hand, uses the same immediate-type instruction format used for the register-relative `load` (Figure 2-5), but the destination field is set to a nonzero value, and the offset is stored in the second byte. Again, the base address for a register-relative `store` can theoretically be stored in any register other than A, although by convention it’s stored in D.

### Translating an Example Program into Machine Language

For our simple computer with four registers, three instructions, and 256 memory cells, it’s tedious but trivial to translate Program 1-1 into machine- readable binary representation using the previous tables and instruction formats. Program 2-1 shows the translation.

| Assembly Language  | Machine Language    |
|--------------------|---------------------|
| `load #12, A`      | `10100000 00001100`   |
| `load #13, B`      | `10100001 00001101`   |
| `add A, B, C`      | `00000001 10000000`   |
| `store C, #14`     | `10111000 00001110`   |

Program 2-1: A translation of Program 1-1 into machine language

The 1s and 0s in the rightmost column of Program 2-1 represent the high and low voltages that the computer “thinks” in.

Real machine language instructions are usually longer and more complex than the simple ones I’ve given here, but the basic idea is exactly the same. Program instructions are translated into machine language in a mechanical, predefined manner, and even in the case of a fully modern microprocessor, doing such translations by hand is merely a matter of knowing the instruction formats and having access to the right charts and tables.

Of course, for the most part the only people who do such translations by hand are computer engineering or computer science undergraduates who’ve been assigned them for homework. This wasn’t always the case, though.

## The Programming Model and the ISA
Back in the bad old days, programmers had to enter programs into the computer directly in machine language (after having walked five miles in the snow uphill to work). In the very early stages of computing, this was done by flipping switches. The programmer toggled strings of 1s and 0s into the computer’s very limited memory, ran the program, and then pored over the resulting strings of 1s and 0s to decode the answer.

Once memory sizes and processing power increased to the point where programmer time and effort were valuable enough relative to computing time and memory space, computer scientists devised ways of allowing the computer to use a portion of its power and memory to take on some of the burden of making its cryptic input and output a little more human-friendly.

In short, the tedious task of converting human-readable programs into machine-readable binary code was automated; hence the birth of assembly language programming. Programs could now be written using mnemonics, register names, and memory locations, before being converted by an assembler into machine language for processing.

In order to write assembly language programs for a machine, you have to understand the machine’s available resources: how many registers it has, what instructions it supports, and so on. In other words, you need a well-defined model of the machine you’re trying to program.

### The Programming Model
The _programming model_ is the programmer’s interface to the microprocessor. It hides all of the processor’s complex implementation details behind a relatively simple, clean layer of abstraction that exposes to the programmer all of the processor’s functionality. (See Chapter 4 for more on the history and development of the programming model.)

Figure 2-7 shows a diagram of a programming model for an eight-register machine. By now, most of the parts of the diagram should be familiar to you. The ALU performs arithmetic, the registers store numbers, and the _input-output unit_ (I/O unit) is responsible for interacting with memory and the rest of the system (via loads and stores). The parts of the processor that we haven’t yet met lie in the _control unit_. Of these, we’ll cover the _program counter_ and the _instruction register_ now.

### The Instruction Register and Program Counter

Because programs are stored in memory as ordered sequences of instruc- tions and memory is arranged as a linear series of addresses, each instruction in a program lives at its own memory address. In order to step through and execute the lines of a program, the computer simply begins at the program’s starting address and then steps through each successive memory location, fetching each successive instruction from memory, placing it in a special register, and executing it as shown in Figure 2-8.

![The programming model for a simple eight-register machine\label{fig:2-7}](images/figure_2-7.png)

The instructions in our DLW-1 computer are two bytes long. If we assume that each memory cell holds one byte, then the DLW-1 must step through memory by fetching instructions from two cells at a time.

![A simple computer with instruction and data registers\label{fig:2-8}](images/figure_2-8.png)

For example, if the starting address in Program 1-1 were #500, it would look like Figure 2-9 in memory (with the instructions rendered in machine language, not assembly language, of course).

![An illustration of Program 1-1 in memory, starting at address #500\label{fig:2-9}](images/figure_2-9.png)

### The Instruction Fetch: Loading the Instruction Register

An _instruction fetch_ is a special type of load that happens automatically for every instruction. It always takes the address that’s currently in the program counter register as its source and the _instruction register_ as its destination. The control unit uses a fetch to load each instruction of a program from memory into the instruction register, where that instruction is _decoded_ before being executed; and while that instruction is being decoded, the processor places the address of the next instruction into the program counter by incrementing the address that’s currently in the program counter, so that the newly incremented address points to the next instruction the sequence. In the case of our DLW-1, the program counter is incremented by two every time an instruction is fetched, because the two-byte instructions begin at every other byte in memory.

### Running a Simple Program: the Fetch-Execute Loop
In Chapter 1 we discussed the steps a processor takes to perform calculations on numbers using the ALU in combination with a fetched arithmetic instruc- tion. Now let’s look at the steps the processor takes in order to fetch a series of instructions—a program—and feed them to either the ALU (in the case of arithmetic instructions) or the memory access hardware (in the case of loads and stores):

1. _Fetch_ the next instruction from the address stored in the program counter, and load that instruction into the instruction register. Increment the program counter.
2. _Decode_ the instruction in the instruction register.
3. _Execute_ the instruction in the instruction register, using the following
rules:
  * If the instruction is an arithmetic instruction, execute it using the ALU and register file.
  * If the instruction is a memory access instruction, execute it using the memory-access hardware.

	These three steps are fairly straightforward, and with one modification
they describe the way that microprocessors execute programs (as we’ll see in the section “Branch Instructions” on page 30). Computer scientists often	refer to these steps as the _fetch-execute loop_ or the _fetch-execute cycle_. The fetch- execute loop is repeated for as long as the computer is powered on. The machine iterates through the entire loop, from step 1 to step 3, over and over again many millions or billions of times per second in order to run programs.

Let’s run through the three steps with our example program as shown in Figure 2-9. (This example presumes that #500 is already in the program counter.) Here’s what the processor does, in order:

1. Fetch the instruction beginning at #500, and load `load #12, A` into the instruction register. Increment the program counter to #502.
2. Decode `load #12, A` in the instruction register.
3. Execute `load #12, A` from the instruction register, using the memory-
access hardware.
4. Fetch the instruction beginning at #502, and load `load #13, B` in the instruction register. Increment the program counter to #504.
5. Decode `load #13, B` in the instruction register.
6. Execute `load #13, B` from the instruction register, using the memory-
access hardware.
7. Fetch the instruction beginning at #504, and load `add A, B, C` into the instruction register. Increment the program counter to #506.
8. Decode `add A, B, C` in the instruction register.
9. Execute `add A, B, C` from the instruction register, using the ALU and
register file.
10. Fetch the instruction at #506, and load `store C, #14` in the instruction register. Increment the program counter to #508.
11. Decode `store C, #14` in the instruction register.
12. Execute `store C, #14` from the instruction register, using the memory-
access hardware.

\begin{aside}
\label{aside:note_2-2}

\noindent To zoom in on the execute steps of the preceding sequence, revisit Chapter 1, and particularly the sections“Refining the File-Clerk Model” on page 6 and “RAM: When the Registers Alone Don’t Cut It” on page 8. If you do, you’ll gain a pretty good understanding of what’s involved in executing a program on any machine. Sure, there are important machine-specific variations for most of what I’ve presented here, but the general outlines (and even a decent number of the specifics) are the same.

\end{aside}

## The Clock

Steps 1 through 12 in the previous section don’t take an arbitrary amount of time to complete. Rather, they’re performed according to the pulse of the clock that governs every action the processor takes.

This clock pulse, which is generated by a _clock generator_ module on the motherboard and is fed into the processor from the outside, times the func- tioning of the processor so that, on the DLW-1 at least, all three steps of the fetch-execute loop are completed in exactly one beat of the clock. Thus, the program in Figure 2-9, as I’ve traced its execution in the preceding section, takes exactly four clock beats to finish execution, because a new instruction is fetched on each beat of the clock.

One obvious way to speed up the execution of programs on the DLW-1 would be to speed up its clock generator so that each step takes less time to complete. This is generally true of all microprocessors, hence the race among microprocessor designers to build and market chips with ever-higher clock speeds. (We’ll talk more about the relationship between clock speed and performance in Chapter 3.)

## Branch Instructions
As I’ve presented it so far, the processor moves through each line in a pro- gram in sequence until it reaches the end of the program, at which point the program’s output is available to the user.

There are certain instructions in the instruction stream, however, that allow the processor to jump to a program line that is out of sequence. For instance, by inserting a branch instruction into line 5 of a program, we could cause the processor’s control unit to jump all the way down to line 20 and begin executing there (a forward branch), or we could cause it to jump back up to line 1 (a backward branch). Because a program is an ordered sequence of instructions, by including forward and backward branch instructions, we can arbitrarily move about in the program. This is a powerful ability, and branches are an essential part of computing.

Rather than thinking about forward or backward branches, it’s more useful for our present purposes to categorize all branches as being one of the following two types: conditional branches or unconditional branches.

### Unconditional Branch
An unconditional branch instruction consists of two parts: the branch instruction and the target address.
```
jump #target
```
For an unconditional branch, `#target` can be either an immediate value, like #12, or an address stored in a register, like `#D`.

Unconditional branches are fairly easy to execute, since all that the computer needs to do upon decoding such a branch in the instruction register is to have the control unit replace the address currently in the program counter with branch’s target address. Then the next time the processor goes to fetch the instruction at the address given by the program counter, it’ll fetch the address at the branch target instead.

### Conditional Branch
Though it has the same basic instruction format as the unconditional branch (instruction #target), the _conditional branch_ instruction is a little more complicated, because it involves jumping to the target address only if a certain condition is met.

For example, say we want to jump to a new line of the program only if the previous arithmetic instruction’s result is zero; if the result is nonzero, we want to continue executing normally. We would use a conditional branch instruction that first checks to see if the previously executed arithmetic instruction yielded a zero result, and then writes the branch target into the program counter if it did.

Because of such conditional jumps, we need a special register or set of registers in which to store information about the results of arithmetic instructions—information such as whether the previous result was zero or nonzero, positive or negative, and so on.

Different architectures handle this in different ways, but in our DLW-1, this is the function of the _processor status word_ (PSW) register. On the DLW-1, every arithmetic operation stores different types of data about its outcome in the PSW upon completion. To execute a conditional branch, the DLW-1 must first evaluate the condition on which the branch depends (e.g., “is the previous arithmetic instruction’s result zero?” in the preceding example) by checking the appropriate bit in the PSW to see if that condition is true or false. If the branch condition evaluates to true, then the control unit replaces the address in the program counter with the branch target address. If the branch condition evaluates to false, then the program counter is left as-is, and the next instruction in the normal program sequence is fetched on the next cycle.

For example, suppose we had just subtracted the number in A from the number in B, and if the result was zero (that is, if the two numbers were equal), we want to jump to the instruction at memory address #106. Program 2-2 shows what assembler code for such a conditional branch might look like.

\begin{codelisting}
\label{code:program_2-2}
\codecaption{Assembler code for a conditional branch}
```
sub A, B, C   //Subtract the number in register A from the number in register B and store the result in C.
jumpz #106    //Check the PSW, and if the result of the previous instruction was zero, jump to the instruction at address #106. If the result was nonzero, continue on to line 18.
add A, B, C  //Add the numbers in registers A and B and store the result in C.
```
\end{codelisting}

The `jumpz` instruction causes the processor to check the PSW to determine whether a certain bit is 1 (true) or 0 (false). If the bit is 1, the result of the subtraction instruction was 0 and the program counter must be loaded with the branch target address. If the bit is 0, the program counter is incremented to point to the next instruction in sequence (which is the add instruction in line 18).

There are other bits in the PSW that specify other types of information about the result of the previous operation (whether it is positive or negative, is too large for the registers to hold, and so on). As such, there are also other types of conditional branch instructions that check these bits. For instance, the `jumpn` instruction jumps to the target address if the result of the preceding arithmetic operation was negative; the `jumpo` instruction jumps to the target address if the result of the previous operation was too large and overflowed the register. If the machine language instruction format of the DLW-1 could accommodate more than eight possible instructions, we could add more types of conditional jumps.

#### Branch Instructions and the Fetch-Execute Loop
Now that we have looked at the basics of branching, we can modify our three- step summary of program execution to include the possibility of a branch instruction:

1. Fetch the next instruction from the address stored in the program counter, and load that instruction into the instruction register. Increment the program counter.
2. Decode the instruction in the instruction register.
3. Execute the instruction in the instruction register, using the following rules:
  * If the instruction is an arithmetic instruction, then execute it using the ALU and register file.
  * If the instruction is a memory-access instruction, then execute it using the memory hardware.
  * If the instruction is a branch instruction, then execute it using the control unit and the program counter. (For a taken branch, write the branch target address into the program counter.)

In short, you might say that branch instructions allow the programmer to redirect the processor as it travels through the instruction stream. Branches point the processor to different sections of the code stream by manipulating its control unit, which, because it contains the instruction register and pro- gram counter, is the rudder of the CPU.

#### The Branch Instruction as a Special Type of Load
Recall that an instruction fetch is a special type of `load` that happens automatically for every instruction and that always takes the address in the program counter as its source and the instruction register as its destination. With that in mind, you might think of a branch instruction as a similar kind of `load`, but under the control of the programmer instead of the CPU. The branch instruction is a load that takes the address specified by `#target` as its source and the instruction register as its destination.

Like a regular `load`, a branch instruction can take as its target an address stored in a register. In other words, branch instructions can use register-relative addressing just like regular `load` instructions. This capability is useful because it allows the computer to store blocks of code at arbitrary places in memory. The programmer doesn’t need to know the address at which a block of code will wind up before writing a branch instruction that jumps to that particular block; all he or she needs is a way to get to the memory location where the operating system, which is responsible for managing memory, has stored the starting address of the desired block of code.

Consider Program 2-3, in which the programmer knows that the operating system has placed the address of the branch target in line 17 in register `C`. Upon reaching line 17, the computer jumps to the address stored in C by copying the contents of C into the instruction register.

\begin{codelisting}
\label{code:program_2-3}
\codecaption{A conditional branch that uses an address stored in a register}
```
sub A, B, A   //Subtract the number in register A from the number in register B and store the result in A.
jumpz #C      //Check the PSW, and if the result of the previous instruction was zero, jump to the instruction at the address stored in C. If the result was nonzero, continue on to line 18.
add A, 15, A  //Add 15 to the number in A and store the result in A.
```
\end{codelisting}

When a programmer uses register-relative addressing with a branch instruction, the operating system must load a certain register with the base address of the _code segment_ in which the program resides. Like the data segment, the code segment is a contiguous block of memory cells, but its cells store instructions instead of data. So to jump to line 15 in the currently running program, assuming that the operating system has placed the base address of the code segment in C, the programmer could use the following instruction:

```
jump #(C + 30)  //Jump to the instruction located 30 bytes away from the start of the code segment. (Each instruction is 2 bytes in length, so this puts us at the 15 instruction.)
```

#### Branch Instructions and Labels
In programs written for real-world architectures, branch targets don’t usually take the form of either immediate values or register-relative values. Rather, the programmer places a _label_ on the line of code to which he or she wants to jump, and then puts that label in the branch’s target field. Program 2-4 shows a portion of assembly language code that uses labels.

\begin{codelisting}
\label{code:program_2-4}
\codecaption{Assembly language code that uses labels}
```
      sub A, B, A
      jumpz LBL1
      add A, 15, A
      store A, #(D + 16)
LBL1: add A, B, B
      store B, #(D + 16)
```
\end{codelisting}

In this example, if the contents of `A` and `B` are equal, the computer will jump to the instruction with the label LBL1 and begin executing there, skipping the instructions between the `jump` and the labeled `add`. Just as the absolute memory addresses used in `load` and `store` instructions are modified at load time to fit the location in memory of the program’s data segment, labels like LBL1 are changed at load time into memory addresses that reflect the location in memory of the program’s code segment.

## Excursus: Booting Up
If you’ve been around computers for any length of time, you’ve heard the terms reboot or boot up used in connection with either resetting the computer to its initial state or powering it on initially. The term boot is a shortened version of the term bootstrap, which is itself a reference to the seemingly impossible task a computer must perform on start-up, namely, “pulling itself up by its own bootstraps.”

I say “seemingly impossible,” because when a computer is first powered on there is no program in memory, but programs contain the instructions that make the computer run. If the processor has no program running when it’s first powered on, then how does it know where to fetch the first instruc- tion from?
The solution to this dilemma is that the microprocessor, in its power-on default state, is hard-wired to fetch that first instruction from a predetermined address in memory. This first instruction, which is loaded into the processor’s instruction register, is the first line of a program called the BIOS that lives in a special set of storage locations—a small read-only memory (ROM) module attached to the computer’s motherboard. It’s the job of the BIOS to perform basic tests of the RAM and peripherals in order to verify that everything is working properly. Then the boot process can continue.

At the end of the BIOS program lies a jump instruction, the target of which is the location of a _bootloader_ program. By using a `jump`, the BIOS hands off control of the system to this second program, whose job it is to search for and load the computer’s operating system from the hard disk. The _operating system_ (OS) loads and unloads all of the other programs that run on the computer, so once the OS is up and running the computer is ready to interact with the user.
