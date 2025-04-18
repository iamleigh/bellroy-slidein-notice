/**
 * Supported Packages
 *
 * List here all dependencies necessary to run required tasks.
 */
const gulp = require("gulp");
const rename = require("gulp-rename");
const sass = require("gulp-sass")(require("sass"));
const cleanCSS = require("gulp-clean-css");
const postcss = require('gulp-postcss');
const autoprefixer = require('autoprefixer');
const header = require("gulp-header");
const mode = require("gulp-mode")();
const replace = require("gulp-replace");
const stylelint = require('gulp-stylelint');

/**
 * Paths & Files
 */
const fileName = "main.css";

const srcInput = {};
srcInput.img = "./src/assets/images/";
srcInput.css = "./src/assets/styles/";

const srcOutput = {};
srcOutput.css = "./public/";
srcOutput.img = "./public/images/";

/**
 * Copyright Banner
 */
const banner = [
	"/*!",
	" * Bellroy Slide-in Notice (" + fileName + ")",
	" * ",
	" * Copyright 2025 Leighton Quito (https://iamleigh.com/)",
	" * Licensed under MIT (https://github.com/iamleigh/bellroy-slidein-notice/blob/master/LICENSE)",
	" */",
	"",
].join("\n");

/**
 * List of Supported Browsers
 */
const browsersList = ["last 2 version", "> 1%"];

/**
 * 📦 Build CSS
 *
 * - Linter issues
 * - Concat files into one
 * - Minify concated file
 */
gulp.task("styles", function () {
	return (
		gulp
			.src(srcInput.css + "**/*.scss")
			.pipe(stylelint({
				reporters: [{
					formatter: 'string',
					console: true
				}]
			}))
			.pipe(sass({ outputStyle: "expanded" }).on("error", sass.logError))
			.pipe(postcss([autoprefixer(browsersList)]))
			.pipe(header(banner))
			.pipe(gulp.dest(srcOutput.css))
			.pipe(mode.production(cleanCSS()))
			.pipe(mode.production(rename({ suffix: ".min" })))
			.pipe(mode.production(gulp.dest(srcOutput.css)))
			.on("finish", async function () {
				console.log("📦 Finished compiling styles.");

				if (mode.production()) {
					console.log("🧹 Cleaning up unminified .css files...");

					const del = await import('del');
					await del.deleteAsync([
						srcOutput.css + "*.css",
						"!" + srcOutput.css + "*.min.css"
					]);

					console.log("✅ Only .min.css files kept.");
				}
			})
	);
});

/**
 * 🖼️ Copy Images
 *
 * Copies images from source to public folder.
 */
gulp.task("images", function () {
	return gulp
		.src(srcInput.img + "**/*.{png,jpg,jpeg,svg,gif}", { buffer: true, encoding: false })
		.pipe(gulp.dest(srcOutput.img))
		.on("finish", async function () {
            console.log("🖼 Finished copying images.");

			if (mode.production()) {
				const { default: imagemin, optipng, mozjpeg, svgo } = await import('gulp-imagemin');

				imagemin([
					optipng({ optimizationLevel: 5 }),
					mozjpeg({ quality: 80, progressive: true }),
					svgo({
						plugins: [
							{ removeViewBox: false },
							{ cleanupIDs: false }
						]
					})
				]);

				console.log("✅ Finished compressing files.");
			}
        });
});

/**
 * 🔥 Clean-up
 *
 * Removes all compiled CSS files and copied images in order to avoid conflicts
 * with old files that still remains.
 */
gulp.task("clean", async function () {
	const del = await import('del');
	console.log('🧹 Deleting styles in:', srcOutput.css + '*.css');
	console.log('🧹 Deleting images in:', srcOutput.img + '**/*');

	const deletedPaths = await del.deleteAsync([
		srcOutput.css + '*.css',
		srcOutput.img,
	]);
	console.log('✅ Deleted:', deletedPaths);
});

/**
 * 📄 Update HTML
 *
 * Ensures `index.html` listens to the correct styles
 * depending on project mode.
 */
gulp.task("html", function () {
	return (
		gulp
			.src("src/index.html")
			.pipe(mode.development(replace("main.min.css", "main.css")))
			.pipe(mode.production(replace("main.css", "main.min.css")))
			.pipe(gulp.dest("public"))
			.on("finish", function() {
				console.log("📝 Finished updating index.");

				if (mode.production()) {
					console.log("✅ Now listening `main.min.css` file");
				} else {
					console.log("✅ Now listening `main.css` file");
				}
			})
	);
});

/**
 * 🧑🏻‍💻 Watch Changes
 *
 * Task written for development mode.
 */
gulp.task("watch", function () {
	// Watch styles changes
	gulp.watch(srcInput.css + "**/**/**/*.scss", gulp.series(["styles"]));

	// Watch images changes
	gulp.watch(srcInput.img + "**/*", gulp.series(["images"]));
});

/**
 * 📦 Build
 *
 * Task written for production mode.
 */
gulp.task("build", gulp.series(["clean", "styles", "images", "html"]));
