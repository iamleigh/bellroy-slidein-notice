# 🧩 Sample Elm UI Project – Component Architecture

This repository is a **self‑contained code sample** designed to demonstrate my ability
to build modular, scalable, and testable front‑end applications using **Elm**.

Originally built as part of a coding exercise, it has been adapted as a showcase
for recruiters and engineering teams to evaluate my technical capabilities and coding style.

The project demonstrates:

- 📐 Well‑structured Elm code with modular architecture
- 🧱 Componentized views and layouts with clear separation of concerns
- 🌐 External data fetching and JSON decoding
- 📱 Responsive design considerations
- 🛠️ Maintainable architecture with reusable utilities
- 🧪 Automated test coverage for both components and core application logic

---

## 🌐 Live Preview

If you’d prefer to explore the project without installing dependencies locally,  
you can view the hosted version here:<br/>
👉 [Live Preview on GitHub Pages](https://iamleigh.github.io/bellroy-slidein-notice/)

---

## 🧠 Why am I sharing this?

This repository serves as a **code sample** for recruiters and engineering teams to evaluate my:

- Adaptability to transfer my JavaScript, React, and TypeScript expertise into new environments
- Ability to architect modular, testable, and scalable applications
- Attention to design systems, UI consistency, and DX (Developer Experience)
- Skills in balancing responsiveness, performance, and maintainability

---

## 🧑‍💻 Key Technical Highlights

- 💼 **Role**: Sole developer and architect of this project
- 🏗️ **Component Architecture**: Organized into `Components`, `Layouts`, `Models`, and `Utils` for scalability
- 🔄 **Reusable Patterns**: Each UI element follows functional principles and reusability in Elm
- 🌐 **Data Integration**: Dynamically fetches and decodes JSON data from the `public/` folder
- 📐 **Design System Thinking**: Emphasis on separation of logic and UI with a consistent visual language
- 🧪 **Testing**: Coverage for critical flows and UI elements with `elm-test`
- 🎨 **Styling**: SCSS compiled and optimized, with responsiveness in mind

---

## ✨ Key Ecosystem Highlights

- ⚡ **Elm Framework**: Purely functional, type-safe language for reliable UI development
- 🧪 **elm-test**: For robust, predictable unit testing
- 🛠️ **elm-review**: Ensures code quality and consistency
- 🎨 **SCSS + Prettier**: Organized styling pipeline with formatting enforcement
- ⚙️ **Gulp Build System**: Custom build pipeline for SCSS and asset management
- 📂 **Maintainable Structure**: Clear separation of concerns for long-term maintainability

---

## 📦 Project Structure

```bash
src/
  ├── Components/
  │     ├── Button.elm
  │     ├── Product.elm
  │     ├── Products.elm
  │     └── SlideInNotice.elm
  ├── Layouts/
  │     ├── Body.elm
  │     └── Header.elm
  ├── Models/
  │     └── Product.elm
  ├── Utils/
  │     └── Email.elm
  └── Main.elm

tests/
  ├── Components/
  │     ├── ButtonTest.elm
  │     └── ProductsTest.elm
  └── MainTest.elm

public/
  └── data/
         └── products.json
```

## 🚀 How to Run It

### 1. Install dependencies

Make sure you have [Node.js](https://nodejs.org/) and Elm installed.

Then inside the project root folder, run:

```bash
npm install
```

### 2. Start the development server (local dev)

To run the project with live reload for Elm and CSS:

```bash
npm run dev
```

This will:

- Build initial CSS and assets
- Watch `.elm` and `.scss` files
- Start a local server (`elm-live`) serving from `public/`
- Open your default browser

You can develop normally from here!

### 3. Build for production

To generate the optimized production build:

```bash
npm run prod
```

This will:

- Build and minify the CSS
- Compile Elm for production (--optimize)
- Output everything ready to serve from the public/ folder

### 4. Run tests

Tests are written with **elm-test**.

```bash
npm run test
```

This will execute unit tests for:
- Button components
- Products rendering
- Main application logic

### 5. Format code

To automatically format Elm and SCSS code:

```bash
npm run format
```

This runs:
- `elm-format` on `src/` and `tests/`
- `prettier` on SCSS files

### 6. Lint Elm code

To lint Elm code with `elm-review`:

```bash
npm run lint
```

---

## ✅ Submission Criteria Alignment

| ✅ Requirement                               | 💬 Explanation                                                                                          |
|---------------------------------------------|------------------------------------------------------------------------------------------------------|
| **Semantic HTML**                           | Elm views generate semantic HTML with proper tags and ARIA-friendly structures for accessibility. |
| **CSS and custom UI architecture**          | Styling is handcrafted with SCSS and follows modular, reusable patterns; no CSS frameworks used. |
| **Component architecture**                  | Organized into `Components`, `Layouts`, `Models`, and `Utils` for clarity, scalability, and separation of concerns. |
| **Design & QA**                             | Includes responsive layouts, SCSS pipeline, and test coverage for key components and logic with `elm-test`. |
| **JavaScript without jQuery**               | Pure Elm implementation, showing ability to work without legacy libraries. |
| **React (analogous experience)**            | Demonstrates transferable skills from React and TypeScript into Elm, highlighting adaptability. |
| **Accessibility (nice to have)**            | Semantic markup ensures screen readers and assistive technologies can parse key content effectively. |

---

## 📂 What to Look For

- Review the **component folders** (`Components`, `Layouts`, `Models`, `Utils`) to see modular Elm architecture in practice.
- Inspect **test files** to evaluate coverage for components and application logic using `elm-test`.
- Note the **SCSS pipeline** for handcrafted styles with responsiveness in mind.
- Observe how **logic and view layers** are kept separate for maintainability.
- Check **public/data/products.json** integration for real‑world data handling and decoding in Elm.

If you'd like to dive deeper into any piece, I'd be happy to walk you through it.

— **Leighton Quito**