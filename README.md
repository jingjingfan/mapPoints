

# Grand Rapids MapPoints

Grand Rapids MapPoints is a racket program that takes coordinates from a file and displays the neighborhood in Grand Rapids to which they belong, if any.

## Requirements 

```bash
Dr. Racket / racket
Node
```

##Usage  

Ensure you have the following files in the same folder -

- main.rkt
- pip.rkt
- index.js
- neighborhoodPoly.rkt (generated by *index.js* with *gr_neighborhoods.txt*)
- gr_neighborhoods.txt
- test_points.txt (or any other .txt for testing)

```javascript
node index.js //will generate neighborhoodPoly.rkt 
OR
use provided neighborhoodPoly.rkt
```

```scheme
racket 
> (enter! "main.rkt")
OR
open main.rkt in Dr.Racket, hit RUN

;; to change test-point file, edit line 39 inside main.rkt
```

## Author / Contact

Jing Fan - jingjingfan@gmail.com

pip.rkt - rosettaCode

