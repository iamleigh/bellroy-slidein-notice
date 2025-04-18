# Bellroy Code Challenge

Welcome! 👋

This project is my code challenge submission for Bellroy, where I have recreated
a component from [bellroy.com](bellroy.com) using **Elm**.

The project demonstrates:

- Well-structured Elm code
- Componentized views
- External data fetching
- Basic responsive setup
- Maintainable architecture
- Test coverage for components and main application logic

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
