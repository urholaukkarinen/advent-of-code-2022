(defvar vals nil)
(defvar current 0)

(with-open-file (stream "input.txt")
    (loop for line = (read-line stream nil)
        while line do 
        (if (not (zerop (length line)))
            (setq current (+ current (parse-integer line)))
            (progn
                (setq vals (cons current vals))
                (setq current 0)
            )
        )
    )
)

; why doesn't '> sort in descending order???
(sort vals '<)
(setq vals (reverse vals))

; part 1
(print (car vals))
; part 2
(print (apply '+ (subseq vals 0 3)))
