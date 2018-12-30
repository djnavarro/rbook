#! /bin/bash

echo "starting"
pdftk A=lsr-0.3.pdf cat A1-10 output lsr-0.3-frontmatter.pdf

echo "part 1"
pdftk A=lsr-0.3.pdf cat A11-12 output lsr-0.3-part-1.pdf
pdftk A=lsr-0.3.pdf cat A13-20 output lsr-0.3-chapter-01.pdf
pdftk A=lsr-0.3.pdf cat A21-42 output lsr-0.3-chapter-02.pdf

echo "part 2"
pdftk A=lsr-0.3.pdf cat A43-44 output lsr-0.3-part-2.pdf
pdftk A=lsr-0.3.pdf cat A45-76 output lsr-0.3-chapter-03.pdf
pdftk A=lsr-0.3.pdf cat A77-121 output lsr-0.3-chapter-04.pdf

echo "part 3"
pdftk A=lsr-0.3.pdf cat A113-114 output lsr-0.3-part-3.pdf
pdftk A=lsr-0.3.pdf cat A115-156 output lsr-0.3-chapter-05.pdf
pdftk A=lsr-0.3.pdf cat A157-194 output lsr-0.3-chapter-06.pdf
pdftk A=lsr-0.3.pdf cat A195-252 output lsr-0.3-chapter-07.pdf
pdftk A=lsr-0.3.pdf cat A253-268 output lsr-0.3-chapter-08.pdf

echo "part 4"
pdftk A=lsr-0.3.pdf cat A269-270 output lsr-0.3-part-4.pdf
pdftk A=lsr-0.3.pdf cat A271-294 output lsr-0.3-chapter-09.pdf
pdftk A=lsr-0.3.pdf cat A295-312 output lsr-0.3-chapter-10.pdf
pdftk A=lsr-0.3.pdf cat A313-336 output lsr-0.3-chapter-11.pdf

echo "part 5"
pdftk A=lsr-0.3.pdf cat A337-338 output lsr-0.3-part-5.pdf
pdftk A=lsr-0.3.pdf cat A339-362 output lsr-0.3-chapter-12.pdf
pdftk A=lsr-0.3.pdf cat A363-404 output lsr-0.3-chapter-13.pdf
pdftk A=lsr-0.3.pdf cat A405-436 output lsr-0.3-chapter-14.pdf
pdftk A=lsr-0.3.pdf cat A437-474 output lsr-0.3-chapter-15.pdf
pdftk A=lsr-0.3.pdf cat A475-530 output lsr-0.3-chapter-16.pdf

echo "finishing"
pdftk A=lsr-0.3.pdf cat A531-540 output lsr-0.3-chapter-17.pdf
pdftk A=lsr-0.3.pdf cat A541-542 output lsr-0.3-endmatter.pdf

