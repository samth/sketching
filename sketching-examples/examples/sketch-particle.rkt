#lang sketching
(require racket/match)

(struct particle (x y vx vy ax ay α))

(define (not-black? p)
  (> (particle-α p) 0))

(define (update-particle p)
  (match-define (particle x y vx vy ax ay α) p)
  (particle (+ x vx) (+ y vy) (+ vx ax) (+ vy ay) ax ay (max (- α 2) 0)))

(define (new-particle [x 300] [y 300] [vx (random -1 1)] [vy (random -1 -10)] [ax 0] [ay 0.1])
  (particle x y vx vy ax ay 255))

(define (draw-particle p)
  (match-define (particle x y vx vy ax ay α) p)
  (fill (random 255) 255 255 α)
  (circle x y 5))

(define particles '())

(define (add-particle! p)
  (set! particles (cons p particles)))

(define (update-particles!)
  (set! particles
        (filter not-black?
                (map update-particle particles))))

(define (setup)
  (frame-rate 30)
  (size 600 400)
  (color-mode 'hsb 255 255 255))

(define (mouse-pressed)
  (for ([i 10])
    (add-particle! (new-particle mouse-x mouse-y))))


(define (draw)  
  (background 0)
  (no-stroke)
  (map draw-particle particles)
  (update-particles!)
  (add-particle! (new-particle 100 400))
  (add-particle! (new-particle 200 400))
  (add-particle! (new-particle 300 400))
  (add-particle! (new-particle 400 400))
  (add-particle! (new-particle 500 400)))
