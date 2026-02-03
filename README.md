# Accessible LaTeX Syllabus System

Create fully accessible, Ally-compliant PDF syllabi directly from LaTeX without requiring manual PDF tag editing in Acrobat.

Extra things to think about...
* [Overleaf Project using pdflatex](https://www.overleaf.com/read/cbqcqtsnpbkb#247927)
* [Overleaf Project using LuaTex](https://www.overleaf.com/read/wtffzwyzbvnm#d0c6b9)
* Run ```kpsewhich tagpdf.sty ``` to unsure you can compile locally.
    * ```texlive-latex-extra``` will be needed.

## Overview

This project provides a reusable LaTeX system for generating accessible course syllabi with:
- Proper heading hierarchy (H1, H2, H3) for screen readers
- Tagged paragraphs and lists for document structure
- PDF metadata for accessibility
- Automated build process
- Modular course information for easy customization

## Project Structure

```
.
├── README.md                           # This file
├── Makefile                            # Build automation
├── preamble.tex                        # Document setup & metadata
├── course-info.tex                     # Static course information (EDIT THIS)
├── accessible-syllabus.sty             # Reusable LaTeX package with commands
├── sping.2026.math.0481.001.syllabus.tex  # Main syllabus document
└── sping.2026.math.0481.001.syllabus.pdf  # Generated output
```

## Quick Start

### Prerequisites

- **LuaLaTeX** (required for accessibility tagging via tagpdf)
- **make** (for command-line builds, optional for GUI editors)
- Standard LaTeX packages (included in most TeX distributions)

### Building the PDF: Command Line

```bash
# Build the syllabus
make

# Clean intermediate files
make clean

# Remove all generated files including PDF
make distclean

# Show all available commands
make help
```

### Building the PDF: TeXworks or Other GUI

1. **Open** the main syllabus `.tex` file
2. **Select Compiler**: Choose **LuaLaTeX** from the typesetter dropdown (required!)
3. **Compile**: Click the green play button or press Ctrl+T
4. **Compile Again**: Click compile a second time for proper cross-references

> **Important**: The system requires **LuaLaTeX** — do not use pdfLaTeX, XeLaTeX, or other engines. The accessibility tagging only works with LuaLaTeX.

## Customization Guide

### Step 1: Edit Course Information

Open `course-info.tex` and update all course variables:

```tex
\def\CourseNumber{MATH 0481}
\def\CourseTitle{Foundations for College Mathematics I}
\def\InstructorName{Michael McCabe}
\def\InstructorEmail{mccabem85@cod.edu}
% ... and other fields
```

### Step 2: Customize the Main Document

Edit the main syllabus `.tex` file:

- Update learning outcomes
- Add course policies and grading criteria
- Customize any course-specific content
- All course information automatically pulls from `course-info.tex`

### Step 3: Build and Test

```bash
make build    # Clean rebuild
```

Test in Ally/Blackboard to verify accessibility score.

## Editor-Specific Instructions

### TeXworks

TeXworks is fully compatible with this system. Follow these steps:

1. **Open the main syllabus file** in TeXworks
2. **Set the engine to LuaLaTeX**:
   - Look for the dropdown at the top (usually shows "pdfLaTeX")
   - Click it and select **LuaLaTeX**
3. **Compile twice**:
   - Click the green "Typeset" button (or press Ctrl+T)
   - When done, click it again to ensure proper cross-references
4. The PDF will appear in the adjacent viewer panel

**Tip**: You can set LuaLaTeX as your default engine in Edit → Preferences → Typesetting.

### Overleaf

Overleaf is also compatible:

1. Create a new project and upload all `.tex` and `.sty` files
2. In the top-left menu, select **LuaLaTeX** as the compiler
3. Click "Recompile"
4. Download the PDF

### Command Line (Advanced Users)

```bash
make build
```

Or manually:
```bash
lualatex -interaction=nonstopmode syllabus.tex
lualatex -interaction=nonstopmode syllabus.tex
```

## File Descriptions

### `preamble.tex`
- Initializes document class with accessibility metadata
- Loads the `accessible-syllabus.sty` package
- Sets up PDF metadata and headers/footers
- **Do not edit** unless customizing document setup

### `course-info.tex`
- Contains all static course and instructor information as LaTeX variables
- **Primary file to customize** for each new course
- Variables are referenced throughout the main document
- Easy to find-and-replace for quick course updates

### `accessible-syllabus.sty`
- Reusable LaTeX package with all custom commands and environments
- **Provides convenient commands** that handle tagging automatically:
  - `\syllabussection{Title}` — Create H2 headings
  - `\syllabussubsection{Title}` — Create H3 subheadings
  - `\begin{taggedparagraph}...\end{taggedparagraph}` — Tag paragraphs
  - `\begin{taggeditemize}...\end{taggeditemize}` — Tag lists
  - `\begin{topicaloutline}...\end{topicaloutline}` — Tag a topical outline (week-by-week or topic list)
- Can be included in other syllabus projects
- **Do not edit** unless extending functionality

### Main Syllabus Document (`.tex`)
- Imports `preamble.tex` and `course-info.tex`
- Contains course description, learning outcomes, and policies
- Structured with semantic tags for accessibility

### `Makefile`
- Automates PDF generation with `lualatex`
- Runs compiler twice for proper cross-references
- Cleans intermediate build artifacts
- No customization needed

## Accessibility Features

### Semantic Structure
- **H1 tags**: Document title
- **H2 tags**: Major sections (Course Information, Instructor Info, etc.)
- **H3 tags**: Subsections (Course Details, Prerequisites, etc.)
- **P tags**: Paragraphs and lists for proper document flow

### PDF Compliance
- Language metadata (`lang=en`)
- Author and subject information in PDF properties
- Hyperlinked email addresses
- Proper list tagging for screen readers

### Using the Stylesheet Commands

Instead of manually writing raw `taggedstructure` environments, use the convenience commands from `accessible-syllabus.sty`:

**For Headings:**
```tex
\syllabussection{Course Information}        % Creates H2 heading

\syllabussubsection{Course Details}         % Creates H3 subheading
```

**For Content:**
```tex
\begin{taggedparagraph}
Your paragraph text here. This is automatically tagged for accessibility.
\end{taggedparagraph}

\begin{taggeditemize}
\item Bullet point 1
\item Bullet point 2
\item Bullet point 3
\end{taggeditemize}

\begin{taggedenumerate}
\item Numbered item 1
\item Numbered item 2
\end{taggedenumerate}

```tex
\begin{topicaloutline}
\item Week 1: Intro to sets
\item Week 2: Operations with signed numbers
\end{topicaloutline}
```
```

See the main syllabus document for real-world examples of how these commands are used together.

## Creating Multiple Syllabi

To create a syllabus for a different course:

1. **Copy the entire directory**:
   ```bash
   cp -r latexSyllabusAccessible fall.2026.psych.101.001.syllabus
   ```

2. **Rename the main document** to match your course code

3. **Edit `course-info.tex`** with new course details

4. **Build**:
   ```bash
   make
   ```

The `preamble.tex`, `accessible-syllabus.sty`, and `Makefile` are generic and work for any course.

## Git Configuration

The `.gitignore` file tracks the following:

- **Source files** (`.tex`, `.sty`) — always tracked
- **PDF outputs** — currently tracked for convenience (instructors can pull and use immediately)
- **Build artifacts** (`.aux`, `.log`, `.fdb_latexmk`, etc.) — ignored to keep repo clean

**To exclude PDFs from tracking** (if you prefer source-only):
```bash
# Uncomment the *.pdf line in .gitignore
sed -i 's/^# \(\*.pdf\)/\1/' .gitignore
git rm --cached *.pdf
git commit -m "Stop tracking PDFs"
```

## Troubleshooting

### PDF not building
- Ensure LuaLaTeX is installed: `lualatex --version`
- Check for LaTeX errors: `make` will show compilation errors
- Review the `.log` file for detailed error messages

### Ally score not 100%
- Verify all content is wrapped in tagged environments
- Check that `\DocumentMetadata{lang=en}` is at the top of `preamble.tex`
- Ensure the PDF is compiled with `lualatex` (not `pdflatex`)
- Test the PDF in Ally to identify remaining issues

### Missing variables in output
- Confirm all `\def` commands in `course-info.tex` are properly formatted
- Verify variable names match the usage in main document
- Run `make clean && make` to rebuild with fresh definitions

## Advanced Usage

### Extending the Package

To add custom commands to `accessible-syllabus.sty`, use the convenience commands:

```tex
\newcommand{\mygradingscale}[1]{
  \syllabussubsection{Grading Scale}
  \begin{taggedparagraph}
  #1
  \end{taggedparagraph}
}
```

Then use in your main document:
```tex
\mygradingscale{A: 90-100\%, B: 80-89\%, C: 70-79\%, ...}
```

The stylesheet commands (`\syllabussection`, `\syllabussubsection`, `\begin{taggedparagraph}`, etc.) automatically handle all the accessibility tagging internally, so you don't need to worry about `\begin{taggedstructure}{H2}` and similar raw commands.

### Multi-semester Templates

Create variants for different course types (lecture, lab, hybrid, etc.) and reuse across semesters.

## References

- [tagpdf documentation](https://ctan.org/pkg/tagpdf) - Accessibility tagging
- [Ally Standards](https://www.blackboard.com/accessibility) - Blackboard integration
- [LaTeX Project](https://www.latex-project.org/) - General LaTeX help

## License

This project is provided as-is for educational use.
