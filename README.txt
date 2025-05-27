[⚠️ Suspicious Content] MY VIDEOGAME PROJECT | TIC-TAC-TOE ❌ / ⭕ in RISC-V 🕹
Computing from the past

Let’s take a step back in time {

🖋️ Once upon a time... punched cards 📇🎟️
In the 1960s and 70s, before modern graphical interfaces and high-level languages were born, computers were programmed using punched cards,
also known as Hollerith cards or data storage cards.
📄 These were rigid cardboard cards, divided into 80 columns, each containing 2 rows of 40 characters,
capable of storing binary information:
1 or 0, that is, hole or no hole.
Each column consisted of 2 bits, meaning a pair of values that could take the form of ZERO or ONE, because computers can only operate by distinguishing between two values!
💡 Simple example
Let’s take this sentence:
"Electricity is flowing right now"

If electricity is flowing right now → then we assume the sentence is true → true

If electricity is NOT flowing right now → then we assume the sentence is false → false
So why zeros and ones?

1 corresponds to true and 0 corresponds to false!
This explains why we talk about bits (binary digits), and why all digital logic is based on this fundamental distinction: on/off, true/false, 1/0.
At the electronic level, this corresponds to the passage or non-passage of electrical current!

🛠️ But what were they really used for?
Punched cards were used to instruct the computer on what to do:
each card represented a set of commands to execute or data to process.
Imagine giving the computer a recipe: each card was like an ingredient or a preparation step.
More cards = an entire program.
They were used in universities 🏫, public institutions 🏛, banks 🏦, and large companies 🏢 to perform calculations, print documents, process payrolls, or store data.

}

Let’s talk about my project {

But from there on, it’s been a long journey! 🛣️
We moved from machine language programming, made up of incomprehensible 0️⃣s and 1️⃣s,
to Assembly language (with commands like: mv, la, add, sub, slli...),
a more “human” way of talking to the processor, although still very close 🖥️ to the hardware. 💻
It allowed for faster programming, but you still had to be an expert to do it.
When driving a car 🏎️, we don’t need to know, or at least fully understand, how the engine, differential ⚙️, ECU 🚗, etc. work.
We can drive without worrying about how the car is built.
Nowadays, it's possible to program ⌨️ without knowing the computer’s architecture, for example thanks to languages like Python, which simplify everything by self-managing many things.

Every processor has its own specific Assembly
(a well-defined list of commands and calculations it can perform),
designed to communicate directly with its internal architecture.
💾 For example, the famous Intel 8086, a symbol of the 1980s, used its own Assembly to handle registers, memory, and conditional jumps with great precision.

In those years, mass storage began to move away from punched cards, and data found homes on Floppy Disks and Hard Drives.

📍 It is in this fascinating context that my mini-project was born:
👉🏻 A TIC-TAC-TOE X/O game
developed in Assembly language for RISC-V architecture!
With music included

Short explanation:
In the first image, you can see only a part of the function whose goal is to understand when there’s a TIC-TAC-TOE and who made it.
The portion from line 481 to 508 is the beginning of this function.
Line 481 has the label that allows the function’s instructions to be executed, jumping from the call line to the target label and thus "calling" the function.
From lines 482 to 484, we save some registers (in modern languages we’d call them variables) into the stack, which is a LIFO (last-in, first-out) data structure—an element on top of another—where the oldest element is first on top, and the most recent is at the bottom.
This is because registers are limited and are used in the function, and their values will change over time. So (as I’ve decided), I’ll be able, at the end of the function or when needed, to restore the original data.
Lines 486/487 copy the value contained in a0 into registers s0 and t2.

ALL THE REST OF THIS CODE FRAGMENT IS DEDICATED TO CHECKING WHETHER THERE HAS BEEN A TIC-TAC-TOE ALONG ONE OF THE COLUMNS

[There are two other very similar sections to check for a Tic-Tac-Toe along one of the rows or diagonals]





}
