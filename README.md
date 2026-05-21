# Library Management System in 8086 Assembly Language

## Overview

This project is a console-based **Library Management System** developed in **8086 Assembly Language** for the :contentReference[oaicite:0]{index=0} course.  
The system demonstrates low-level programming concepts including memory management, DOS interrupts, procedures, loops, conditional branching, and string handling.

The application provides a menu-driven interface where users can manage books efficiently through various operations such as adding, searching, issuing, returning, and deleting books. :contentReference[oaicite:1]{index=1}

---

# Features

- Add New Books
- Search Book by ID
- Display All Books
- Delete Book Records
- Issue Books
- Return Books
- Menu-Driven Interface
- Book Availability Tracking
- Console-Based User Interaction

---

# Technologies Used

- 8086 Assembly Language
- EMU8086
- DOS Interrupts (INT 21H)
- BIOS Interrupts (INT 10H, INT 16H)

---

# Core Concepts Implemented

This project demonstrates the implementation of:

- Arrays and Memory Addressing
- Procedures and Modular Programming
- String Manipulation
- Conditional Jumps
- Loops
- Register Operations
- User Input/Output Handling
- DOS Interrupt Services
- BIOS Interrupt Services

---

# System Modules

## 1. Add Book Module
Allows the user to:
- Enter Book Title
- Enter Author Name
- Enter Book ID

The system stores all data in memory arrays.

---

## 2. Search Book Module
Searches for a book using its unique ID and displays:
- Book ID
- Title
- Author
- Availability Status

---

## 3. Display All Books Module
Displays all stored books with complete details.

---

## 4. Delete Book Module
Deletes a book record using Book ID.

---

## 5. Issue Book Module
Marks a book as issued if available.

---

## 6. Return Book Module
Returns previously issued books and updates availability status.

---

# Data Structures Used

| Variable | Purpose |
|---|---|
| `bookTitle` | Stores book titles |
| `bookAuthor` | Stores author names |
| `bookID` | Stores unique book IDs |
| `bookAvail` | Tracks availability status |
| `bookCount` | Stores total number of books |

---

# Interrupts Used

| Interrupt | Purpose |
|---|---|
| `INT 21H` | DOS Services |
| `INT 10H` | Screen Handling |
| `INT 16H` | Keyboard Input |

---

# Program Workflow

```text
START
   ↓
Display Menu
   ↓
Take User Choice
   ↓
Perform Selected Operation
   ↓
Return to Menu
   ↓
Exit Program
```

---

# Sample Menu

```text
======================================
 LIBRARY MANAGEMENT SYSTEM - 8086
======================================

 [1] Add New Book
 [2] Search Book by ID
 [3] Display All Books
 [4] Delete Book by ID
 [5] Issue Book
 [6] Return Book
 [7] Exit
```

---

# Project Objectives

The main objective of this project is to understand:
- Low-level software development
- Interaction between hardware and software
- Memory organization
- CPU register manipulation
- Interrupt handling
- Assembly-level problem solving

---

# Learning Outcomes

After completing this project, the following skills were strengthened:

- Assembly Language Programming
- Debugging Low-Level Code
- Memory Management
- Logical Problem Solving
- Procedure-Based Programming
- Understanding DOS Architecture

---

# Future Improvements

Possible future enhancements include:

- File Handling for Permanent Storage
- Login Authentication System
- Better User Interface
- Sorting and Filtering Features
- Fine Calculation for Late Returns
- Student Management System
- Graphical User Interface (GUI)

---

# Screenshots

## Main Menu
![Main Menu] screenshots/main-menu.png

## Add Book Screen
![Add Book Screen] screenshots/add-book.png

## Search Book Screen
![Search Book Screen] screenshots/search-book.png

---

# How to Run

## Using EMU8086

1. Open EMU8086
2. Load the `.asm` file
3. Compile the program
4. Run the executable

---

# Repository Structure

```text
Library-Management-System-8086/
│
├── src/
│   └── Library_Management.asm
│
├── screenshots/
│   ├── main-menu.png
│   ├── add-book.png
│   └── search-book.png
│
├── README.md
└── project-report.pdf
```

---

# Author

**Ghufran Ahmad - Muntazir Ali**

---

# License

This project is created for educational purposes.

---

# Tags

`8086` `Assembly Language` `COAL` `EMU8086` `Library Management System` `DOS Programming` `Low-Level Programming`
