fn make-test { |name test-input expected|
  var test-function = {}
  eval "set test-function = {\n    var test = [\n      &name=\""$name"\"\n      &expected=\""$expected"\"\n    ]\n    try {\n      use ./solution\n      put (assoc $test actual (solution:hey \""$test-input"\"))\n    } catch error {\n      fail (assoc $test message $error)\n    }\n  }"
  put $test-function
}

fn tests {
  put [
    (make-test "stating something" "Tom-ay-to, tom-aaaah-to." "Whatever.")
    (make-test "shouting" "WATCH OUT!" "Whoa, chill out!")
  ]
}

