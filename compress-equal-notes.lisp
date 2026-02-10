(in-package :Opusmodus)

;;; ----------------+----------------------------+------------------------------------------------
;;; Compress Equal Notes Extension
;;; Author: Arthur Stammet
;;; Created: November 2025
;;; Location: ~/Opusmodus/User Source/Extensions/
;;; ----------------+----------------------------+------------------------------------------------
;;; Overview:
;;; Performs run-length encoding on a list of notes.
;;; Consecutive identical notes are compressed into:
;;;   - a pitch list (unique notes when they change)
;;;   - a length list (number of repetitions)
;;; Depending on MODE, returns:
;;;   'notes          → pitch list only
;;;   'lengths        → repetition counts only
;;;   'vector-lengths → repetition counts normalized to floats in [0,1]
;;;
;;; Function:
;;;   (compress-notes notes &key mode)
;;;
;;; Usage Examples:
;;;   (setq my-notes '(a3 a3 a3 c4 b2 b2 eb3 eb3 eb3 eb3 g5))
;;;
;;;   ;; Notes only
;;;   (compress-notes my-notes :mode 'notes)
;;;   ;; → (a3 c4 b2 eb3 g5)
;;;
;;;   ;; Lengths only
;;;   (compress-notes my-notes :mode 'lengths)
;;;   ;; → (3 1 2 4 1)
;;;
;;;   ;; Normalized vector lengths
;;;   (compress-notes my-notes :mode 'vector-lengths)
;;;   ;; → (0.75 0.25 0.5 1.0 0.25)
;;; ----------------+----------------------------+------------------------------------------------

;;; ----------------+----------------------------+------------------------------------------------
;;; Cheat-Sheet: Compress Notes Modes
;;; ----------------+----------------------------+------------------------------------------------
;;; Mode            | Behaviour                  | Example Input → Output
;;; ----------------+----------------------------+------------------------------------------------
;;; 'notes          | Return pitch list only     | (compress-notes my-notes :mode 'notes)
;;;                 |                            | → (a3 c4 b2 eb3 g5)
;;;
;;; 'lengths        | Return repetition counts   | (compress-notes my-notes :mode 'lengths)
;;;                 |                            | → (3 1 2 4 1)
;;;
;;; 'vector-lengths | Return normalized floats   | (compress-notes my-notes :mode 'vector-lengths)
;;;                 | (scaled to max = 1.0)      | → (0.75 0.25 0.5 1.0 0.25)
;;; ----------------+----------------------------+------------------------------------------------

(defun compress-equal-notes (notes &key mode)

  (let ((result-notes '())
        (result-lengths '()))
    (labels ((process (remaining current count)
               (cond
                 ((null remaining)
                  (push current result-notes)
                  (push count result-lengths))
                 ((equal (car remaining) current)
                  (process (cdr remaining) current (1+ count)))
                 (t
                  (push current result-notes)
                  (push count result-lengths)
                  (process (cdr remaining) (car remaining) 1)))))
      (when notes
        (process (cdr notes) (car notes) 1))
      (setq result-notes (nreverse result-notes))
      (setq result-lengths (nreverse result-lengths))
      ;; Dispatch depending on mode
      (case mode
        ('notes   result-notes)
        ('lengths result-lengths)
        ('vector-lengths  (let ((maxval (apply #'max result-lengths)))
                    (mapcar (lambda (x) (/ (float x) maxval))
                            result-lengths)))))))


