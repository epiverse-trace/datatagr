# tests for set_labels()

    Code
      set_labels(cars)
    Condition
      Error in `set_labels()`:
      ! Assertion on 'x' failed: Must inherit from class 'safeframe', but has class 'data.frame'.

---

    Code
      set_labels(x, toto = "speed")
    Condition
      Error in `base::tryCatch()`:
      ! 1 assertions failed:
       * Variable 'namedLabel': Must be element of set {'speed','dist'}, but
       * is 'toto'.

