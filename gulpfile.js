const gulp = require('gulp');
const zip = require('gulp-zip');
 
gulp.task('zip', function() {
    return gulp.src('**/*.*')
        .pipe(zip('Monet-All.zip'))
        .pipe(gulp.dest('export'));
});
